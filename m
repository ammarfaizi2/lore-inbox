Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbVI3EJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbVI3EJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 00:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbVI3EJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 00:09:36 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:16015 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751420AbVI3EJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 00:09:35 -0400
Date: Fri, 30 Sep 2005 05:09:34 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] useless includes of linux/irq.h (arch/ppc)
Message-ID: <20050930040934.GF7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/4xx/bamboo.c current/arch/ppc/platforms/4xx/bamboo.c
--- RC14-rc2-git6-base/arch/ppc/platforms/4xx/bamboo.c	2005-09-05 07:05:13.000000000 -0400
+++ current/arch/ppc/platforms/4xx/bamboo.c	2005-09-29 23:44:23.000000000 -0400
@@ -27,7 +27,6 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/initrd.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/tty.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/4xx/ebony.c current/arch/ppc/platforms/4xx/ebony.c
--- RC14-rc2-git6-base/arch/ppc/platforms/4xx/ebony.c	2005-09-10 16:33:27.000000000 -0400
+++ current/arch/ppc/platforms/4xx/ebony.c	2005-09-29 23:44:29.000000000 -0400
@@ -30,7 +30,6 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/initrd.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/tty.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/4xx/luan.c current/arch/ppc/platforms/4xx/luan.c
--- RC14-rc2-git6-base/arch/ppc/platforms/4xx/luan.c	2005-09-05 07:05:13.000000000 -0400
+++ current/arch/ppc/platforms/4xx/luan.c	2005-09-29 23:44:40.000000000 -0400
@@ -28,7 +28,6 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/initrd.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/tty.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/4xx/ocotea.c current/arch/ppc/platforms/4xx/ocotea.c
--- RC14-rc2-git6-base/arch/ppc/platforms/4xx/ocotea.c	2005-09-05 07:05:13.000000000 -0400
+++ current/arch/ppc/platforms/4xx/ocotea.c	2005-09-29 23:44:47.000000000 -0400
@@ -28,7 +28,6 @@
 #include <linux/delay.h>
 #include <linux/ide.h>
 #include <linux/initrd.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/tty.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/83xx/mpc834x_sys.c current/arch/ppc/platforms/83xx/mpc834x_sys.c
--- RC14-rc2-git6-base/arch/ppc/platforms/83xx/mpc834x_sys.c	2005-09-05 07:05:13.000000000 -0400
+++ current/arch/ppc/platforms/83xx/mpc834x_sys.c	2005-09-29 23:40:41.000000000 -0400
@@ -24,7 +24,6 @@
 #include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/serial.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/85xx/mpc8540_ads.c current/arch/ppc/platforms/85xx/mpc8540_ads.c
--- RC14-rc2-git6-base/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-08-28 23:09:40.000000000 -0400
+++ current/arch/ppc/platforms/85xx/mpc8540_ads.c	2005-09-29 23:37:53.000000000 -0400
@@ -24,7 +24,6 @@
 #include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/serial.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/85xx/mpc8560_ads.c current/arch/ppc/platforms/85xx/mpc8560_ads.c
--- RC14-rc2-git6-base/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-08-28 23:09:40.000000000 -0400
+++ current/arch/ppc/platforms/85xx/mpc8560_ads.c	2005-09-29 23:37:40.000000000 -0400
@@ -24,7 +24,6 @@
 #include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/serial.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/85xx/mpc85xx_ads_common.c current/arch/ppc/platforms/85xx/mpc85xx_ads_common.c
--- RC14-rc2-git6-base/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2005-08-28 23:09:40.000000000 -0400
+++ current/arch/ppc/platforms/85xx/mpc85xx_ads_common.c	2005-09-29 23:37:29.000000000 -0400
@@ -24,7 +24,6 @@
 #include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/serial.h>
 #include <linux/module.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/85xx/mpc85xx_cds_common.c current/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- RC14-rc2-git6-base/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-08-28 23:09:40.000000000 -0400
+++ current/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-09-29 23:34:52.000000000 -0400
@@ -24,7 +24,6 @@
 #include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/serial.h>
 #include <linux/module.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/85xx/sbc8560.c current/arch/ppc/platforms/85xx/sbc8560.c
--- RC14-rc2-git6-base/arch/ppc/platforms/85xx/sbc8560.c	2005-08-28 23:09:40.000000000 -0400
+++ current/arch/ppc/platforms/85xx/sbc8560.c	2005-09-29 23:40:54.000000000 -0400
@@ -24,7 +24,6 @@
 #include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/serial.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/85xx/sbc85xx.c current/arch/ppc/platforms/85xx/sbc85xx.c
--- RC14-rc2-git6-base/arch/ppc/platforms/85xx/sbc85xx.c	2005-08-28 23:09:40.000000000 -0400
+++ current/arch/ppc/platforms/85xx/sbc85xx.c	2005-09-29 23:41:03.000000000 -0400
@@ -23,7 +23,6 @@
 #include <linux/major.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/serial.h>
 #include <linux/module.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/85xx/stx_gp3.c current/arch/ppc/platforms/85xx/stx_gp3.c
--- RC14-rc2-git6-base/arch/ppc/platforms/85xx/stx_gp3.c	2005-08-28 23:09:40.000000000 -0400
+++ current/arch/ppc/platforms/85xx/stx_gp3.c	2005-09-29 23:41:11.000000000 -0400
@@ -30,7 +30,6 @@
 #include <linux/blkdev.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/root_dev.h>
 #include <linux/seq_file.h>
 #include <linux/serial.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/chestnut.c current/arch/ppc/platforms/chestnut.c
--- RC14-rc2-git6-base/arch/ppc/platforms/chestnut.c	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/ppc/platforms/chestnut.c	2005-09-29 23:52:49.000000000 -0400
@@ -35,7 +35,6 @@
 #include <asm/time.h>
 #include <asm/dma.h>
 #include <asm/io.h>
-#include <linux/irq.h>
 #include <asm/hw_irq.h>
 #include <asm/machdep.h>
 #include <asm/kgdb.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/chrp_setup.c current/arch/ppc/platforms/chrp_setup.c
--- RC14-rc2-git6-base/arch/ppc/platforms/chrp_setup.c	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/ppc/platforms/chrp_setup.c	2005-09-29 23:34:37.000000000 -0400
@@ -32,7 +32,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
-#include <linux/irq.h>
 #include <linux/console.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/gemini_setup.c current/arch/ppc/platforms/gemini_setup.c
--- RC14-rc2-git6-base/arch/ppc/platforms/gemini_setup.c	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/ppc/platforms/gemini_setup.c	2005-09-29 23:38:35.000000000 -0400
@@ -21,7 +21,6 @@
 #include <linux/major.h>
 #include <linux/initrd.h>
 #include <linux/console.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/bcd.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/mvme5100.c current/arch/ppc/platforms/mvme5100.c
--- RC14-rc2-git6-base/arch/ppc/platforms/mvme5100.c	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/ppc/platforms/mvme5100.c	2005-09-29 23:35:04.000000000 -0400
@@ -20,7 +20,6 @@
 #include <linux/initrd.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/ide.h>
 #include <linux/seq_file.h>
 #include <linux/kdev_t.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/pmac_setup.c current/arch/ppc/platforms/pmac_setup.c
--- RC14-rc2-git6-base/arch/ppc/platforms/pmac_setup.c	2005-09-23 22:04:24.000000000 -0400
+++ current/arch/ppc/platforms/pmac_setup.c	2005-09-29 23:49:10.000000000 -0400
@@ -48,7 +48,6 @@
 #include <linux/adb.h>
 #include <linux/cuda.h>
 #include <linux/pmu.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/bitops.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/powerpmc250.c current/arch/ppc/platforms/powerpmc250.c
--- RC14-rc2-git6-base/arch/ppc/platforms/powerpmc250.c	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/ppc/platforms/powerpmc250.c	2005-09-29 23:39:05.000000000 -0400
@@ -26,7 +26,6 @@
 #include <linux/initrd.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
 #include <linux/ide.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/pplus.c current/arch/ppc/platforms/pplus.c
--- RC14-rc2-git6-base/arch/ppc/platforms/pplus.c	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/ppc/platforms/pplus.c	2005-09-29 23:35:14.000000000 -0400
@@ -22,7 +22,6 @@
 #include <linux/ioport.h>
 #include <linux/console.h>
 #include <linux/pci.h>
-#include <linux/irq.h>
 #include <linux/ide.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/prpmc750.c current/arch/ppc/platforms/prpmc750.c
--- RC14-rc2-git6-base/arch/ppc/platforms/prpmc750.c	2005-08-28 23:09:40.000000000 -0400
+++ current/arch/ppc/platforms/prpmc750.c	2005-09-29 23:39:17.000000000 -0400
@@ -24,7 +24,6 @@
 #include <linux/initrd.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/ide.h>
 #include <linux/root_dev.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/prpmc800.c current/arch/ppc/platforms/prpmc800.c
--- RC14-rc2-git6-base/arch/ppc/platforms/prpmc800.c	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/ppc/platforms/prpmc800.c	2005-09-29 23:39:23.000000000 -0400
@@ -22,7 +22,6 @@
 #include <linux/initrd.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/ide.h>
 #include <linux/root_dev.h>
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/radstone_ppc7d.c current/arch/ppc/platforms/radstone_ppc7d.c
--- RC14-rc2-git6-base/arch/ppc/platforms/radstone_ppc7d.c	2005-06-17 15:48:29.000000000 -0400
+++ current/arch/ppc/platforms/radstone_ppc7d.c	2005-09-29 23:35:33.000000000 -0400
@@ -32,7 +32,6 @@
 #include <linux/initrd.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/ide.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
@@ -59,7 +58,6 @@
 #include <asm/mpc10x.h>
 #include <asm/pci-bridge.h>
 #include <asm/mv64x60.h>
-#include <asm/i8259.h>
 
 #include "radstone_ppc7d.h"
 
diff -urN RC14-rc2-git6-base/arch/ppc/platforms/sandpoint.c current/arch/ppc/platforms/sandpoint.c
--- RC14-rc2-git6-base/arch/ppc/platforms/sandpoint.c	2005-08-28 23:09:40.000000000 -0400
+++ current/arch/ppc/platforms/sandpoint.c	2005-09-29 23:35:41.000000000 -0400
@@ -74,7 +74,6 @@
 #include <linux/initrd.h>
 #include <linux/console.h>
 #include <linux/delay.h>
-#include <linux/irq.h>
 #include <linux/ide.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
diff -urN RC14-rc2-git6-base/arch/ppc/syslib/open_pic.c current/arch/ppc/syslib/open_pic.c
--- RC14-rc2-git6-base/arch/ppc/syslib/open_pic.c	2005-09-05 07:05:13.000000000 -0400
+++ current/arch/ppc/syslib/open_pic.c	2005-09-29 23:35:55.000000000 -0400
@@ -13,7 +13,6 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/init.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/sysdev.h>
 #include <linux/errno.h>
diff -urN RC14-rc2-git6-base/arch/ppc/syslib/open_pic2.c current/arch/ppc/syslib/open_pic2.c
--- RC14-rc2-git6-base/arch/ppc/syslib/open_pic2.c	2005-09-19 02:18:03.000000000 -0400
+++ current/arch/ppc/syslib/open_pic2.c	2005-09-29 23:36:01.000000000 -0400
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/init.h>
-#include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/sysdev.h>
 #include <linux/errno.h>
diff -urN RC14-rc2-git6-base/arch/ppc/syslib/ppc4xx_setup.c current/arch/ppc/syslib/ppc4xx_setup.c
--- RC14-rc2-git6-base/arch/ppc/syslib/ppc4xx_setup.c	2005-09-05 07:05:13.000000000 -0400
+++ current/arch/ppc/syslib/ppc4xx_setup.c	2005-09-29 23:45:27.000000000 -0400
@@ -18,7 +18,6 @@
 #include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/spinlock.h>
-#include <linux/irq.h>
 #include <linux/reboot.h>
 #include <linux/param.h>
 #include <linux/string.h>
