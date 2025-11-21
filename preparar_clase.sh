#!/bin/bash

# Definimos el directorio base de la misión
BASE_DIR="$HOME/task1"

# 1. Limpieza previa (por si se ejecuta varias veces)
if [ -d "$BASE_DIR" ]; then
    echo "Borrando versión anterior de la misión..."
    rm -rf "$BASE_DIR"
fi

# 2. Crear estructura de directorios
echo "Creando directorios..."
mkdir -p "$BASE_DIR/logs"
mkdir -p "$BASE_DIR/www"
mkdir -p "$BASE_DIR/bin"

# 3. Nivel 1: Crear archivo oculto (Pista inicial)
echo "Soy el hacker. He desactivado el servidor y cambiado la web. Busca en los logs si te atreves." > "$BASE_DIR/.notas_del_hacker.txt"

# 4. Nivel 2: Archivos web
echo "<html><body><h1>SITIO HACKEADO</h1></body></html>" > "$BASE_DIR/www/index.html"
# Creamos un archivo de config protegido contra escritura (solo lectura)
echo "<?php db_password = 'admin'; ?>" > "$BASE_DIR/www/config.php"
chmod 444 "$BASE_DIR/www/config.php"

# 5. Nivel 3: Generar Logs (Aguja en un pajar)
echo "Generando logs falsos..."
# Rellenamos access.log con ruido
for i in {1..300}; do
    echo "INFO [$(date +%F)] 192.168.1.$((RANDOM%255)) GET /index.html 200 OK" >> "$BASE_DIR/logs/access.log"
done

# Rellenamos error.log con ruido y la PISTA CLAVE escondida
for i in {1..150}; do
    echo "WARN [$(date +%F)] Deprecated function usage at line $i" >> "$BASE_DIR/logs/error.log"
done
# Esta es la línea que deben encontrar con GREP
echo "FATAL [$(date +%F)] SERVER CRASH - CODE: SECRET_KEY_777" >> "$BASE_DIR/logs/error.log"
# Más ruido después
for i in {151..300}; do
    echo "WARN [$(date +%F)] Memory leak detected at block $i" >> "$BASE_DIR/logs/error.log"
done

# 6. Nivel 4: El script de reparación (Sin permisos de ejecución)
SCRIPT_FILE="$BASE_DIR/bin/reiniciar_servidor.sh"
cat <<EOT >> "$SCRIPT_FILE"
#!/bin/bash
echo "---------------------------------------------------"
echo "Inicializando protocolos de recuperación..."
sleep 1
echo "Verificando integridad del sistema..."
sleep 1
echo "¡ÉXITO! El servidor web se ha reiniciado correctamente."
echo "Buen trabajo, Admin. Has salvado el día."
echo "---------------------------------------------------"
EOT

# IMPORTANTE: Quitamos el permiso de ejecución
chmod -x "$SCRIPT_FILE"

echo "======================================================="
echo "¡ESCENARIO LISTO!"
echo "La actividad se ha creado en: $BASE_DIR"
echo "Instrucciones para los alumnos:"
echo "1. Escribid: cd ~/mision_rescate"
echo "2. ¡Que empiece el juego!"
echo "======================================================="
