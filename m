Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSLCMzO>; Tue, 3 Dec 2002 07:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSLCMzO>; Tue, 3 Dec 2002 07:55:14 -0500
Received: from johanna5.ux.his.no ([152.94.1.25]:1964 "EHLO johanna5.ux.his.no")
	by vger.kernel.org with ESMTP id <S261317AbSLCMzK>;
	Tue, 3 Dec 2002 07:55:10 -0500
Date: Tue, 3 Dec 2002 14:02:09 +0100
From: Erlend Aasland <erlend-a@ux.his.no>
To: Trivial Patch Monkey <trivial@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>,
       David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org
Subject: [TRIVIAL PATCH 2.5] get rid of CONFIG_UDF_RW (ia64)
Message-ID: <20021203130209.GD2417@johanna5.ux.his.no>
References: <20021203125120.GA2417@johanna5.ux.his.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021203125120.GA2417@johanna5.ux.his.no>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove CONFIG_UDF_RW from ia64 defconfigs (it's not used anymore)

Regards,
	Erlend Aasland

diff -urN linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-bigsur-mp linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-bigsur-mp
--- linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-bigsur-mp	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-bigsur-mp	Tue Dec  3 00:48:05 2002
@@ -539,7 +539,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_SUPPORT is not set
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-bigsur-sp linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-bigsur-sp
--- linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-bigsur-sp	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-bigsur-sp	Tue Dec  3 00:48:05 2002
@@ -539,7 +539,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_SUPPORT is not set
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-dig-mp linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-dig-mp
--- linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-dig-mp	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-dig-mp	Tue Dec  3 00:48:05 2002
@@ -301,7 +301,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_SUPPORT is not set
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-dig-sp linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-dig-sp
--- linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-dig-sp	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-dig-sp	Tue Dec  3 00:48:05 2002
@@ -301,7 +301,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_SUPPORT is not set
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-generic-mp linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-generic-mp
--- linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-generic-mp	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-generic-mp	Tue Dec  3 00:48:05 2002
@@ -296,7 +296,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_SUPPORT is not set
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-generic-sp linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-generic-sp
--- linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-generic-sp	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-generic-sp	Tue Dec  3 00:48:05 2002
@@ -296,7 +296,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_SUPPORT is not set
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-hp-sp linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-hp-sp
--- linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-hp-sp	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-hp-sp	Tue Dec  3 00:48:05 2002
@@ -266,7 +266,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_SUPPORT is not set
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-prom-medusa linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-prom-medusa
--- linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-prom-medusa	Mon Sep  2 15:56:57 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-prom-medusa	Tue Dec  3 00:48:05 2002
@@ -376,7 +376,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_SUPPORT is not set
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-sn1-mp linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-sn1-mp
--- linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-sn1-mp	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-sn1-mp	Tue Dec  3 00:48:05 2002
@@ -510,7 +510,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 CONFIG_XFS_SUPPORT=y
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules
--- linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-modules	Tue Dec  3 00:48:05 2002
@@ -512,7 +512,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 CONFIG_XFS_SUPPORT=y
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0 linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0
--- linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-sn1-mp-syn1-0	Tue Dec  3 00:48:05 2002
@@ -510,7 +510,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 CONFIG_XFS_SUPPORT=y
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-sn1-sp linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-sn1-sp
--- linux-2.5.50/arch/ia64/sn/configs/sn1/defconfig-sn1-sp	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn1/defconfig-sn1-sp	Tue Dec  3 00:48:05 2002
@@ -510,7 +510,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 CONFIG_XFS_SUPPORT=y
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-dig-numa linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-dig-numa
--- linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-dig-numa	Mon Sep  2 15:56:59 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-dig-numa	Tue Dec  3 00:48:05 2002
@@ -302,7 +302,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_SUPPORT is not set
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp
--- linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp	Mon Sep  2 15:56:59 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-mp	Tue Dec  3 00:48:05 2002
@@ -301,7 +301,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_SUPPORT is not set
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp
--- linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp	Mon Sep  2 15:56:59 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-sn2-dig-sp	Tue Dec  3 00:48:05 2002
@@ -301,7 +301,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 # CONFIG_XFS_SUPPORT is not set
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-sn2-mp linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-sn2-mp
--- linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-sn2-mp	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-sn2-mp	Tue Dec  3 00:48:05 2002
@@ -509,7 +509,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 CONFIG_XFS_SUPPORT=y
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules
--- linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-sn2-mp-modules	Tue Dec  3 00:48:05 2002
@@ -511,7 +511,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 CONFIG_XFS_SUPPORT=y
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa
--- linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa	Mon Sep  2 15:56:59 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-sn2-prom-medusa	Tue Dec  3 00:48:05 2002
@@ -384,7 +384,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 CONFIG_XFS_SUPPORT=y
diff -urN linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-sn2-sp linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-sn2-sp
--- linux-2.5.50/arch/ia64/sn/configs/sn2/defconfig-sn2-sp	Tue Oct 22 00:13:58 2002
+++ linux-2.5.50-eaa/arch/ia64/sn/configs/sn2/defconfig-sn2-sp	Tue Dec  3 00:48:05 2002
@@ -509,7 +509,6 @@
 CONFIG_EXT2_FS=y
 # CONFIG_SYSV_FS is not set
 # CONFIG_UDF_FS is not set
-# CONFIG_UDF_RW is not set
 # CONFIG_UFS_FS is not set
 # CONFIG_UFS_FS_WRITE is not set
 CONFIG_XFS_SUPPORT=y
