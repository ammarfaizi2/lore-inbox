Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272675AbTG0XRJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 19:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272946AbTG0XCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 19:02:16 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272867AbTG0XAz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:00:55 -0400
Date: Sun, 27 Jul 2003 21:11:41 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272011.h6RKBftf029678@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: idents for all the new skge cards
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/pci/pci.ids linux-2.6.0-test2-ac1/drivers/pci/pci.ids
--- linux-2.6.0-test2/drivers/pci/pci.ids	2003-07-27 19:56:24.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/pci/pci.ids	2003-07-27 20:22:48.000000000 +0100
@@ -2190,6 +2190,9 @@
 	1006  MINI PCI type 3B Data Fax Modem
 	1007  Mini PCI 56k Winmodem
 		10b7 615c  Mini PCI 56K Modem
+	1700  Gigabit Ethernet Adapter
+		10b7 0010  3Com 3C940 Gigabit LOM Ethernet Adapter
+		10b7 0020  3Com 3C941 Gigabit LOM Ethernet Adapter
 	3390  3c339 TokenLink Velocity
 	3590  3c359 TokenLink Velocity XL
 		10b7 3590  TokenLink Velocity XL Adapter (3C359/359B)
@@ -3205,15 +3208,44 @@
 		1148 5843  FDDI SK-5843 (SK-NET FDDI-LP64)
 		1148 5844  FDDI SK-5844 (SK-NET FDDI-LP64 DAS)
 	4200  Token Ring adapter
-	4300  Gigabit Ethernet
-		1148 9821  SK-9821 (1000Base-T single link)
-		1148 9822  SK-9822 (1000Base-T dual link)
-		1148 9841  SK-9841 (1000Base-LX single link)
-		1148 9842  SK-9842 (1000Base-LX dual link)
-		1148 9843  SK-9843 (1000Base-SX single link)
-		1148 9844  SK-9844 (1000Base-SX dual link)
-		1148 9861  SK-9861 (1000Base-SX VF45 single link)
-		1148 9862  SK-9862 (1000Base-SX VF45 dual link)
+	4300  SK-98xx Gigabit Ethernet Server Adapter
+		1148 9821  SK-9821 Gigabit Ethernet Server Adapter (SK-NET GE-T)
+		1148 9822  SK-9822 Gigabit Ethernet Server Adapter (SK-NET GE-T dual link)
+		1148 9841  SK-9841 Gigabit Ethernet Server Adapter (SK-NET GE-LX)
+		1148 9842  SK-9842 Gigabit Ethernet Server Adapter (SK-NET GE-LX dual link)
+		1148 9843  SK-9843 Gigabit Ethernet Server Adapter (SK-NET GE-SX)
+		1148 9844  SK-9844 Gigabit Ethernet Server Adapter (SK-NET GE-SX dual link)
+		1148 9861  SK-9861 Gigabit Ethernet Server Adapter (SK-NET GE-SX Volition)
+		1148 9862  SK-9862 Gigabit Ethernet Server Adapter (SK-NET GE-SX Volition dual link)
+		1148 9871  SK-9871 Gigabit Ethernet Server Adapter (SK-NET GE-ZX)
+		1148 9872  SK-9872 Gigabit Ethernet Server Adapter (SK-NET GE-ZX dual link)
+		1259 2970  Allied Telesyn AT-2970SX Gigabit Ethernet Adapter
+		1259 2971  Allied Telesyn AT-2970LX Gigabit Ethernet Adapter
+		1259 2972  Allied Telesyn AT-2970TX Gigabit Ethernet Adapter
+		1259 2973  Allied Telesyn AT-2971SX Gigabit Ethernet Adapter
+		1259 2974  Allied Telesyn AT-2971T Gigabit Ethernet Adapter
+		1259 2975  Allied Telesyn AT-2970SX/2SC Gigabit Ethernet Adapter
+		1259 2976  Allied Telesyn AT-2970LX/2SC Gigabit Ethernet Adapter
+		1259 2977  Allied Telesyn AT-2970TX/2TX Gigabit Ethernet Adapter
+	4320  SK-98xx V2.0 Gigabit Ethernet Adapter
+		1148 0121  Marvell RDK-8001 Adapter
+		1148 0221  Marvell RDK-8002 Adapter
+		1148 0321  Marvell RDK-8003 Adapter
+		1148 0421  Marvell RDK-8004 Adapter
+		1148 0621  Marvell RDK-8006 Adapter
+		1148 0721  Marvell RDK-8007 Adapter
+		1148 0821  Marvell RDK-8008 Adapter
+		1148 0921  Marvell RDK-8009 Adapter
+		1148 1121  Marvell RDK-8011 Adapter
+		1148 1221  Marvell RDK-8012 Adapter
+		1148 3221  SK-9521 V2.0 10/100/1000Base-T Adapter
+		1148 5021  SK-9821 V2.0 Gigabit Ethernet 10/100/1000Base-T Adapter
+		1148 5041  SK-9841 V2.0 Gigabit Ethernet 1000Base-LX Adapter
+		1148 5043  SK-9843 V2.0 Gigabit Ethernet 1000Base-SX Adapter
+		1148 5051  SK-9851 V2.0 Gigabit Ethernet 1000Base-SX Adapter
+		1148 5061  SK-9861 V2.0 Gigabit Ethernet 1000Base-SX Adapter
+		1148 5071  SK-9871 V2.0 Gigabit Ethernet 1000Base-ZX Adapter
+		1148 9521  SK-9521 10/100/1000Base-T Adapter
 	4400  Gigabit Ethernet
 1149  Win System Corporation
 114a  VMIC
@@ -3426,6 +3458,8 @@
 	1340  DFE-690TXD CardBus PC Card
 	1561  DRP-32TXD Cardbus PC Card
 	4000  DL2K Ethernet
+	4c00  Gigabit Ethernet Adapter
+		1186 4c00  DGE-530T Gigabit Ethernet Adapter
 1187  Advanced Technology Laboratories, Inc.
 1188  Shima Seiki Manufacturing Ltd.
 1189  Matsushita Electronics Co Ltd
@@ -3503,6 +3537,8 @@
 11aa  Actel
 11ab  Galileo Technology Ltd.
 	0146  GT-64010/64010A System Controller
+	4320  Gigabit Ethernet Adapter
+		11ab 9521  Marvell Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
 	4611  GT-64115 System Controller
 	4620  GT-64120/64120A/64121A System Controller
 	4801  GT-48001
@@ -4720,6 +4754,8 @@
 136f  Applied Magic Inc
 1370  ATL Products
 1371  CNet Technology Inc
+	434e  GigaCard Network Adapter
+		1371 434e  N-Way PCI-Bus Giga-Card 1000/100/10Mbps(L)
 1373  Silicon Vision Inc
 1374  Silicom Ltd
 1375  Argosystems Inc
@@ -5830,6 +5866,10 @@
 170c  YottaYotta Inc.
 172a  Accelerated Encryption
 1737  Linksys
+	1032  Gigabit Network Adapter
+		1737 0015  EG1032 v2 Instant Gigabit Network Adapter
+	1064  Gigabit Network Adapter
+		1737 0016  EG1064 v2 Instant Gigabit Network Adapter
 173b  Altima (nee Broadcom)
 	03e8  AC1000 Gigabit Ethernet
 	03e9  AC1001 Gigabit Ethernet
