Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262516AbRE3Aqs>; Tue, 29 May 2001 20:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262532AbRE3Aqm>; Tue, 29 May 2001 20:46:42 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:3855 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262516AbRE3AqR>; Tue, 29 May 2001 20:46:17 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105300047.CAA04569@green.mif.pg.gda.pl>
Subject: [PATCH] net #8
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 30 May 2001 02:47:21 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch fixes some bogus comments in /drivers/net/*.c

Andrzej

*************************** PATCH 8 *********************************
diff -uNr linux-2.4.5-ac4/drivers/net/3c501.c linux/drivers/net/3c501.c
--- linux-2.4.5-ac4/drivers/net/3c501.c	Wed May 30 01:09:52 2001
+++ linux/drivers/net/3c501.c	Wed May 30 01:15:20 2001
@@ -253,7 +253,7 @@
 }
 
 /**
- *	el1_probe: 
+ *	el1_probe1: 
  *	@dev: The device structure to use
  *	@ioaddr: An I/O address to probe at.
  *
diff -uNr linux-2.4.5-ac4/drivers/net/aironet4500_proc.c linux/drivers/net/aironet4500_proc.c
--- linux-2.4.5-ac4/drivers/net/aironet4500_proc.c	Tue May 29 20:46:26 2001
+++ linux/drivers/net/aironet4500_proc.c	Wed May 30 01:15:20 2001
@@ -1,5 +1,5 @@
 /*
- *	 Aironet 4500 Pcmcia driver
+ *	 Aironet 4500 /proc interface
  *
  *		Elmer Joandi, Januar 1999
  *	Copyright GPL
diff -uNr linux-2.4.5-ac4/drivers/net/bagetlance.c linux/drivers/net/bagetlance.c
--- linux-2.4.5-ac4/drivers/net/bagetlance.c	Wed May 30 01:08:54 2001
+++ linux/drivers/net/bagetlance.c	Wed May 30 01:15:20 2001
@@ -1,5 +1,5 @@
 /* $Id$
- * vmelance.c: Ethernet driver for VME Lance cards on Baget/MIPS
+ * bagetlance.c: Ethernet driver for VME Lance cards on Baget/MIPS
  *      This code stealed and adopted from linux/drivers/net/atarilance.c
  *      See that for author info
  *
diff -uNr linux-2.4.5-ac4/drivers/net/seeq8005.c linux/drivers/net/seeq8005.c
--- linux-2.4.5-ac4/drivers/net/seeq8005.c	Wed May 30 01:08:55 2001
+++ linux/drivers/net/seeq8005.c	Wed May 30 01:15:20 2001
@@ -101,8 +101,6 @@
 /* Check for a network adaptor of this type, and return '0' iff one exists.
    If dev->base_addr == 0, probe all likely locations.
    If dev->base_addr == 1, always return failure.
-   If dev->base_addr == 2, allocate space for the device and return success
-   (detachable devices only).
    */
 
 int __init 
diff -uNr linux-2.4.5-ac4/drivers/net/sk_g16.c linux/drivers/net/sk_g16.c
--- linux-2.4.5-ac4/drivers/net/sk_g16.c	Mon May 28 01:34:55 2001
+++ linux/drivers/net/sk_g16.c	Wed May 30 01:15:20 2001
@@ -536,8 +536,6 @@
  * Check for a network adaptor of this type, and return '0' if one exists.
  * If dev->base_addr == 0, probe all likely locations.
  * If dev->base_addr == 1, always return failure.
- * If dev->base_addr == 2, allocate space for the device and return success
- *                         (detachable devices only).
  */
 
 int __init SK_init(struct net_device *dev)
diff -uNr linux-2.4.5-ac4/drivers/net/winbond-840.c linux/drivers/net/winbond-840.c
--- linux-2.4.5-ac4/drivers/net/winbond-840.c	Wed May 30 01:08:56 2001
+++ linux/drivers/net/winbond-840.c	Wed May 30 01:15:20 2001
@@ -1,4 +1,4 @@
-/* winbond-840.c: A Linux PCI network adapter skeleton device driver. */
+/* winbond-840.c: A Linux PCI network adapter device driver. */
 /*
 	Written 1998-2001 by Donald Becker.
 


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
