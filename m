Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbTBOS5z>; Sat, 15 Feb 2003 13:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264878AbTBOS5z>; Sat, 15 Feb 2003 13:57:55 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42000 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264877AbTBOS5y>; Sat, 15 Feb 2003 13:57:54 -0500
Subject: PATCH: high pedantry in ARM spelling
To: rmk@arm.linux.org.uk, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Sat, 15 Feb 2003 19:07:37 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18k7f0-0007GS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One erratum
Two errata

Alan
--
                Dim rhyfel mewn ein enw ni


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.61/arch/arm/mach-sa1100/cpu-sa1110.c linux-2.5.61-ac1/arch/arm/mach-sa1100/cpu-sa1110.c
--- linux-2.5.61/arch/arm/mach-sa1100/cpu-sa1110.c	2003-02-10 18:37:56.000000000 +0000
+++ linux-2.5.61-ac1/arch/arm/mach-sa1100/cpu-sa1110.c	2003-02-14 22:36:51.000000000 +0000
@@ -9,7 +9,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Note: there are two erratas that apply to the SA1110 here:
+ * Note: there are two errata that apply to the SA1110 here:
  *  7 - SDRAM auto-power-up failure (rev A0)
  * 13 - Corruption of internal register reads/writes following
  *      SDRAM reads (rev A0, B0, B1)
@@ -139,7 +139,7 @@
 	 * run SDCLK at half speed.
 	 *
 	 * CPU steppings prior to B2 must either run the memory at
-	 * half speed or use delayed read latching (errata 13).
+	 * half speed or use delayed read latching (erratum 13).
 	 */
 	if ((ns_to_cycles(sdram->tck, sd_khz) > 1) ||
 	    (CPU_REVISION < CPU_SA1110_B2 && sd_khz < 62000))
