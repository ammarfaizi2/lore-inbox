Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261375AbSLCNFA>; Tue, 3 Dec 2002 08:05:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSLCNFA>; Tue, 3 Dec 2002 08:05:00 -0500
Received: from johanna5.ux.his.no ([152.94.1.25]:16556 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP
	id <S261375AbSLCNEu>; Tue, 3 Dec 2002 08:04:50 -0500
Date: Tue, 3 Dec 2002 14:12:05 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
Subject: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (ppc)
Message-ID: <20021203131205.GH2417@johanna5.ux.his.no>
References: <20021203125120.GA2417@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203125120.GA2417@johanna5.ux.his.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused CONFIG_UDF_RW from ppc defconfigs...

Regards,
	Erlend Aasland

diff -urN linux-2.5.50/arch/ppc/configs/FADS_defconfig linux-2.5.50-eaa/arch/ppc/configs/FADS_defconfig
--- linux-2.5.50/arch/ppc/configs/FADS_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/FADS_defconfig	Tue Dec  3 00:48:05 2002
@@ -389,7 +389,6 @@
 # CONFIG_EXT2_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/IVMS8_defconfig linux-2.5.50-eaa/arch/ppc/configs/IVMS8_defconfig
--- linux-2.5.50/arch/ppc/configs/IVMS8_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/IVMS8_defconfig	Tue Dec  3 00:48:05 2002
@@ -417,7 +417,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/SM850_defconfig linux-2.5.50-eaa/arch/ppc/configs/SM850_defconfig
--- linux-2.5.50/arch/ppc/configs/SM850_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/SM850_defconfig	Tue Dec  3 00:48:05 2002
@@ -385,7 +385,6 @@
 # CONFIG_EXT2_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/SPD823TS_defconfig linux-2.5.50-eaa/arch/ppc/configs/SPD823TS_defconfig
--- linux-2.5.50/arch/ppc/configs/SPD823TS_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/SPD823TS_defconfig	Tue Dec  3 00:48:05 2002
@@ -384,7 +384,6 @@
 # CONFIG_EXT2_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/TQM823L_defconfig linux-2.5.50-eaa/arch/ppc/configs/TQM823L_defconfig
--- linux-2.5.50/arch/ppc/configs/TQM823L_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/TQM823L_defconfig	Tue Dec  3 00:48:05 2002
@@ -385,7 +385,6 @@
 # CONFIG_EXT2_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/TQM8260_defconfig linux-2.5.50-eaa/arch/ppc/configs/TQM8260_defconfig
--- linux-2.5.50/arch/ppc/configs/TQM8260_defconfig	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/TQM8260_defconfig	Tue Dec  3 00:48:05 2002
@@ -359,7 +359,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/TQM850L_defconfig linux-2.5.50-eaa/arch/ppc/configs/TQM850L_defconfig
--- linux-2.5.50/arch/ppc/configs/TQM850L_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/TQM850L_defconfig	Tue Dec  3 00:48:05 2002
@@ -385,7 +385,6 @@
 # CONFIG_EXT2_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/TQM860L_defconfig linux-2.5.50-eaa/arch/ppc/configs/TQM860L_defconfig
--- linux-2.5.50/arch/ppc/configs/TQM860L_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/TQM860L_defconfig	Tue Dec  3 00:48:05 2002
@@ -430,7 +430,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/adir_defconfig linux-2.5.50-eaa/arch/ppc/configs/adir_defconfig
--- linux-2.5.50/arch/ppc/configs/adir_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/adir_defconfig	Tue Dec  3 00:48:05 2002
@@ -527,7 +527,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/apus_defconfig linux-2.5.50-eaa/arch/ppc/configs/apus_defconfig
--- linux-2.5.50/arch/ppc/configs/apus_defconfig	Fri Nov 15 12:41:46 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/apus_defconfig	Tue Dec  3 00:48:05 2002
@@ -671,7 +671,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/ash_defconfig linux-2.5.50-eaa/arch/ppc/configs/ash_defconfig
--- linux-2.5.50/arch/ppc/configs/ash_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/ash_defconfig	Tue Dec  3 00:48:05 2002
@@ -445,7 +445,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/bseip_defconfig linux-2.5.50-eaa/arch/ppc/configs/bseip_defconfig
--- linux-2.5.50/arch/ppc/configs/bseip_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/bseip_defconfig	Tue Dec  3 00:48:05 2002
@@ -384,7 +384,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/cedar_defconfig linux-2.5.50-eaa/arch/ppc/configs/cedar_defconfig
--- linux-2.5.50/arch/ppc/configs/cedar_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/cedar_defconfig	Tue Dec  3 00:48:05 2002
@@ -447,7 +447,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/common_defconfig linux-2.5.50-eaa/arch/ppc/configs/common_defconfig
--- linux-2.5.50/arch/ppc/configs/common_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/common_defconfig	Tue Dec  3 00:48:05 2002
@@ -738,7 +738,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/cpci405_defconfig linux-2.5.50-eaa/arch/ppc/configs/cpci405_defconfig
--- linux-2.5.50/arch/ppc/configs/cpci405_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/cpci405_defconfig	Tue Dec  3 00:48:05 2002
@@ -471,7 +471,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/ep405_defconfig linux-2.5.50-eaa/arch/ppc/configs/ep405_defconfig
--- linux-2.5.50/arch/ppc/configs/ep405_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/ep405_defconfig	Tue Dec  3 00:48:05 2002
@@ -441,7 +441,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/est8260_defconfig linux-2.5.50-eaa/arch/ppc/configs/est8260_defconfig
--- linux-2.5.50/arch/ppc/configs/est8260_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/est8260_defconfig	Tue Dec  3 00:48:05 2002
@@ -368,7 +368,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/ev64260_defconfig linux-2.5.50-eaa/arch/ppc/configs/ev64260_defconfig
--- linux-2.5.50/arch/ppc/configs/ev64260_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/ev64260_defconfig	Tue Dec  3 00:48:05 2002
@@ -486,7 +486,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/gemini_defconfig linux-2.5.50-eaa/arch/ppc/configs/gemini_defconfig
--- linux-2.5.50/arch/ppc/configs/gemini_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/gemini_defconfig	Tue Dec  3 00:48:05 2002
@@ -466,7 +466,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/iSeries_defconfig linux-2.5.50-eaa/arch/ppc/configs/iSeries_defconfig
--- linux-2.5.50/arch/ppc/configs/iSeries_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/iSeries_defconfig	Tue Dec  3 00:48:05 2002
@@ -377,7 +377,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/ibmchrp_defconfig linux-2.5.50-eaa/arch/ppc/configs/ibmchrp_defconfig
--- linux-2.5.50/arch/ppc/configs/ibmchrp_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/ibmchrp_defconfig	Tue Dec  3 00:48:05 2002
@@ -606,7 +606,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/k2_defconfig linux-2.5.50-eaa/arch/ppc/configs/k2_defconfig
--- linux-2.5.50/arch/ppc/configs/k2_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/k2_defconfig	Tue Dec  3 00:48:05 2002
@@ -507,7 +507,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/lopec_defconfig linux-2.5.50-eaa/arch/ppc/configs/lopec_defconfig
--- linux-2.5.50/arch/ppc/configs/lopec_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/lopec_defconfig	Tue Dec  3 00:48:05 2002
@@ -694,7 +694,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/mbx_defconfig linux-2.5.50-eaa/arch/ppc/configs/mbx_defconfig
--- linux-2.5.50/arch/ppc/configs/mbx_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/mbx_defconfig	Tue Dec  3 00:48:05 2002
@@ -377,7 +377,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/mcpn765_defconfig linux-2.5.50-eaa/arch/ppc/configs/mcpn765_defconfig
--- linux-2.5.50/arch/ppc/configs/mcpn765_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/mcpn765_defconfig	Tue Dec  3 00:48:05 2002
@@ -417,7 +417,6 @@
 # CONFIG_EXT2_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/menf1_defconfig linux-2.5.50-eaa/arch/ppc/configs/menf1_defconfig
--- linux-2.5.50/arch/ppc/configs/menf1_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/menf1_defconfig	Tue Dec  3 00:48:05 2002
@@ -516,7 +516,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/mvme5100_defconfig linux-2.5.50-eaa/arch/ppc/configs/mvme5100_defconfig
--- linux-2.5.50/arch/ppc/configs/mvme5100_defconfig	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/mvme5100_defconfig	Tue Dec  3 00:48:05 2002
@@ -566,7 +566,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/oak_defconfig linux-2.5.50-eaa/arch/ppc/configs/oak_defconfig
--- linux-2.5.50/arch/ppc/configs/oak_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/oak_defconfig	Tue Dec  3 00:48:05 2002
@@ -420,7 +420,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/pcore_defconfig linux-2.5.50-eaa/arch/ppc/configs/pcore_defconfig
--- linux-2.5.50/arch/ppc/configs/pcore_defconfig	Mon Sep  2 15:57:00 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/pcore_defconfig	Tue Dec  3 00:48:05 2002
@@ -518,7 +518,6 @@
 # CONFIG_SYSV_FS is not set
 # CONFIG_SYSV_FS_WRITE is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/pmac_defconfig linux-2.5.50-eaa/arch/ppc/configs/pmac_defconfig
--- linux-2.5.50/arch/ppc/configs/pmac_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/pmac_defconfig	Tue Dec  3 00:48:05 2002
@@ -818,7 +818,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/power3_defconfig linux-2.5.50-eaa/arch/ppc/configs/power3_defconfig
--- linux-2.5.50/arch/ppc/configs/power3_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/power3_defconfig	Tue Dec  3 00:48:05 2002
@@ -590,7 +590,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/pplus_defconfig linux-2.5.50-eaa/arch/ppc/configs/pplus_defconfig
--- linux-2.5.50/arch/ppc/configs/pplus_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/pplus_defconfig	Tue Dec  3 00:48:05 2002
@@ -609,7 +609,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/prpmc750_defconfig linux-2.5.50-eaa/arch/ppc/configs/prpmc750_defconfig
--- linux-2.5.50/arch/ppc/configs/prpmc750_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/prpmc750_defconfig	Tue Dec  3 00:48:05 2002
@@ -453,7 +453,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/prpmc800_defconfig linux-2.5.50-eaa/arch/ppc/configs/prpmc800_defconfig
--- linux-2.5.50/arch/ppc/configs/prpmc800_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/prpmc800_defconfig	Tue Dec  3 00:48:05 2002
@@ -467,7 +467,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/redwood5_defconfig linux-2.5.50-eaa/arch/ppc/configs/redwood5_defconfig
--- linux-2.5.50/arch/ppc/configs/redwood5_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/redwood5_defconfig	Tue Dec  3 00:48:05 2002
@@ -446,7 +446,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/redwood_defconfig linux-2.5.50-eaa/arch/ppc/configs/redwood_defconfig
--- linux-2.5.50/arch/ppc/configs/redwood_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/redwood_defconfig	Tue Dec  3 00:48:05 2002
@@ -385,7 +385,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/rpxcllf_defconfig linux-2.5.50-eaa/arch/ppc/configs/rpxcllf_defconfig
--- linux-2.5.50/arch/ppc/configs/rpxcllf_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/rpxcllf_defconfig	Tue Dec  3 00:48:05 2002
@@ -384,7 +384,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/rpxlite_defconfig linux-2.5.50-eaa/arch/ppc/configs/rpxlite_defconfig
--- linux-2.5.50/arch/ppc/configs/rpxlite_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/rpxlite_defconfig	Tue Dec  3 00:48:05 2002
@@ -384,7 +384,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/sandpoint_defconfig linux-2.5.50-eaa/arch/ppc/configs/sandpoint_defconfig
--- linux-2.5.50/arch/ppc/configs/sandpoint_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/sandpoint_defconfig	Tue Dec  3 00:48:05 2002
@@ -700,7 +700,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/spruce_defconfig linux-2.5.50-eaa/arch/ppc/configs/spruce_defconfig
--- linux-2.5.50/arch/ppc/configs/spruce_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/spruce_defconfig	Tue Dec  3 00:48:05 2002
@@ -415,7 +415,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/walnut_defconfig linux-2.5.50-eaa/arch/ppc/configs/walnut_defconfig
--- linux-2.5.50/arch/ppc/configs/walnut_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/walnut_defconfig	Tue Dec  3 00:48:05 2002
@@ -441,7 +441,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/configs/zx4500_defconfig linux-2.5.50-eaa/arch/ppc/configs/zx4500_defconfig
--- linux-2.5.50/arch/ppc/configs/zx4500_defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/configs/zx4500_defconfig	Tue Dec  3 00:48:05 2002
@@ -422,7 +422,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
diff -urN linux-2.5.50/arch/ppc/defconfig linux-2.5.50-eaa/arch/ppc/defconfig
--- linux-2.5.50/arch/ppc/defconfig	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ppc/defconfig	Tue Dec  3 00:48:05 2002
@@ -738,7 +738,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 
