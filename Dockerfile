
# Use the lightweight Alpine-based JRE for reduced vulnerabilities and image size
FROM eclipse-temurin:17-jre-alpine AS base

# Set up a non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy the Spring Petclinic JAR file
COPY ./spring-petclinic-3.2.0-SNAPSHOT.jar /app/spc.jar

# Switch to the non-root user
USER appuser

# Expose the application port
EXPOSE 8080

# Add a health check to monitor the application’s health
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD curl -f http://localhost:8080/actuator/health || exit 1

# Start the Spring Petclinic application
CMD ["java", "-jar", "/app/spc.jar"]

