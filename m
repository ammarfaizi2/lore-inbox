Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263961AbTCVWlC>; Sat, 22 Mar 2003 17:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263970AbTCVWk4>; Sat, 22 Mar 2003 17:40:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12421
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263961AbTCVWkR>; Sat, 22 Mar 2003 17:40:17 -0500
Date: Sat, 22 Mar 2003 23:55:59 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303222355.h2MNtxhw020709@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: ide typo fixes #2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/ide/pci/cy82c693.c linux-2.5.65-ac3/drivers/ide/pci/cy82c693.c
--- linux-2.5.65-bk3/drivers/ide/pci/cy82c693.c	2003-03-22 19:33:55.000000000 +0000
+++ linux-2.5.65-ac3/drivers/ide/pci/cy82c693.c	2003-03-22 20:32:12.000000000 +0000
@@ -2,12 +2,12 @@
  * linux/drivers/ide/pci/cy82c693.c		Version 0.40	Sep. 10, 2002
  *
  *  Copyright (C) 1998-2000 Andreas S. Krebs (akrebs@altavista.net), Maintainer
- *  Copyright (C) 1998-2002 Andre Hedrick <andre@linux-ide.org>, Integrater
+ *  Copyright (C) 1998-2002 Andre Hedrick <andre@linux-ide.org>, Integrator
  *
  * CYPRESS CY82C693 chipset IDE controller
  *
  * The CY82C693 chipset is used on Digital's PC-Alpha 164SX boards.
- * Writting the driver was quite simple, since most of the job is
+ * Writing the driver was quite simple, since most of the job is
  * done by the generic pci-ide support. 
  * The hard part was finding the CY82C693's datasheet on Cypress's
  * web page :-(. But Altavista solved this problem :-).
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/ide/pci/hpt34x.c linux-2.5.65-ac3/drivers/ide/pci/hpt34x.c
--- linux-2.5.65-bk3/drivers/ide/pci/hpt34x.c	2003-03-22 19:35:11.000000000 +0000
+++ linux-2.5.65-ac3/drivers/ide/pci/hpt34x.c	2003-03-22 20:32:12.000000000 +0000
@@ -166,7 +166,7 @@
 /*
  * This allows the configuration of ide_pci chipset registers
  * for cards that learn about the drive's UDMA, DMA, PIO capabilities
- * after the drive is reported by the OS.  Initally for designed for
+ * after the drive is reported by the OS.  Initially for designed for
  * HPT343 UDMA chipset by HighPoint|Triones Technologies, Inc.
  */
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/ide/pci/hpt366.c linux-2.5.65-ac3/drivers/ide/pci/hpt366.c
--- linux-2.5.65-bk3/drivers/ide/pci/hpt366.c	2003-03-22 19:35:11.000000000 +0000
+++ linux-2.5.65-ac3/drivers/ide/pci/hpt366.c	2003-03-22 20:32:12.000000000 +0000
@@ -447,7 +447,7 @@
 /*
  * This allows the configuration of ide_pci chipset registers
  * for cards that learn about the drive's UDMA, DMA, PIO capabilities
- * after the drive is reported by the OS.  Initally for designed for
+ * after the drive is reported by the OS.  Initially for designed for
  * HPT366 UDMA chipset by HighPoint|Triones Technologies, Inc.
  *
  * check_in_drive_lists(drive, bad_ata66_4)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65-bk3/drivers/ide/pci/opti621.c linux-2.5.65-ac3/drivers/ide/pci/opti621.c
--- linux-2.5.65-bk3/drivers/ide/pci/opti621.c	2003-03-22 19:33:55.000000000 +0000
+++ linux-2.5.65-ac3/drivers/ide/pci/opti621.c	2003-03-22 20:32:12.000000000 +0000
@@ -118,7 +118,7 @@
  */
 
 /* #define READ_PREFETCH 0 */
-/* Uncommnent for disable read prefetch.
+/* Uncomment for disable read prefetch.
  * There is some readprefetch capatibility in hdparm,
  * but when I type hdparm -P 1 /dev/hda, I got errors
  * and till reset drive is inaccessible.
