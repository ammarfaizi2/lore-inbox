Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSLCNA1>; Tue, 3 Dec 2002 08:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261310AbSLCNA0>; Tue, 3 Dec 2002 08:00:26 -0500
Received: from johanna5.ux.his.no ([152.94.1.25]:10156 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP
	id <S261330AbSLCNAX>; Tue, 3 Dec 2002 08:00:23 -0500
Date: Tue, 3 Dec 2002 14:07:38 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@gnu.org>,
       linux-mips@linux-mips.org
Subject: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (mips)
Message-ID: <20021203130738.GF2417@johanna5.ux.his.no>
References: <20021203125120.GA2417@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203125120.GA2417@johanna5.ux.his.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_UDF_RW from mips{,64} defconfigs, (it's not used anymore)

Regards,
	Erlend Aasland

diff -urN linux-2.5.50/arch/mips/defconfig linux-2.5.50-eaa/arch/mips/defconfig
--- linux-2.5.50/arch/mips/defconfig	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig	Tue Dec  3 00:48:05 2002
@@ -456,7 +456,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-atlas linux-2.5.50-eaa/arch/mips/defconfig-atlas
--- linux-2.5.50/arch/mips/defconfig-atlas	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-atlas	Tue Dec  3 00:48:05 2002
@@ -446,7 +446,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-ddb5476 linux-2.5.50-eaa/arch/mips/defconfig-ddb5476
--- linux-2.5.50/arch/mips/defconfig-ddb5476	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-ddb5476	Tue Dec  3 00:48:05 2002
@@ -480,7 +480,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-ddb5477 linux-2.5.50-eaa/arch/mips/defconfig-ddb5477
--- linux-2.5.50/arch/mips/defconfig-ddb5477	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-ddb5477	Tue Dec  3 00:48:05 2002
@@ -407,7 +407,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-decstation linux-2.5.50-eaa/arch/mips/defconfig-decstation
--- linux-2.5.50/arch/mips/defconfig-decstation	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-decstation	Tue Dec  3 00:48:05 2002
@@ -443,7 +443,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-ip22 linux-2.5.50-eaa/arch/mips/defconfig-ip22
--- linux-2.5.50/arch/mips/defconfig-ip22	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-ip22	Tue Dec  3 00:48:05 2002
@@ -456,7 +456,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-it8172 linux-2.5.50-eaa/arch/mips/defconfig-it8172
--- linux-2.5.50/arch/mips/defconfig-it8172	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-it8172	Tue Dec  3 00:48:05 2002
@@ -559,7 +559,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-malta linux-2.5.50-eaa/arch/mips/defconfig-malta
--- linux-2.5.50/arch/mips/defconfig-malta	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-malta	Tue Dec  3 00:48:05 2002
@@ -472,7 +472,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-nino linux-2.5.50-eaa/arch/mips/defconfig-nino
--- linux-2.5.50/arch/mips/defconfig-nino	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-nino	Tue Dec  3 00:48:05 2002
@@ -283,7 +283,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_NCPFS_NLS is not set
diff -urN linux-2.5.50/arch/mips/defconfig-ocelot linux-2.5.50-eaa/arch/mips/defconfig-ocelot
--- linux-2.5.50/arch/mips/defconfig-ocelot	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-ocelot	Tue Dec  3 00:48:05 2002
@@ -408,7 +408,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-pb1000 linux-2.5.50-eaa/arch/mips/defconfig-pb1000
--- linux-2.5.50/arch/mips/defconfig-pb1000	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-pb1000	Tue Dec  3 00:48:05 2002
@@ -395,7 +395,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips/defconfig-rm200 linux-2.5.50-eaa/arch/mips/defconfig-rm200
--- linux-2.5.50/arch/mips/defconfig-rm200	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips/defconfig-rm200	Tue Dec  3 00:48:05 2002
@@ -326,7 +326,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set

diff -urN linux-2.5.50/arch/mips64/defconfig linux-2.5.50-eaa/arch/mips64/defconfig
--- linux-2.5.50/arch/mips64/defconfig	Sun Oct 13 19:24:14 2002
+++ linux-2.5.50-eaa/arch/mips64/defconfig	Tue Dec  3 00:48:05 2002
@@ -414,7 +414,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips64/defconfig-ip22 linux-2.5.50-eaa/arch/mips64/defconfig-ip22
--- linux-2.5.50/arch/mips64/defconfig-ip22	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips64/defconfig-ip22	Tue Dec  3 00:48:05 2002
@@ -418,7 +418,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips64/defconfig-ip27 linux-2.5.50-eaa/arch/mips64/defconfig-ip27
--- linux-2.5.50/arch/mips64/defconfig-ip27	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips64/defconfig-ip27	Tue Dec  3 00:48:05 2002
@@ -413,7 +413,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/mips64/defconfig-ip32 linux-2.5.50-eaa/arch/mips64/defconfig-ip32
--- linux-2.5.50/arch/mips64/defconfig-ip32	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/mips64/defconfig-ip32	Tue Dec  3 00:48:05 2002
@@ -444,7 +444,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
