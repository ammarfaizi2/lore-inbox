Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbRE3Aj2>; Tue, 29 May 2001 20:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262164AbRE3AjW>; Tue, 29 May 2001 20:39:22 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:63246 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262465AbRE3AjI>; Tue, 29 May 2001 20:39:08 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200105300039.CAA04486@green.mif.pg.gda.pl>
Subject: [PATCH] net #2
To: alan@lxorguk.ukuu.org.uk (Alan Cox), becker@scyld.com,
        jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Wed, 30 May 2001 02:39:49 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch brings up to date Donald's address in most places in network
drivers (some of them, mainly in "version" remain to be fixed in the next
series of patches)

Andrzej

******************************* PATCH 2 *****************************
diff -uNr linux-2.4.5-ac4/drivers/net/3c501.c linux/drivers/net/3c501.c
--- linux-2.4.5-ac4/drivers/net/3c501.c	Wed May 30 01:08:53 2001
+++ linux/drivers/net/3c501.c	Wed May 30 01:08:39 2001
@@ -11,9 +11,11 @@
     Do not purchase this card, even as a joke.  It's performance is horrible,
     and it breaks in many ways.
 
-    The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-    Center of Excellence in Space Data and Information Sciences
-       Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+    The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
+
 
     Fixed (again!) the missing interrupt locking on TX/RX shifting.
     		Alan Cox <Alan.Cox@linux.org>
diff -uNr linux-2.4.5-ac4/drivers/net/3c503.c linux/drivers/net/3c503.c
--- linux-2.4.5-ac4/drivers/net/3c503.c	Wed May 30 01:08:53 2001
+++ linux/drivers/net/3c503.c	Wed May 30 01:08:40 2001
@@ -7,9 +7,11 @@
     distributed according to the terms of the GNU General Public License,
     incorporated herein by reference.
 
-    The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-    Center of Excellence in Space Data and Information Sciences
-       Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+    The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
+
 
     This driver should work with the 3c503 and 3c503/16.  It should be used
     in shared memory mode for best performance, although it may also work
diff -uNr linux-2.4.5-ac4/drivers/net/3c505.c linux/drivers/net/3c505.c
--- linux-2.4.5-ac4/drivers/net/3c505.c	Wed May 30 01:08:53 2001
+++ linux/drivers/net/3c505.c	Wed May 30 01:08:40 2001
@@ -20,6 +20,7 @@
  *                      Juha Laiho, <jlaiho@ichaos.nullnet.fi>
  *              Linux 3C509 driver by
  *                      Donald Becker, <becker@super.org>
+ *			(Now at <becker@scyld.com>)
  *              Crynwr packet driver by
  *                      Krishnan Gopalan and Gregg Stefancik,
  *                      Clemson University Engineering Computer Operations.
diff -uNr linux-2.4.5-ac4/drivers/net/3c507.c linux/drivers/net/3c507.c
--- linux-2.4.5-ac4/drivers/net/3c507.c	Wed May 30 01:08:53 2001
+++ linux/drivers/net/3c507.c	Wed May 30 01:08:40 2001
@@ -8,9 +8,11 @@
 	This software may be used and distributed according to the terms
 	of the GNU General Public License, incorporated herein by reference.
 
-	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-	Center of Excellence in Space Data and Information Sciences
-	   Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
+
 
 	Thanks go to jennings@Montrouge.SMR.slb.com ( Patrick Jennings)
 	and jrs@world.std.com (Rick Sladkey) for testing and bugfixes.
diff -uNr linux-2.4.5-ac4/drivers/net/3c509.c linux/drivers/net/3c509.c
--- linux-2.4.5-ac4/drivers/net/3c509.c	Wed May 30 01:08:53 2001
+++ linux/drivers/net/3c509.c	Wed May 30 01:08:40 2001
@@ -10,9 +10,10 @@
 
 	This driver is for the 3Com EtherLinkIII series.
 
-	The author may be reached as becker@cesdis.gsfc.nasa.gov or
-	C/O Center of Excellence in Space Data and Information Sciences
-		Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
 	Known limitations:
 	Because of the way 3c509 ISA detection works it's difficult to predict
diff -uNr linux-2.4.5-ac4/drivers/net/3c515.c linux/drivers/net/3c515.c
--- linux-2.4.5-ac4/drivers/net/3c515.c	Wed May 30 01:08:53 2001
+++ linux/drivers/net/3c515.c	Wed May 30 01:08:40 2001
@@ -7,9 +7,11 @@
 
 	This driver is for the 3Com ISA EtherLink XL "Corkscrew" 3c515 ethercard.
 
-	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-	Center of Excellence in Space Data and Information Sciences
-	   Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
+
 
 	2/2/00- Added support for kernel-level ISAPnP 
 		by Stephen Frost <sfrost@snowman.net> and Alessandro Zummo
@@ -78,7 +80,7 @@
 #define REQUEST_IRQ(i,h,f,n, instance) request_irq(i,h,f,n, instance)
 #define IRQ(irq, dev_id, pt_regs) (irq, dev_id, pt_regs)
 
-MODULE_AUTHOR("Donald Becker <becker@cesdis.gsfc.nasa.gov>");
+MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("3Com 3c515 Corkscrew driver");
 MODULE_PARM(debug, "i");
 MODULE_PARM(options, "1-" __MODULE_STRING(8) "i");
diff -uNr linux-2.4.5-ac4/drivers/net/82596.c linux/drivers/net/82596.c
--- linux-2.4.5-ac4/drivers/net/82596.c	Wed May 30 01:08:53 2001
+++ linux/drivers/net/82596.c	Wed May 30 01:08:40 2001
@@ -35,8 +35,8 @@
    according to the terms of the GNU General Public License as modified by SRC,
    incorporated herein by reference.
 
-   The author may be reached as becker@super.org or
-   C/O Supercomputing Research Ctr., 17100 Science Dr., Bowie MD 20715
+   The author may be reached as becker@scyld.com, or C/O
+   Scyld Computing Corporation, 410 Severn Ave., Suite 210, Annapolis MD 21403
 
  */
 
diff -uNr linux-2.4.5-ac4/drivers/net/8390.c linux/drivers/net/8390.c
--- linux-2.4.5-ac4/drivers/net/8390.c	Mon May 28 01:33:57 2001
+++ linux/drivers/net/8390.c	Wed May 30 01:08:40 2001
@@ -8,9 +8,11 @@
 	This software may be used and distributed according to the terms
 	of the GNU General Public License, incorporated herein by reference.
 
-	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-	Center of Excellence in Space Data and Information Sciences
-	   Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
+
   
   This is the chip-specific code for many 8390-based ethernet adaptors.
   This is not a complete driver, it must be combined with board-specific
diff -uNr linux-2.4.5-ac4/drivers/net/Space.c linux/drivers/net/Space.c
--- linux-2.4.5-ac4/drivers/net/Space.c	Sat May 19 18:35:43 2001
+++ linux/drivers/net/Space.c	Wed May 30 01:08:40 2001
@@ -9,7 +9,7 @@
  *
  * Authors:	Ross Biro, <bir7@leland.Stanford.Edu>
  *		Fred N. van Kempen, <waltje@uWalt.NL.Mugnet.ORG>
- *		Donald J. Becker, <becker@super.org>
+ *		Donald J. Becker, <becker@scyld.com>
  *
  * Changelog:
  *		Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 09/1999
diff -uNr linux-2.4.5-ac4/drivers/net/ac3200.c linux/drivers/net/ac3200.c
--- linux-2.4.5-ac4/drivers/net/ac3200.c	Wed May 30 01:08:53 2001
+++ linux/drivers/net/ac3200.c	Wed May 30 01:08:40 2001
@@ -6,8 +6,10 @@
 	according to the terms of the GNU General Public License as modified by SRC,
 	incorporated herein by reference.
 
-	The author may be reached as becker@cesdis.gsfc.nasa.gov, or
-	C/O Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
 	This is driver for the Ansel Communications Model 3200 EISA Ethernet LAN
 	Adapter.  The programming information is from the users manual, as related
diff -uNr linux-2.4.5-ac4/drivers/net/at1700.c linux/drivers/net/at1700.c
--- linux-2.4.5-ac4/drivers/net/at1700.c	Wed May 30 01:08:54 2001
+++ linux/drivers/net/at1700.c	Wed May 30 01:08:40 2001
@@ -8,9 +8,10 @@
 	This software may be used and distributed according to the terms
 	of the GNU General Public License, incorporated herein by reference.
 
-	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-	Center of Excellence in Space Data and Information Sciences
-	   Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
 	This is a device driver for the Allied Telesis AT1700, and
         Fujitsu FMV-181/182/181A/182A/183/184/183A/184A, which are
diff -uNr linux-2.4.5-ac4/drivers/net/auto_irq.c linux/drivers/net/auto_irq.c
--- linux-2.4.5-ac4/drivers/net/auto_irq.c	Mon Nov 13 23:13:30 2000
+++ linux/drivers/net/auto_irq.c	Wed May 30 01:08:40 2001
@@ -2,9 +2,7 @@
 /*
     Written 1994 by Donald Becker.
 
-    The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-    Center of Excellence in Space Data and Information Sciences
-      Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+    The author may be reached as becker@scyld.com
 
     This code is a general-purpose IRQ line detector for devices with
     jumpered IRQ lines.  If you can make the device raise an IRQ (and
@@ -29,7 +27,7 @@
 
 #ifdef version
 static const char *version=
-"auto_irq.c:v1.11 Donald Becker (becker@cesdis.gsfc.nasa.gov)";
+"auto_irq.c:v1.11 Donald Becker (becker@scyld.com)";
 #endif
 
 #include <linux/module.h>
diff -uNr linux-2.4.5-ac4/drivers/net/de600.c linux/drivers/net/de600.c
--- linux-2.4.5-ac4/drivers/net/de600.c	Wed May 30 01:08:54 2001
+++ linux/drivers/net/de600.c	Wed May 30 01:08:40 2001
@@ -16,7 +16,7 @@
  *
  *	Adapted to the sample network driver core for linux,
  *	written by: Donald Becker <becker@super.org>
- *	C/O Supercomputing Research Ctr., 17100 Science Dr., Bowie MD 20715
+ *		(Now at <becker@scyld.com>)
  *
  *	compile-command:
  *	"gcc -D__KERNEL__  -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer \
diff -uNr linux-2.4.5-ac4/drivers/net/de620.c linux/drivers/net/de620.c
--- linux-2.4.5-ac4/drivers/net/de620.c	Wed May 30 01:08:54 2001
+++ linux/drivers/net/de620.c	Wed May 30 01:08:40 2001
@@ -13,7 +13,7 @@
  *
  *	Adapted to the sample network driver core for linux,
  *	written by: Donald Becker <becker@super.org>
- *		(Now at <becker@cesdis.gsfc.nasa.gov>
+ *		(Now at <becker@scyld.com>)
  *
  *	Valuable assistance from:
  *		J. Joshua Kopper <kopper@rtsg.mot.com>
diff -uNr linux-2.4.5-ac4/drivers/net/e2100.c linux/drivers/net/e2100.c
--- linux-2.4.5-ac4/drivers/net/e2100.c	Wed May 30 01:08:54 2001
+++ linux/drivers/net/e2100.c	Wed May 30 01:08:40 2001
@@ -10,8 +10,10 @@
 
 	This is a driver for the Cabletron E2100 series ethercards.
 
-	The Author may be reached as becker@cesdis.gsfc.nasa.gov, or
-	C/O Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The Author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
 	The E2100 series ethercard is a fairly generic shared memory 8390
 	implementation.  The only unusual aspect is the way the shared memory
diff -uNr linux-2.4.5-ac4/drivers/net/eth16i.c linux/drivers/net/eth16i.c
--- linux-2.4.5-ac4/drivers/net/eth16i.c	Wed May 30 01:08:54 2001
+++ linux/drivers/net/eth16i.c	Wed May 30 01:08:40 2001
@@ -28,7 +28,7 @@
    
    Sources:
      - skeleton.c  a sample network driver core for linux,
-       written by Donald Becker <becker@CESDIS.gsfc.nasa.gov>
+       written by Donald Becker <becker@scyld.com>
      - at1700.c a driver for Allied Telesis AT1700, written 
        by Donald Becker.
      - e16iSRV.asm a Netware 3.X Server Driver for ICL EtherTeam16i
diff -uNr linux-2.4.5-ac4/drivers/net/fmv18x.c linux/drivers/net/fmv18x.c
--- linux-2.4.5-ac4/drivers/net/fmv18x.c	Wed May 30 01:08:54 2001
+++ linux/drivers/net/fmv18x.c	Wed May 30 01:08:40 2001
@@ -3,9 +3,10 @@
 	Original: at1700.c (1993-94 by Donald Becker).
 		Copyright 1993 United States Government as represented by the
 		Director, National Security Agency.
-		The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-		Center of Excellence in Space Data and Information Sciences
-		   Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+		The author may be reached as becker@scyld.com, or C/O
+			Scyld Computing Corporation
+			410 Severn Ave., Suite 210
+			Annapolis MD 21403
 
 	Modified by Yutaka TAMIYA (tamy@flab.fujitsu.co.jp)
 		Copyright 1994 Fujitsu Laboratories Ltd.
diff -uNr linux-2.4.5-ac4/drivers/net/hp-plus.c linux/drivers/net/hp-plus.c
--- linux-2.4.5-ac4/drivers/net/hp-plus.c	Wed May 30 01:08:54 2001
+++ linux/drivers/net/hp-plus.c	Wed May 30 01:08:40 2001
@@ -8,10 +8,10 @@
 	This software may be used and distributed according to the terms
 	of the GNU General Public License, incorporated herein by reference.
 
-	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-
-	Center of Excellence in Space Data and Information Sciences
-		Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
 	As is often the case, a great deal of credit is owed to Russ Nelson.
 	The Crynwr packet driver was my primary source of HP-specific
diff -uNr linux-2.4.5-ac4/drivers/net/hp.c linux/drivers/net/hp.c
--- linux-2.4.5-ac4/drivers/net/hp.c	Wed May 30 01:08:54 2001
+++ linux/drivers/net/hp.c	Wed May 30 01:08:40 2001
@@ -8,9 +8,10 @@
 	This software may be used and distributed according to the terms
 	of the GNU General Public License, incorporated herein by reference.
 
-	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-	Center of Excellence in Space Data and Information Sciences
-	   Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
 	This is a driver for the HP PC-LAN adaptors.
 
diff -uNr linux-2.4.5-ac4/drivers/net/isa-skeleton.c linux/drivers/net/isa-skeleton.c
--- linux-2.4.5-ac4/drivers/net/isa-skeleton.c	Sat May 19 18:35:46 2001
+++ linux/drivers/net/isa-skeleton.c	Wed May 30 01:08:40 2001
@@ -8,9 +8,10 @@
  *	This software may be used and distributed according to the terms
  *	of the GNU General Public License, incorporated herein by reference.
  *
- *	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
- *	Center of Excellence in Space Data and Information Sciences
- *	   Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+ *	The author may be reached as becker@scyld.com, or C/O
+ *	Scyld Computing Corporation
+ *	410 Severn Ave., Suite 210
+ *	Annapolis MD 21403
  *
  *	This file is an outline for writing a network device driver for the
  *	the Linux operating system.
diff -uNr linux-2.4.5-ac4/drivers/net/lance.c linux/drivers/net/lance.c
--- linux-2.4.5-ac4/drivers/net/lance.c	Wed May 30 01:08:55 2001
+++ linux/drivers/net/lance.c	Wed May 30 01:08:40 2001
@@ -10,9 +10,10 @@
 	This driver is for the Allied Telesis AT1500 and HP J2405A, and should work
 	with most other LANCE-based bus-master (NE2100/NE2500) ethercards.
 
-	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-	Center of Excellence in Space Data and Information Sciences
-	   Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
 	Andrey V. Savochkin:
 	- alignment problem with 1.3.* kernel and some minor changes.
diff -uNr linux-2.4.5-ac4/drivers/net/lasi_82596.c linux/drivers/net/lasi_82596.c
--- linux-2.4.5-ac4/drivers/net/lasi_82596.c	Wed May 30 01:08:55 2001
+++ linux/drivers/net/lasi_82596.c	Wed May 30 01:08:40 2001
@@ -63,8 +63,8 @@
    according to the terms of the GNU General Public License as modified by SRC,
    incorporated herein by reference.
 
-   The author may be reached as becker@super.org or
-   C/O Supercomputing Research Ctr., 17100 Science Dr., Bowie MD 20715
+   The author may be reached as becker@scyld.com, or C/O
+   Scyld Computing Corporation, 410 Severn Ave., Suite 210, Annapolis MD 21403
 
  */
 
diff -uNr linux-2.4.5-ac4/drivers/net/loopback.c linux/drivers/net/loopback.c
--- linux-2.4.5-ac4/drivers/net/loopback.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/loopback.c	Wed May 30 01:08:40 2001
@@ -9,7 +9,7 @@
  *
  * Authors:	Ross Biro, <bir7@leland.Stanford.Edu>
  *		Fred N. van Kempen, <waltje@uWalt.NL.Mugnet.ORG>
- *		Donald Becker, <becker@cesdis.gsfc.nasa.gov>
+ *		Donald Becker, <becker@scyld.com>
  *
  *		Alan Cox	:	Fixed oddments for NET3.014
  *		Alan Cox	:	Rejig for NET3.029 snap #3
diff -uNr linux-2.4.5-ac4/drivers/net/lp486e.c linux/drivers/net/lp486e.c
--- linux-2.4.5-ac4/drivers/net/lp486e.c	Wed May 30 01:08:55 2001
+++ linux/drivers/net/lp486e.c	Wed May 30 01:08:40 2001
@@ -10,8 +10,10 @@
 	distributed according to the terms of the GNU Public License
 	as modified by SRC, incorporated herein by reference.
 
-        The author may be reached as becker@super.org or
-        C/O Supercomputing Research Ctr., 17100 Science Dr., Bowie MD 20715
+        The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
     Apricot
         Written 1994 by Mark Evans.
diff -uNr linux-2.4.5-ac4/drivers/net/ne.c linux/drivers/net/ne.c
--- linux-2.4.5-ac4/drivers/net/ne.c	Wed May 30 01:08:55 2001
+++ linux/drivers/net/ne.c	Wed May 30 01:08:40 2001
@@ -8,9 +8,8 @@
     This software may be used and distributed according to the terms
     of the GNU General Public License, incorporated herein by reference.
 
-    The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-    Center of Excellence in Space Data and Information Sciences
-        Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+    The author may be reached as becker@scyld.com, or C/O
+    Scyld Computing Corporation, 410 Severn Ave., Suite 210, Annapolis MD 21403
 
     This driver should work with many programmed-I/O 8390-based ethernet
     boards.  Currently it supports the NE1000, NE2000, many clones,
diff -uNr linux-2.4.5-ac4/drivers/net/net_init.c linux/drivers/net/net_init.c
--- linux-2.4.5-ac4/drivers/net/net_init.c	Mon May 28 01:34:54 2001
+++ linux/drivers/net/net_init.c	Wed May 30 01:08:40 2001
@@ -2,9 +2,10 @@
 /*
 	Written 1993,1994,1995 by Donald Becker.
 
-	The author may be reached as becker@cesdis.gsfc.nasa.gov or
-	C/O Center of Excellence in Space Data and Information Sciences
-		Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
 	This file contains the initialization for the "pl14+" style ethernet
 	drivers.  It should eventually replace most of drivers/net/Space.c.
diff -uNr linux-2.4.5-ac4/drivers/net/pcmcia/3c574_cs.c linux/drivers/net/pcmcia/3c574_cs.c
--- linux-2.4.5-ac4/drivers/net/pcmcia/3c574_cs.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/pcmcia/3c574_cs.c	Wed May 30 01:08:40 2001
@@ -1,7 +1,7 @@
 /* 3c574.c: A PCMCIA ethernet driver for the 3com 3c574 "RoadRunner".
 
 	Written 1993-1998 by
-	Donald Becker, becker@cesdis.gsfc.nasa.gov, (driver core) and
+	Donald Becker, becker@scyld.com, (driver core) and
 	David Hinds, dahinds@users.sourceforge.net (from his PC card code).
 
 	This software may be used and distributed according to the terms of
@@ -16,7 +16,7 @@
 
 /* Driver author info must always be in the binary.  Version too.. */
 static const char *tc574_version =
-"3c574_cs.c v1.08 9/24/98 Donald Becker/David Hinds, becker@cesdis.gsfc.nasa.gov.\n";
+"3c574_cs.c v1.08 9/24/98 Donald Becker/David Hinds, becker@scyld.com.\n";
 
 /*
 				Theory of Operation
@@ -217,7 +217,7 @@
 MODULE_PARM(pc_debug, "i");
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 static char *version =
-"3c574_cs.c 1.000 1998/1/8 Donald Becker, becker@cesdis.gsfc.nasa.gov.\n";
+"3c574_cs.c 1.000 1998/1/8 Donald Becker, becker@scyld.com.\n";
 #else
 #define DEBUG(n, args...)
 #endif
diff -uNr linux-2.4.5-ac4/drivers/net/pcmcia/3c589_cs.c linux/drivers/net/pcmcia/3c589_cs.c
--- linux-2.4.5-ac4/drivers/net/pcmcia/3c589_cs.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/pcmcia/3c589_cs.c	Wed May 30 01:08:40 2001
@@ -13,7 +13,7 @@
     Director, National Security Agency.  This software may be used and
     distributed according to the terms of the GNU General Public License,
     incorporated herein by reference.
-    Donald Becker may be reached at becker@cesdis1.gsfc.nasa.gov
+    Donald Becker may be reached at becker@scyld.com
 
 ======================================================================*/
 
diff -uNr linux-2.4.5-ac4/drivers/net/pcmcia/fmvj18x_cs.c linux/drivers/net/pcmcia/fmvj18x_cs.c
--- linux-2.4.5-ac4/drivers/net/pcmcia/fmvj18x_cs.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/pcmcia/fmvj18x_cs.c	Wed May 30 01:08:40 2001
@@ -21,9 +21,9 @@
     This software may be used and distributed according to the terms
     of the GNU General Public License, incorporated herein by reference.
     
-    The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-    Center of Excellence in Space Data and Information Sciences
-    Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+    The author may be reached as becker@scyld.com, or C/O
+    Scyld Computing Corporation
+    410 Severn Ave., Suite 210, Annapolis MD 21403
     
 ======================================================================*/
 
diff -uNr linux-2.4.5-ac4/drivers/net/pcmcia/nmclan_cs.c linux/drivers/net/pcmcia/nmclan_cs.c
--- linux-2.4.5-ac4/drivers/net/pcmcia/nmclan_cs.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/pcmcia/nmclan_cs.c	Wed May 30 01:08:40 2001
@@ -27,7 +27,7 @@
   Tom Pollard, New Media Corporation
   Dean Siasoyco, New Media Corporation
   Ken Lesniak, Silicon Graphics, Inc. <lesniak@boston.sgi.com>
-  Donald Becker <becker@cesdis1.gsfc.nasa.gov>
+  Donald Becker <becker@scyld.com>
   David Hinds <dahinds@users.sourceforge.net>
 
   The Linux client driver is based on the 3c589_cs.c client driver by
diff -uNr linux-2.4.5-ac4/drivers/net/pcmcia/pcnet_cs.c linux/drivers/net/pcmcia/pcnet_cs.c
--- linux-2.4.5-ac4/drivers/net/pcmcia/pcnet_cs.c	Sat May 19 18:35:47 2001
+++ linux/drivers/net/pcmcia/pcnet_cs.c	Wed May 30 01:08:40 2001
@@ -20,7 +20,7 @@
     Director, National Security Agency.  This software may be used and
     distributed according to the terms of the GNU General Public License,
     incorporated herein by reference.
-    Donald Becker may be reached at becker@cesdis1.gsfc.nasa.gov
+    Donald Becker may be reached at becker@scyld.com.
 
     Based also on Keith Moore's changes to Don Becker's code, for IBM
     CCAE support.  Drivers merged back together, and shared-memory
diff -uNr linux-2.4.5-ac4/drivers/net/pcmcia/smc91c92_cs.c linux/drivers/net/pcmcia/smc91c92_cs.c
--- linux-2.4.5-ac4/drivers/net/pcmcia/smc91c92_cs.c	Sat May 19 18:35:48 2001
+++ linux/drivers/net/pcmcia/smc91c92_cs.c	Wed May 30 01:08:40 2001
@@ -11,7 +11,7 @@
     smc91c92_cs.c 1.106 2001/02/07 00:19:58
     
     This driver contains code written by Donald Becker
-    (becker@cesdis.gsfc.nasa.gov), Rowan Hughes (x-csrdh@jcu.edu.au),
+    (becker@scyld.com), Rowan Hughes (x-csrdh@jcu.edu.au),
     David Hinds (dahinds@users.sourceforge.net), and Erik Stahlman
     (erik@vt.edu).  Donald wrote the SMC 91c92 code using parts of
     Erik's SMC 91c94 driver.  Rowan wrote a similar driver, and I've
@@ -60,7 +60,7 @@
 static int pc_debug = PCMCIA_DEBUG;
 MODULE_PARM(pc_debug, "i");
 static const char *version =
-"smc91c92_cs.c 0.09 1996/8/4 Donald Becker, becker@cesdis.gsfc.nasa.gov.\n";
+"smc91c92_cs.c 0.09 1996/8/4 Donald Becker, becker@scyld.com.\n";
 #define DEBUG(n, args...) if (pc_debug>(n)) printk(KERN_DEBUG args)
 #else
 #define DEBUG(n, args...)
diff -uNr linux-2.4.5-ac4/drivers/net/pcmcia/xircom_tulip_cb.c linux/drivers/net/pcmcia/xircom_tulip_cb.c
--- linux-2.4.5-ac4/drivers/net/pcmcia/xircom_tulip_cb.c	Sat May 19 18:34:44 2001
+++ linux/drivers/net/pcmcia/xircom_tulip_cb.c	Wed May 30 01:08:40 2001
@@ -9,9 +9,10 @@
 	It should work with most DEC 21*4*-based chips/ethercards, as well as
 	with work-alike chips from Lite-On (PNIC) and Macronix (MXIC) and ASIX.
 
-	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-	Center of Excellence in Space Data and Information Sciences
-	   Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
 	Support and updates available at
 	http://cesdis.gsfc.nasa.gov/linux/drivers/tulip.html
@@ -19,7 +20,7 @@
 
 #define SMP_CHECK
 #define CARDBUS 1
-static const char version[] = "xircom_tulip_cb.c:v0.91 4/14/99 becker@cesdis.gsfc.nasa.gov (modified by danilo@cs.uni-magdeburg.de for XIRCOM CBE, fixed by Doug Ledford)\n";
+static const char version[] = "xircom_tulip_cb.c:v0.91 4/14/99 becker@scyld.com (modified by danilo@cs.uni-magdeburg.de for XIRCOM CBE, fixed by Doug Ledford)\n";
 
 /* A few user-configurable values. */
 
@@ -120,7 +121,7 @@
 /* Kernel compatibility defines, some common to David Hinds' PCMCIA package.
    This is only in the support-all-kernels source code. */
 
-MODULE_AUTHOR("Donald Becker <becker@cesdis.gsfc.nasa.gov>");
+MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
 MODULE_DESCRIPTION("Digital 21*4* Tulip ethernet driver");
 MODULE_PARM(debug, "i");
 MODULE_PARM(max_interrupt_work, "i");
diff -uNr linux-2.4.5-ac4/drivers/net/plip.c linux/drivers/net/plip.c
--- linux-2.4.5-ac4/drivers/net/plip.c	Wed May 30 01:08:55 2001
+++ linux/drivers/net/plip.c	Wed May 30 01:08:40 2001
@@ -2,7 +2,7 @@
 /* PLIP: A parallel port "network" driver for Linux. */
 /* This driver is for parallel port with 5-bit cable (LapLink (R) cable). */
 /*
- * Authors:	Donald Becker <becker@super.org>
+ * Authors:	Donald Becker <becker@scyld.com>
  *		Tommy Thorn <thorn@daimi.aau.dk>
  *		Tanabe Hiroyasu <hiro@sanpo.t.u-tokyo.ac.jp>
  *		Alan Cox <gw4pts@gw4pts.ampr.org>
@@ -37,7 +37,7 @@
  */
 
 /*
- * Original version and the name 'PLIP' from Donald Becker <becker@super.org>
+ * Original version and the name 'PLIP' from Donald Becker <becker@scyld.com>
  * inspired by Russ Nelson's parallel port packet driver.
  *
  * NOTE:
diff -uNr linux-2.4.5-ac4/drivers/net/smc-ultra.c linux/drivers/net/smc-ultra.c
--- linux-2.4.5-ac4/drivers/net/smc-ultra.c	Wed May 30 01:08:55 2001
+++ linux/drivers/net/smc-ultra.c	Wed May 30 01:08:40 2001
@@ -10,9 +10,10 @@
 	This software may be used and distributed according to the terms
 	of the GNU General Public License, incorporated herein by reference.
 
-	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-	Center of Excellence in Space Data and Information Sciences
-		Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
 	This driver uses the cards in the 8390-compatible mode.
 	Most of the run-time complexity is handled by the generic code in
diff -uNr linux-2.4.5-ac4/drivers/net/smc9194.c linux/drivers/net/smc9194.c
--- linux-2.4.5-ac4/drivers/net/smc9194.c	Wed May 30 01:08:56 2001
+++ linux/drivers/net/smc9194.c	Wed May 30 01:08:40 2001
@@ -25,7 +25,7 @@
  .
  . Sources:
  .    o   SMC databook
- .    o   skeleton.c by Donald Becker ( becker@cesdis.gsfc.nasa.gov )
+ .    o   skeleton.c by Donald Becker ( becker@scyld.com )
  .    o   ( a LOT of advice from Becker as well )
  .
  . History:
diff -uNr linux-2.4.5-ac4/drivers/net/tokenring/ibmtr.c linux/drivers/net/tokenring/ibmtr.c
--- linux-2.4.5-ac4/drivers/net/tokenring/ibmtr.c	Mon May 28 01:34:55 2001
+++ linux/drivers/net/tokenring/ibmtr.c	Wed May 30 01:08:40 2001
@@ -7,7 +7,7 @@
  *	This device driver should work with Any IBM Token Ring Card that does
  *	not use DMA.
  *
- *	I used Donald Becker's (becker@cesdis.gsfc.nasa.gov) device driver work
+ *	I used Donald Becker's (becker@scyld.com) device driver work
  *	as a base for most of my initial work.
  *
  *	Changes by Peter De Schrijver
diff -uNr linux-2.4.5-ac4/drivers/net/wan/sbni.c linux/drivers/net/wan/sbni.c
--- linux-2.4.5-ac4/drivers/net/wan/sbni.c	Sat May 19 18:34:47 2001
+++ linux/drivers/net/wan/sbni.c	Wed May 30 01:08:40 2001
@@ -22,7 +22,7 @@
  *   //      - for bug hunting and many ideas
  *   //   Alan Cox (Alan.Cox@linux.org)
  *   //	     - for consulting in some hardcore questions
- *   //   Donald Becker (becker@cesdis.gsfc.nasa.gov)
+ *   //   Donald Becker (becker@scyld.com)
  *   //      - for pretty nice skeleton 
  * 
  *   More info and useful utilities to work w/ SBNI you can find at 
diff -uNr linux-2.4.5-ac4/drivers/net/wavelan.c linux/drivers/net/wavelan.c
--- linux-2.4.5-ac4/drivers/net/wavelan.c	Mon May 28 01:34:55 2001
+++ linux/drivers/net/wavelan.c	Wed May 30 01:08:40 2001
@@ -4301,7 +4301,7 @@
  * It is based on other device drivers and information
  * either written or supplied by:
  *	Ajay Bakre (bakre@paul.rutgers.edu),
- *	Donald Becker (becker@cesdis.gsfc.nasa.gov),
+ *	Donald Becker (becker@scyld.com),
  *	Loeke Brederveld (Loeke.Brederveld@Utrecht.NCR.com),
  *	Anders Klemets (klemets@it.kth.se),
  *	Vladimir V. Kolpakov (w@stier.koenig.ru),
diff -uNr linux-2.4.5-ac4/drivers/net/wd.c linux/drivers/net/wd.c
--- linux-2.4.5-ac4/drivers/net/wd.c	Wed May 30 01:08:56 2001
+++ linux/drivers/net/wd.c	Wed May 30 01:08:40 2001
@@ -8,9 +8,10 @@
 	This software may be used and distributed according to the terms
 	of the GNU General Public License, incorporated herein by reference.
 
-	The author may be reached as becker@CESDIS.gsfc.nasa.gov, or C/O
-	Center of Excellence in Space Data and Information Sciences
-	   Code 930.5, Goddard Space Flight Center, Greenbelt MD 20771
+	The author may be reached as becker@scyld.com, or C/O
+	Scyld Computing Corporation
+	410 Severn Ave., Suite 210
+	Annapolis MD 21403
 
 	This is a driver for WD8003 and WD8013 "compatible" ethercards.
 
diff -uNr linux-2.4.5-ac4/drivers/net/znet.c linux/drivers/net/znet.c
--- linux-2.4.5-ac4/drivers/net/znet.c	Sat May 19 18:35:52 2001
+++ linux/drivers/net/znet.c	Wed May 30 01:08:40 2001
@@ -5,7 +5,7 @@
 /*
 	Written by Donald Becker.
 
-	The author may be reached as becker@cesdis.gsfc.nasa.gov.
+	The author may be reached as becker@scyld.com.
 	This driver is based on the Linux skeleton driver.  The copyright of the
 	skeleton driver is held by the United States Government, as represented
 	by DIRNSA, and it is released under the GPL.


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
