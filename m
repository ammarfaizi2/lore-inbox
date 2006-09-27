Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWI0RCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWI0RCp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 13:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWI0RAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 13:00:33 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:30719 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1030250AbWI0Q7v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 12:59:51 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Victor <andrew@sanpeople.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       hskinnemoen@atmel.com
Subject: [PATCH 3/8] at91_serial -> atmel_serial: Kconfig symbols
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Wed, 27 Sep 2006 18:58:00 +0200
Message-Id: <11593762851735-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.1.1
In-Reply-To: <11593762852168-git-send-email-hskinnemoen@atmel.com>
References: <1159376285670-git-send-email-hskinnemoen@atmel.com> <115937628584-git-send-email-hskinnemoen@atmel.com> <11593762852168-git-send-email-hskinnemoen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the following Kconfig symbols:
  * CONFIG_SERIAL_AT91 -> CONFIG_SERIAL_ATMEL
  * CONFIG_SERIAL_AT91_CONSOLE -> CONFIG_SERIAL_ATMEL_CONSOLE
  * CONFIG_SERIAL_AT91_TTYAT -> CONFIG_SERIAL_ATMEL_TTYAT

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/arm/configs/at91rm9200dk_defconfig |    6 +++---
 arch/arm/configs/at91rm9200ek_defconfig |    6 +++---
 arch/arm/configs/ateb9200_defconfig     |    6 +++---
 arch/arm/configs/carmeva_defconfig      |    4 ++--
 arch/arm/configs/csb337_defconfig       |    6 +++---
 arch/arm/configs/csb637_defconfig       |    6 +++---
 arch/arm/configs/kafa_defconfig         |    6 +++---
 arch/arm/configs/kb9202_defconfig       |    4 ++--
 arch/arm/configs/onearm_defconfig       |    6 +++---
 arch/arm/mach-at91rm9200/devices.c      |    2 +-
 arch/avr32/configs/atstk1002_defconfig  |    6 +++---
 drivers/serial/Kconfig                  |   14 +++++++-------
 drivers/serial/Makefile                 |    2 +-
 drivers/serial/atmel_serial.c           |    6 +++---
 include/asm-arm/mach/serial_at91.h      |    2 +-
 include/asm-avr32/mach/serial_at91.h    |    2 +-
 16 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/arm/configs/at91rm9200dk_defconfig b/arch/arm/configs/at91rm9200dk_defconfig
index 4f3d8d3..c82e466 100644
--- a/arch/arm/configs/at91rm9200dk_defconfig
+++ b/arch/arm/configs/at91rm9200dk_defconfig
@@ -553,9 +553,9 @@ # CONFIG_SERIAL_8250 is not set
 #
 # Non-8250 serial port support
 #
-CONFIG_SERIAL_AT91=y
-CONFIG_SERIAL_AT91_CONSOLE=y
-# CONFIG_SERIAL_AT91_TTYAT is not set
+CONFIG_SERIAL_ATMEL=y
+CONFIG_SERIAL_ATMEL_CONSOLE=y
+# CONFIG_SERIAL_ATMEL_TTYAT is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/configs/at91rm9200ek_defconfig b/arch/arm/configs/at91rm9200ek_defconfig
index 08b5dc3..b983fc5 100644
--- a/arch/arm/configs/at91rm9200ek_defconfig
+++ b/arch/arm/configs/at91rm9200ek_defconfig
@@ -534,9 +534,9 @@ # CONFIG_SERIAL_8250 is not set
 #
 # Non-8250 serial port support
 #
-CONFIG_SERIAL_AT91=y
-CONFIG_SERIAL_AT91_CONSOLE=y
-# CONFIG_SERIAL_AT91_TTYAT is not set
+CONFIG_SERIAL_ATMEL=y
+CONFIG_SERIAL_ATMEL_CONSOLE=y
+# CONFIG_SERIAL_ATMEL_TTYAT is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/configs/ateb9200_defconfig b/arch/arm/configs/ateb9200_defconfig
index bee7813..15e6b0b 100644
--- a/arch/arm/configs/ateb9200_defconfig
+++ b/arch/arm/configs/ateb9200_defconfig
@@ -656,9 +656,9 @@ # CONFIG_SERIAL_8250 is not set
 #
 # Non-8250 serial port support
 #
-CONFIG_SERIAL_AT91=y
-CONFIG_SERIAL_AT91_CONSOLE=y
-# CONFIG_SERIAL_AT91_TTYAT is not set
+CONFIG_SERIAL_ATMEL=y
+CONFIG_SERIAL_ATMEL_CONSOLE=y
+# CONFIG_SERIAL_ATMEL_TTYAT is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/configs/carmeva_defconfig b/arch/arm/configs/carmeva_defconfig
index 8a075c8..d24ae87 100644
--- a/arch/arm/configs/carmeva_defconfig
+++ b/arch/arm/configs/carmeva_defconfig
@@ -455,8 +455,8 @@ # CONFIG_SERIAL_8250 is not set
 #
 # Non-8250 serial port support
 #
-CONFIG_SERIAL_AT91=y
-CONFIG_SERIAL_AT91_CONSOLE=y
+CONFIG_SERIAL_ATMEL=y
+CONFIG_SERIAL_ATMEL_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/configs/csb337_defconfig b/arch/arm/configs/csb337_defconfig
index cf3fa5c..a2d6fd3 100644
--- a/arch/arm/configs/csb337_defconfig
+++ b/arch/arm/configs/csb337_defconfig
@@ -591,9 +591,9 @@ # CONFIG_SERIAL_8250 is not set
 #
 # Non-8250 serial port support
 #
-CONFIG_SERIAL_AT91=y
-CONFIG_SERIAL_AT91_CONSOLE=y
-# CONFIG_SERIAL_AT91_TTYAT is not set
+CONFIG_SERIAL_ATMEL=y
+CONFIG_SERIAL_ATMEL_CONSOLE=y
+# CONFIG_SERIAL_ATMEL_TTYAT is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/configs/csb637_defconfig b/arch/arm/configs/csb637_defconfig
index 640d70c..2a1ac6c 100644
--- a/arch/arm/configs/csb637_defconfig
+++ b/arch/arm/configs/csb637_defconfig
@@ -591,9 +591,9 @@ # CONFIG_SERIAL_8250 is not set
 #
 # Non-8250 serial port support
 #
-CONFIG_SERIAL_AT91=y
-CONFIG_SERIAL_AT91_CONSOLE=y
-# CONFIG_SERIAL_AT91_TTYAT is not set
+CONFIG_SERIAL_ATMEL=y
+CONFIG_SERIAL_ATMEL_CONSOLE=y
+# CONFIG_SERIAL_ATMEL_TTYAT is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/configs/kafa_defconfig b/arch/arm/configs/kafa_defconfig
index 1db633e..54fcd75 100644
--- a/arch/arm/configs/kafa_defconfig
+++ b/arch/arm/configs/kafa_defconfig
@@ -536,9 +536,9 @@ # CONFIG_SERIAL_8250 is not set
 #
 # Non-8250 serial port support
 #
-CONFIG_SERIAL_AT91=y
-CONFIG_SERIAL_AT91_CONSOLE=y
-# CONFIG_SERIAL_AT91_TTYAT is not set
+CONFIG_SERIAL_ATMEL=y
+CONFIG_SERIAL_ATMEL_CONSOLE=y
+# CONFIG_SERIAL_ATMEL_TTYAT is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/configs/kb9202_defconfig b/arch/arm/configs/kb9202_defconfig
index 45396e0..b4cd4b4 100644
--- a/arch/arm/configs/kb9202_defconfig
+++ b/arch/arm/configs/kb9202_defconfig
@@ -418,8 +418,8 @@ # CONFIG_SERIAL_8250 is not set
 #
 # Non-8250 serial port support
 #
-CONFIG_SERIAL_AT91=y
-CONFIG_SERIAL_AT91_CONSOLE=y
+CONFIG_SERIAL_ATMEL=y
+CONFIG_SERIAL_ATMEL_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/configs/onearm_defconfig b/arch/arm/configs/onearm_defconfig
index 6a93e3a..cb1d94f 100644
--- a/arch/arm/configs/onearm_defconfig
+++ b/arch/arm/configs/onearm_defconfig
@@ -583,9 +583,9 @@ # CONFIG_SERIAL_8250 is not set
 #
 # Non-8250 serial port support
 #
-CONFIG_SERIAL_AT91=y
-CONFIG_SERIAL_AT91_CONSOLE=y
-# CONFIG_SERIAL_AT91_TTYAT is not set
+CONFIG_SERIAL_ATMEL=y
+CONFIG_SERIAL_ATMEL_CONSOLE=y
+# CONFIG_SERIAL_ATMEL_TTYAT is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/arch/arm/mach-at91rm9200/devices.c b/arch/arm/mach-at91rm9200/devices.c
index 4352acb..467ef6d 100644
--- a/arch/arm/mach-at91rm9200/devices.c
+++ b/arch/arm/mach-at91rm9200/devices.c
@@ -544,7 +544,7 @@ #endif
  *  UART
  * -------------------------------------------------------------------- */
 
-#if defined(CONFIG_SERIAL_AT91)
+#if defined(CONFIG_SERIAL_ATMEL)
 static struct resource dbgu_resources[] = {
 	[0] = {
 		.start	= AT91_VA_BASE_SYS + AT91_DBGU,
diff --git a/arch/avr32/configs/atstk1002_defconfig b/arch/avr32/configs/atstk1002_defconfig
index 1d22255..6c2c5e0 100644
--- a/arch/avr32/configs/atstk1002_defconfig
+++ b/arch/avr32/configs/atstk1002_defconfig
@@ -385,9 +385,9 @@ # CONFIG_SERIAL_8250 is not set
 #
 # Non-8250 serial port support
 #
-CONFIG_SERIAL_AT91=y
-CONFIG_SERIAL_AT91_CONSOLE=y
-# CONFIG_SERIAL_AT91_TTYAT is not set
+CONFIG_SERIAL_ATMEL=y
+CONFIG_SERIAL_ATMEL_CONSOLE=y
+# CONFIG_SERIAL_ATMEL_TTYAT is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 5b48ac2..4f962de 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -299,17 +299,17 @@ config SERIAL_AMBA_PL011_CONSOLE
 	  your boot loader (lilo or loadlin) about how to pass options to the
 	  kernel at boot time.)
 
-config SERIAL_AT91
-	bool "AT91RM9200 / AT91SAM9261 serial port support"
+config SERIAL_ATMEL
+	bool "AT91 / AT32 on-chip serial port support"
 	depends on ARM && (ARCH_AT91RM9200 || ARCH_AT91SAM9261)
 	select SERIAL_CORE
 	help
 	  This enables the driver for the on-chip UARTs of the Atmel
 	  AT91RM9200 and AT91SAM926 processor.
 
-config SERIAL_AT91_CONSOLE
-	bool "Support for console on AT91RM9200 / AT91SAM9261 serial port"
-	depends on SERIAL_AT91=y
+config SERIAL_ATMEL_CONSOLE
+	bool "Support for console on AT91 / AT32 serial port"
+	depends on SERIAL_ATMEL=y
 	select SERIAL_CORE_CONSOLE
 	help
 	  Say Y here if you wish to use a UART on the Atmel AT91RM9200 or
@@ -317,9 +317,9 @@ config SERIAL_AT91_CONSOLE
 	  which receives all kernel messages and warnings and which allows
 	  logins in single user mode).
 
-config SERIAL_AT91_TTYAT
+config SERIAL_ATMEL_TTYAT
 	bool "Install as device ttyAT0-4 instead of ttyS0-4"
-	depends on SERIAL_AT91=y
+	depends on SERIAL_ATMEL=y
 	help
 	  Say Y here if you wish to have the five internal AT91RM9200 UARTs
 	  appear as /dev/ttyAT0-4 (major 204, minor 154-158) instead of the
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index e49808a..b4d8a7c 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -54,5 +54,5 @@ obj-$(CONFIG_SERIAL_TXX9) += serial_txx9
 obj-$(CONFIG_SERIAL_VR41XX) += vr41xx_siu.o
 obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
 obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
-obj-$(CONFIG_SERIAL_AT91) += atmel_serial.o
+obj-$(CONFIG_SERIAL_ATMEL) += atmel_serial.o
 obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
diff --git a/drivers/serial/atmel_serial.c b/drivers/serial/atmel_serial.c
index 49a3c7c..e33caa9 100644
--- a/drivers/serial/atmel_serial.c
+++ b/drivers/serial/atmel_serial.c
@@ -44,13 +44,13 @@ #include <asm/arch/gpio.h>
 
 #include "atmel_serial.h"
 
-#if defined(CONFIG_SERIAL_AT91_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
+#if defined(CONFIG_SERIAL_ATMEL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
 #define SUPPORT_SYSRQ
 #endif
 
 #include <linux/serial_core.h>
 
-#ifdef CONFIG_SERIAL_AT91_TTYAT
+#ifdef CONFIG_SERIAL_ATMEL_TTYAT
 
 /* Use device name ttyAT, major 204 and minor 154-169.  This is necessary if we
  * should coexist with the 8250 driver, such as if we have an external 16C550
@@ -726,7 +726,7 @@ void __init at91_register_uart_fns(struc
 }
 
 
-#ifdef CONFIG_SERIAL_AT91_CONSOLE
+#ifdef CONFIG_SERIAL_ATMEL_CONSOLE
 static void at91_console_putchar(struct uart_port *port, int ch)
 {
 	while (!(UART_GET_CSR(port) & AT91_US_TXRDY))
diff --git a/include/asm-arm/mach/serial_at91.h b/include/asm-arm/mach/serial_at91.h
index 1290bb3..239e1f6 100644
--- a/include/asm-arm/mach/serial_at91.h
+++ b/include/asm-arm/mach/serial_at91.h
@@ -24,7 +24,7 @@ struct at91_port_fns {
 	void	(*close)(struct uart_port *);
 };
 
-#if defined(CONFIG_SERIAL_AT91)
+#if defined(CONFIG_SERIAL_ATMEL)
 void at91_register_uart_fns(struct at91_port_fns *fns);
 #else
 #define at91_register_uart_fns(fns) do { } while (0)
diff --git a/include/asm-avr32/mach/serial_at91.h b/include/asm-avr32/mach/serial_at91.h
index 1290bb3..239e1f6 100644
--- a/include/asm-avr32/mach/serial_at91.h
+++ b/include/asm-avr32/mach/serial_at91.h
@@ -24,7 +24,7 @@ struct at91_port_fns {
 	void	(*close)(struct uart_port *);
 };
 
-#if defined(CONFIG_SERIAL_AT91)
+#if defined(CONFIG_SERIAL_ATMEL)
 void at91_register_uart_fns(struct at91_port_fns *fns);
 #else
 #define at91_register_uart_fns(fns) do { } while (0)
-- 
1.4.1.1

