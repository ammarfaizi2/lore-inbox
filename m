Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbSK1NUj>; Thu, 28 Nov 2002 08:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265506AbSK1NUi>; Thu, 28 Nov 2002 08:20:38 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:22514 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S265484AbSK1NUh>; Thu, 28 Nov 2002 08:20:37 -0500
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: rmk@arm.linux.org.uk
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] Literacy watch 2.5.49
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Nov 2002 13:27:47 +0000
Message-ID: <7718.1038490067@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we're going on a spell-checking mission, let's fix this too. I can't be 
bothered to fix all incorrect usage of the word 'errata' where the author 
actually meant 'erratum' but was clueless -- but the existence of 'erratas' 
definitely deserves to die...

--- arch/arm/mach-sa1100/cpu-sa1110.c.illiterate	2002-11-28 13:24:37.000000000 +0000
+++ arch/arm/mach-sa1100/cpu-sa1110.c	2002-11-28 13:25:08.000000000 +0000
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


--
dwmw2


