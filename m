Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUHJANf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUHJANf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 20:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266877AbUHJANf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 20:13:35 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:45286 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267359AbUHJANS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 20:13:18 -0400
Date: Mon, 9 Aug 2004 17:13:17 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] Remove spaces from PCI IDE pci_driver.name field
Message-ID: <20040810001316.GA7292@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Spaces in driver names show up as spaces in sysfs. Annoying.  
I went ahead and changed ones that don't have spaces to use
${NAME}_IDE so they are all consistent.

Please apply,
~Deepak

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>

===== drivers/ide/pci/aec62xx.c 1.22 vs edited =====
--- 1.22/drivers/ide/pci/aec62xx.c	Tue Jun 15 20:17:44 2004
+++ edited/drivers/ide/pci/aec62xx.c	Mon Aug  9 16:59:00 2004
@@ -540,7 +540,7 @@
 MODULE_DEVICE_TABLE(pci, aec62xx_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "AEC62xx IDE",
+	.name		= "AEC62xx_IDE",
 	.id_table	= aec62xx_pci_tbl,
 	.probe		= aec62xx_init_one,
 };
===== drivers/ide/pci/alim15x3.c 1.25 vs edited =====
--- 1.25/drivers/ide/pci/alim15x3.c	Tue Jun 15 09:29:40 2004
+++ edited/drivers/ide/pci/alim15x3.c	Mon Aug  9 16:59:05 2004
@@ -893,7 +893,7 @@
 MODULE_DEVICE_TABLE(pci, alim15x3_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "ALI15x3 IDE",
+	.name		= "ALI15x3_IDE",
 	.id_table	= alim15x3_pci_tbl,
 	.probe		= alim15x3_init_one,
 };
===== drivers/ide/pci/amd74xx.c 1.32 vs edited =====
--- 1.32/drivers/ide/pci/amd74xx.c	Wed Jun 16 21:24:28 2004
+++ edited/drivers/ide/pci/amd74xx.c	Mon Aug  9 16:59:08 2004
@@ -520,7 +520,7 @@
 MODULE_DEVICE_TABLE(pci, amd74xx_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "AMD IDE",
+	.name		= "AMD_IDE",
 	.id_table	= amd74xx_pci_tbl,
 	.probe		= amd74xx_probe,
 };
===== drivers/ide/pci/atiixp.c 1.3 vs edited =====
--- 1.3/drivers/ide/pci/atiixp.c	Tue Jun  1 12:04:38 2004
+++ edited/drivers/ide/pci/atiixp.c	Mon Aug  9 16:59:12 2004
@@ -490,7 +490,7 @@
 MODULE_DEVICE_TABLE(pci, atiixp_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "ATIIXP IDE",
+	.name		= "ATIIXP_IDE",
 	.id_table	= atiixp_pci_tbl,
 	.probe		= atiixp_init_one,
 };
===== drivers/ide/pci/cmd64x.c 1.23 vs edited =====
--- 1.23/drivers/ide/pci/cmd64x.c	Tue Jun 15 20:17:44 2004
+++ edited/drivers/ide/pci/cmd64x.c	Mon Aug  9 16:59:15 2004
@@ -760,7 +760,7 @@
 MODULE_DEVICE_TABLE(pci, cmd64x_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "CMD64x IDE",
+	.name		= "CMD64x_IDE",
 	.id_table	= cmd64x_pci_tbl,
 	.probe		= cmd64x_init_one,
 };
===== drivers/ide/pci/cs5520.c 1.11 vs edited =====
--- 1.11/drivers/ide/pci/cs5520.c	Tue Jun 15 09:29:40 2004
+++ edited/drivers/ide/pci/cs5520.c	Mon Aug  9 16:59:19 2004
@@ -319,7 +319,7 @@
 MODULE_DEVICE_TABLE(pci, cs5520_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "CyrixIDE",
+	.name		= "Cyrix_IDE",
 	.id_table	= cs5520_pci_tbl,
 	.probe		= cs5520_init_one,
 };
===== drivers/ide/pci/cy82c693.c 1.17 vs edited =====
--- 1.17/drivers/ide/pci/cy82c693.c	Thu Mar 18 06:20:56 2004
+++ edited/drivers/ide/pci/cy82c693.c	Mon Aug  9 16:59:34 2004
@@ -444,7 +444,7 @@
 MODULE_DEVICE_TABLE(pci, cy82c693_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "Cypress IDE",
+	.name		= "Cypress_IDE",
 	.id_table	= cy82c693_pci_tbl,
 	.probe		= cy82c693_init_one,
 };
===== drivers/ide/pci/generic.c 1.17 vs edited =====
--- 1.17/drivers/ide/pci/generic.c	Wed Jun 16 20:29:02 2004
+++ edited/drivers/ide/pci/generic.c	Mon Aug  9 16:59:37 2004
@@ -138,7 +138,7 @@
 MODULE_DEVICE_TABLE(pci, generic_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "PCI IDE",
+	.name		= "PCI_IDE",
 	.id_table	= generic_pci_tbl,
 	.probe		= generic_init_one,
 };
===== drivers/ide/pci/hpt34x.c 1.23 vs edited =====
--- 1.23/drivers/ide/pci/hpt34x.c	Tue Jun 15 20:17:44 2004
+++ edited/drivers/ide/pci/hpt34x.c	Mon Aug  9 16:59:41 2004
@@ -339,7 +339,7 @@
 MODULE_DEVICE_TABLE(pci, hpt34x_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "HPT34x IDE",
+	.name		= "HPT34x_IDE",
 	.id_table	= hpt34x_pci_tbl,
 	.probe		= hpt34x_init_one,
 };
===== drivers/ide/pci/hpt366.c 1.36 vs edited =====
--- 1.36/drivers/ide/pci/hpt366.c	Sat Jul 31 16:58:31 2004
+++ edited/drivers/ide/pci/hpt366.c	Mon Aug  9 16:59:44 2004
@@ -1403,7 +1403,7 @@
 MODULE_DEVICE_TABLE(pci, hpt366_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "HPT366 IDE",
+	.name		= "HPT366_IDE",
 	.id_table	= hpt366_pci_tbl,
 	.probe		= hpt366_init_one,
 };
===== drivers/ide/pci/it8172.c 1.18 vs edited =====
--- 1.18/drivers/ide/pci/it8172.c	Tue Jun  1 12:04:38 2004
+++ edited/drivers/ide/pci/it8172.c	Mon Aug  9 16:59:47 2004
@@ -302,7 +302,7 @@
 MODULE_DEVICE_TABLE(pci, it8172_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "IT8172IDE",
+	.name		= "IT8172_IDE",
 	.id_table	= it8172_pci_tbl,
 	.probe		= it8172_init_one,
 };
===== drivers/ide/pci/ns87415.c 1.19 vs edited =====
--- 1.19/drivers/ide/pci/ns87415.c	Tue Jun 15 09:29:40 2004
+++ edited/drivers/ide/pci/ns87415.c	Mon Aug  9 16:59:50 2004
@@ -236,7 +236,7 @@
 MODULE_DEVICE_TABLE(pci, ns87415_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "NS87415IDE",
+	.name		= "NS87415_IDE",
 	.id_table	= ns87415_pci_tbl,
 	.probe		= ns87415_init_one,
 };
===== drivers/ide/pci/opti621.c 1.18 vs edited =====
--- 1.18/drivers/ide/pci/opti621.c	Tue Jun  1 12:04:38 2004
+++ edited/drivers/ide/pci/opti621.c	Mon Aug  9 16:59:55 2004
@@ -367,7 +367,7 @@
 MODULE_DEVICE_TABLE(pci, opti621_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "Opti621 IDE",
+	.name		= "Opti621_IDE",
 	.id_table	= opti621_pci_tbl,
 	.probe		= opti621_init_one,
 };
===== drivers/ide/pci/pdc202xx_new.c 1.30 vs edited =====
--- 1.30/drivers/ide/pci/pdc202xx_new.c	Tue Jun 15 20:17:44 2004
+++ edited/drivers/ide/pci/pdc202xx_new.c	Mon Aug  9 16:59:58 2004
@@ -531,7 +531,7 @@
 MODULE_DEVICE_TABLE(pci, pdc202new_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "Promise IDE",
+	.name		= "Promise_IDE",
 	.id_table	= pdc202new_pci_tbl,
 	.probe		= pdc202new_init_one,
 };
===== drivers/ide/pci/pdc202xx_old.c 1.33 vs edited =====
--- 1.33/drivers/ide/pci/pdc202xx_old.c	Fri Jun 25 10:03:57 2004
+++ edited/drivers/ide/pci/pdc202xx_old.c	Mon Aug  9 17:00:04 2004
@@ -905,7 +905,7 @@
 MODULE_DEVICE_TABLE(pci, pdc202xx_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "Promise Old IDE",
+	.name		= "Promise_Old_IDE",
 	.id_table	= pdc202xx_pci_tbl,
 	.probe		= pdc202xx_init_one,
 };
===== drivers/ide/pci/piix.c 1.33 vs edited =====
--- 1.33/drivers/ide/pci/piix.c	Wed Jun 16 20:29:02 2004
+++ edited/drivers/ide/pci/piix.c	Mon Aug  9 17:00:08 2004
@@ -803,7 +803,7 @@
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "PIIX IDE",
+	.name		= "PIIX_IDE",
 	.id_table	= piix_pci_tbl,
 	.probe		= piix_init_one,
 };
===== drivers/ide/pci/rz1000.c 1.15 vs edited =====
--- 1.15/drivers/ide/pci/rz1000.c	Tue Jun 15 09:29:40 2004
+++ edited/drivers/ide/pci/rz1000.c	Mon Aug  9 17:00:11 2004
@@ -74,7 +74,7 @@
 MODULE_DEVICE_TABLE(pci, rz1000_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "RZ1000 IDE",
+	.name		= "RZ1000_IDE",
 	.id_table	= rz1000_pci_tbl,
 	.probe		= rz1000_init_one,
 };
===== drivers/ide/pci/sc1200.c 1.19 vs edited =====
--- 1.19/drivers/ide/pci/sc1200.c	Tue Jun 15 09:29:40 2004
+++ edited/drivers/ide/pci/sc1200.c	Mon Aug  9 17:00:14 2004
@@ -565,7 +565,7 @@
 MODULE_DEVICE_TABLE(pci, sc1200_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "SC1200 IDE",
+	.name		= "SC1200_IDE",
 	.id_table	= sc1200_pci_tbl,
 	.probe		= sc1200_init_one,
 	.suspend	= sc1200_suspend,
===== drivers/ide/pci/serverworks.c 1.29 vs edited =====
--- 1.29/drivers/ide/pci/serverworks.c	Tue Jun  1 12:04:38 2004
+++ edited/drivers/ide/pci/serverworks.c	Mon Aug  9 17:00:18 2004
@@ -812,7 +812,7 @@
 MODULE_DEVICE_TABLE(pci, svwks_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "Serverworks IDE",
+	.name		= "Serverworks_IDE",
 	.id_table	= svwks_pci_tbl,
 	.probe		= svwks_init_one,
 #if 0	/* FIXME: implement */
===== drivers/ide/pci/sgiioc4.c 1.9 vs edited =====
--- 1.9/drivers/ide/pci/sgiioc4.c	Tue Jun  1 12:04:38 2004
+++ edited/drivers/ide/pci/sgiioc4.c	Mon Aug  9 17:00:23 2004
@@ -782,7 +782,7 @@
 MODULE_DEVICE_TABLE(pci, sgiioc4_pci_tbl);
 
 static struct pci_driver driver = {
-	.name = "SGI-IOC4 IDE",
+	.name = "SGI-IOC4_IDE",
 	.id_table = sgiioc4_pci_tbl,
 	.probe = sgiioc4_init_one,
 };
===== drivers/ide/pci/siimage.c 1.32 vs edited =====
--- 1.32/drivers/ide/pci/siimage.c	Mon Jul 12 01:01:05 2004
+++ edited/drivers/ide/pci/siimage.c	Mon Aug  9 17:00:26 2004
@@ -1137,7 +1137,7 @@
 MODULE_DEVICE_TABLE(pci, siimage_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "SiI IDE",
+	.name		= "SiI_IDE",
 	.id_table	= siimage_pci_tbl,
 	.probe		= siimage_init_one,
 };
===== drivers/ide/pci/sis5513.c 1.27 vs edited =====
--- 1.27/drivers/ide/pci/sis5513.c	Tue Jun 15 09:29:40 2004
+++ edited/drivers/ide/pci/sis5513.c	Mon Aug  9 17:00:29 2004
@@ -968,7 +968,7 @@
 MODULE_DEVICE_TABLE(pci, sis5513_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "SIS IDE",
+	.name		= "SIS_IDE",
 	.id_table	= sis5513_pci_tbl,
 	.probe		= sis5513_init_one,
 };
===== drivers/ide/pci/sl82c105.c 1.20 vs edited =====
--- 1.20/drivers/ide/pci/sl82c105.c	Tue Jun 15 09:29:40 2004
+++ edited/drivers/ide/pci/sl82c105.c	Mon Aug  9 17:00:32 2004
@@ -503,7 +503,7 @@
 MODULE_DEVICE_TABLE(pci, sl82c105_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "W82C105 IDE",
+	.name		= "W82C105_IDE",
 	.id_table	= sl82c105_pci_tbl,
 	.probe		= sl82c105_init_one,
 };
===== drivers/ide/pci/slc90e66.c 1.22 vs edited =====
--- 1.22/drivers/ide/pci/slc90e66.c	Tue Jun 15 09:29:40 2004
+++ edited/drivers/ide/pci/slc90e66.c	Mon Aug  9 17:00:36 2004
@@ -387,7 +387,7 @@
 MODULE_DEVICE_TABLE(pci, slc90e66_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "SLC90e66 IDE",
+	.name		= "SLC90e66_IDE",
 	.id_table	= slc90e66_pci_tbl,
 	.probe		= slc90e66_init_one,
 };
===== drivers/ide/pci/triflex.c 1.9 vs edited =====
--- 1.9/drivers/ide/pci/triflex.c	Tue Jun 15 09:29:40 2004
+++ edited/drivers/ide/pci/triflex.c	Mon Aug  9 17:00:39 2004
@@ -242,7 +242,7 @@
 MODULE_DEVICE_TABLE(pci, triflex_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "TRIFLEX IDE",
+	.name		= "TRIFLEX_IDE",
 	.id_table	= triflex_pci_tbl,
 	.probe		= triflex_init_one,
 };
===== drivers/ide/pci/trm290.c 1.22 vs edited =====
--- 1.22/drivers/ide/pci/trm290.c	Wed Jun 23 15:55:00 2004
+++ edited/drivers/ide/pci/trm290.c	Mon Aug  9 17:00:41 2004
@@ -408,7 +408,7 @@
 MODULE_DEVICE_TABLE(pci, trm290_pci_tbl);
 
 static struct pci_driver driver = {
-	.name		= "TRM290 IDE",
+	.name		= "TRM290_IDE",
 	.id_table	= trm290_pci_tbl,
 	.probe		= trm290_init_one,
 };
===== drivers/ide/pci/via82cxxx.c 1.23 vs edited =====
--- 1.23/drivers/ide/pci/via82cxxx.c	Tue Jun 15 09:29:40 2004
+++ edited/drivers/ide/pci/via82cxxx.c	Mon Aug  9 17:00:46 2004
@@ -632,7 +632,7 @@
 MODULE_DEVICE_TABLE(pci, via_pci_tbl);
 
 static struct pci_driver driver = {
-	.name 		= "VIA IDE",
+	.name 		= "VIA_IDE",
 	.id_table 	= via_pci_tbl,
 	.probe 		= via_init_one,
 };

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
