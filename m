Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUJ3A2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUJ3A2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263699AbUJ3AT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:19:26 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:27840 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S263735AbUJ3AOe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:14:34 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, james4765@verizon.net
Message-Id: <20041030001430.12226.20083.89703@localhost.localdomain>
In-Reply-To: <20041030001423.12226.74257.30654@localhost.localdomain>
References: <20041030001423.12226.74257.30654@localhost.localdomain>
Subject: [PATCH 1/2] to Documentation/digiecpa.txt
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.211.53] at Fri, 29 Oct 2004 19:14:30 -0500
Date: Fri, 29 Oct 2004 19:14:30 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Update status of digiecpa driver & fix broken links in Documentation/digiecpa.txt.
Apply against 2.6.9.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.9-original/Documentation/digiepca.txt linux-2.6.9/Documentation/digiepca.txt
--- linux-2.6.9-original/Documentation/digiepca.txt	2004-10-18 17:53:06.000000000 -0400
+++ linux-2.6.9/Documentation/digiepca.txt	2004-10-29 20:03:48.968948646 -0400
@@ -1,3 +1,11 @@
+NOTE:  This driver is obsolete.  Digi provides a 2.6 driver (dgdm) at
+http://www.digi.com for PCI cards.  They no longer maintain this driver,
+and have no 2.6 driver for ISA cards.
+
+This driver requires a number of user-space tools.  They can be aquired from
+http://www.digi.com, but only works with 2.4 kernels.
+
+
 The Digi Intl. epca driver. 
 ----------------------------
 The Digi Intl. epca driver for Linux supports the following boards:
@@ -64,9 +72,6 @@
 this driver REQUIRES that digiDload be executed prior to it being used. 
 Failure to do this will result in an ENODEV error.
 
-The latest version of the tool package is available at:
-ftp://ftp.dgii.com/drivers/linux/released/async/
-
 Documentation:
 --------------
 Complete documentation for this product may be found in the tool package. 
@@ -74,14 +79,8 @@
 Sources of information and support:
 -----------------------------------
 Digi Intl. support site for this product:
--> digilnux@dgii.com 
 
-Related information and information concerning other drivers supporting 
-Digi Intl. products:
-
--> FTP: ftp://dgii.com
--> Webpage: http://www.dgii.com
--> Webpage: http://lameter.com/digi
+->  http://www.digi.com
 
 Acknowledgments:
 ----------------
@@ -90,3 +89,10 @@
 1994,1995 Troy De Jongh.  Many thanks to Christoph Lameter 
 (christoph@lameter.com) and Mike McLagan (mike.mclagan@linux.org) who authored 
 and contributed to the original document. 
+
+Changelog:
+----------
+10-29-04:	Update status of driver, remove dead links in document
+		James Nelson <james4765@gmail.com>
+
+2000 (?)	Original Document
