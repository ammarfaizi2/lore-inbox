Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWDMLh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWDMLh6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 07:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWDMLh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 07:37:58 -0400
Received: from soohrt.org ([85.131.246.150]:27328 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S964887AbWDMLh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 07:37:58 -0400
Date: Thu, 13 Apr 2006 13:37:51 +0200
From: Horst Schirmeier <horst@schirmeier.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] typo: buad -> baud
Message-ID: <20060413113751.GK2335@quickstop.soohrt.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, trivial@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing mistyped "buad" with "baud" where applicable.

Signed-off-by: Horst Schirmeier <horst@schirmeier.com>

---

 arch/mips/ddb5xxx/ddb5476/dbg_io.c        |    2 +-
 arch/mips/ddb5xxx/ddb5477/kgdb_io.c       |    2 +-
 arch/mips/gt64120/ev64120/serialGT.c      |    2 +-
 arch/mips/gt64120/momenco_ocelot/dbg_io.c |    2 +-
 arch/mips/ite-boards/generic/dbg_io.c     |    2 +-
 arch/mips/momentum/jaguar_atx/dbg_io.c    |    2 +-
 arch/mips/momentum/ocelot_c/dbg_io.c      |    2 +-
 arch/mips/momentum/ocelot_g/dbg_io.c      |    2 +-
 include/asm-arm/arch-l7200/serial_l7200.h |    2 +-
 include/asm-arm/arch-l7200/uncompress.h   |    2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/ddb5xxx/ddb5476/dbg_io.c b/arch/mips/ddb5xxx/ddb5476/dbg_io.c
index 85e9e50..f2296a9 100644
--- a/arch/mips/ddb5xxx/ddb5476/dbg_io.c
+++ b/arch/mips/ddb5xxx/ddb5476/dbg_io.c
@@ -86,7 +86,7 @@ void debugInit(uint32 baud, uint8 data, 
         /* disable interrupts */
         UART16550_WRITE(OFS_INTR_ENABLE, 0);
 
-        /* set up buad rate */
+        /* set up baud rate */
         {
                 uint32 divisor;
 
diff --git a/arch/mips/ddb5xxx/ddb5477/kgdb_io.c b/arch/mips/ddb5xxx/ddb5477/kgdb_io.c
index 1d18d59..385bbdb 100644
--- a/arch/mips/ddb5xxx/ddb5477/kgdb_io.c
+++ b/arch/mips/ddb5xxx/ddb5477/kgdb_io.c
@@ -86,7 +86,7 @@ void debugInit(uint32 baud, uint8 data, 
         /* disable interrupts */
         UART16550_WRITE(OFS_INTR_ENABLE, 0);
 
-        /* set up buad rate */
+        /* set up baud rate */
         {
                 uint32 divisor;
 
diff --git a/arch/mips/gt64120/ev64120/serialGT.c b/arch/mips/gt64120/ev64120/serialGT.c
index 16e34a5..8f0d835 100644
--- a/arch/mips/gt64120/ev64120/serialGT.c
+++ b/arch/mips/gt64120/ev64120/serialGT.c
@@ -149,7 +149,7 @@ void serial_set(int channel, unsigned lo
 #else
 	/*
 	 * Note: Set baud rate, hardcoded here for rate of 115200
-	 * since became unsure of above "buad rate" algorithm (??).
+	 * since became unsure of above "baud rate" algorithm (??).
 	 */
 	outreg(channel, LCR, 0x83);
 	outreg(channel, DLM, 0x00);	// See note above
diff --git a/arch/mips/gt64120/momenco_ocelot/dbg_io.c b/arch/mips/gt64120/momenco_ocelot/dbg_io.c
index 8720bcc..f0a6a38 100644
--- a/arch/mips/gt64120/momenco_ocelot/dbg_io.c
+++ b/arch/mips/gt64120/momenco_ocelot/dbg_io.c
@@ -73,7 +73,7 @@ void debugInit(uint32 baud, uint8 data, 
 	/* disable interrupts */
 	UART16550_WRITE(OFS_INTR_ENABLE, 0);
 
-	/* set up buad rate */
+	/* set up baud rate */
 	{
 		uint32 divisor;
 
diff --git a/arch/mips/ite-boards/generic/dbg_io.c b/arch/mips/ite-boards/generic/dbg_io.c
index c4f8530..6a7ccaf 100644
--- a/arch/mips/ite-boards/generic/dbg_io.c
+++ b/arch/mips/ite-boards/generic/dbg_io.c
@@ -72,7 +72,7 @@ void debugInit(uint32 baud, uint8 data, 
 	/* disable interrupts */
 	UART16550_WRITE(OFS_INTR_ENABLE, 0);
 
-	/* set up buad rate */
+	/* set up baud rate */
 	{
 		uint32 divisor;
 
diff --git a/arch/mips/momentum/jaguar_atx/dbg_io.c b/arch/mips/momentum/jaguar_atx/dbg_io.c
index 542eac8..d7dea0a 100644
--- a/arch/mips/momentum/jaguar_atx/dbg_io.c
+++ b/arch/mips/momentum/jaguar_atx/dbg_io.c
@@ -73,7 +73,7 @@ void debugInit(uint32 baud, uint8 data, 
 	/* disable interrupts */
 	UART16550_WRITE(OFS_INTR_ENABLE, 0);
 
-	/* set up buad rate */
+	/* set up baud rate */
 	{
 		uint32 divisor;
 
diff --git a/arch/mips/momentum/ocelot_c/dbg_io.c b/arch/mips/momentum/ocelot_c/dbg_io.c
index 8720bcc..f0a6a38 100644
--- a/arch/mips/momentum/ocelot_c/dbg_io.c
+++ b/arch/mips/momentum/ocelot_c/dbg_io.c
@@ -73,7 +73,7 @@ void debugInit(uint32 baud, uint8 data, 
 	/* disable interrupts */
 	UART16550_WRITE(OFS_INTR_ENABLE, 0);
 
-	/* set up buad rate */
+	/* set up baud rate */
 	{
 		uint32 divisor;
 
diff --git a/arch/mips/momentum/ocelot_g/dbg_io.c b/arch/mips/momentum/ocelot_g/dbg_io.c
index 8720bcc..f0a6a38 100644
--- a/arch/mips/momentum/ocelot_g/dbg_io.c
+++ b/arch/mips/momentum/ocelot_g/dbg_io.c
@@ -73,7 +73,7 @@ void debugInit(uint32 baud, uint8 data, 
 	/* disable interrupts */
 	UART16550_WRITE(OFS_INTR_ENABLE, 0);
 
-	/* set up buad rate */
+	/* set up baud rate */
 	{
 		uint32 divisor;
 
diff --git a/include/asm-arm/arch-l7200/serial_l7200.h b/include/asm-arm/arch-l7200/serial_l7200.h
index 238c595..b1008a9 100644
--- a/include/asm-arm/arch-l7200/serial_l7200.h
+++ b/include/asm-arm/arch-l7200/serial_l7200.h
@@ -28,7 +28,7 @@
 #define UARTDR			0x00	/* Tx/Rx data */
 #define RXSTAT			0x04	/* Rx status */
 #define H_UBRLCR		0x08	/* mode register high */
-#define M_UBRLCR		0x0C	/* mode reg mid (MSB of buad)*/
+#define M_UBRLCR		0x0C	/* mode reg mid (MSB of baud)*/
 #define L_UBRLCR		0x10	/* mode reg low (LSB of baud)*/
 #define UARTCON			0x14	/* control register */
 #define UARTFLG			0x18	/* flag register */
diff --git a/include/asm-arm/arch-l7200/uncompress.h b/include/asm-arm/arch-l7200/uncompress.h
index 9fcd40a..04be2a0 100644
--- a/include/asm-arm/arch-l7200/uncompress.h
+++ b/include/asm-arm/arch-l7200/uncompress.h
@@ -6,7 +6,7 @@
  * Changelog:
  *  05-01-2000	SJH	Created
  *  05-13-2000	SJH	Filled in function bodies
- *  07-26-2000	SJH	Removed hard coded buad rate
+ *  07-26-2000	SJH	Removed hard coded baud rate
  */
 
 #include <asm/hardware.h>

-- 
PGP-Key 0xD40E0E7A
