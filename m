Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbVLKSwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbVLKSwP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 13:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVLKSwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 13:52:15 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31500 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750797AbVLKSwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 13:52:13 -0500
Date: Sun, 11 Dec 2005 19:52:12 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk, tony.luck@intel.com, linux-ia64@vger.kernel.org,
       matthew@wil.cx, grundler@parisc-linux.org,
       parisc-linux@parisc-linux.org, paulus@samba.org,
       linuxppc-dev@ozlabs.org, lethal@linux-sh.org, kkojima@rr.iij4u.or.jp,
       linux-sh@m17n.org
Subject: [2.6 patch] defconfig's shouldn't set CONFIG_BROKEN=y
Message-ID: <20051211185212.GQ23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

defconfig's shouldn't set CONFIG_BROKEN=y.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/arm/configs/bast_defconfig       |    3 +--
 arch/arm/configs/collie_defconfig     |    3 +--
 arch/arm/configs/s3c2410_defconfig    |    3 +--
 arch/ia64/configs/sim_defconfig       |    3 +--
 arch/ia64/configs/zx1_defconfig       |    3 +--
 arch/m32r/mappi/defconfig.smp         |    3 +--
 arch/m32r/mappi/defconfig.up          |    3 +--
 arch/m32r/mappi3/defconfig.smp        |    3 +--
 arch/parisc/configs/712_defconfig     |    3 +--
 arch/parisc/configs/a500_defconfig    |    3 +--
 arch/parisc/configs/c3000_defconfig   |    3 +--
 arch/ppc/configs/mpc86x_ads_defconfig |    3 +--
 arch/ppc/configs/mpc885ads_defconfig  |    3 +--
 arch/ppc/configs/rpxcllf_defconfig    |    3 +--
 arch/ppc/configs/rpxlite_defconfig    |    3 +--
 arch/sh/configs/hp680_defconfig       |    3 +--
 arch/sh/configs/sh03_defconfig        |    3 +--
 arch/sh/configs/systemh_defconfig     |    3 +--
 18 files changed, 18 insertions(+), 36 deletions(-)

--- linux-2.6.15-rc5-mm2-full/arch/arm/configs/bast_defconfig.old	2005-12-11 19:37:15.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/arm/configs/bast_defconfig	2005-12-11 19:37:37.000000000 +0100
@@ -14,8 +14,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 
 #
--- linux-2.6.15-rc5-mm2-full/arch/arm/configs/collie_defconfig.old	2005-12-11 19:37:44.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/arm/configs/collie_defconfig	2005-12-11 19:37:52.000000000 +0100
@@ -13,8 +13,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
--- linux-2.6.15-rc5-mm2-full/arch/arm/configs/s3c2410_defconfig.old	2005-12-11 19:38:01.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/arm/configs/s3c2410_defconfig	2005-12-11 19:38:08.000000000 +0100
@@ -13,8 +13,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
--- linux-2.6.15-rc5-mm2-full/arch/ia64/configs/sim_defconfig.old	2005-12-11 19:38:17.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/ia64/configs/sim_defconfig	2005-12-11 19:38:38.000000000 +0100
@@ -6,9 +6,8 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
+CONFIG_CLEAN_COMPILE=y
 # CONFIG_STANDALONE is not set
-CONFIG_BROKEN=y
 CONFIG_BROKEN_ON_SMP=y
 
 #
--- linux-2.6.15-rc5-mm2-full/arch/ia64/configs/zx1_defconfig.old	2005-12-11 19:38:52.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/ia64/configs/zx1_defconfig	2005-12-11 19:38:59.000000000 +0100
@@ -8,8 +8,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
--- linux-2.6.15-rc5-mm2-full/arch/m32r/mappi/defconfig.smp.old	2005-12-11 19:39:08.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/m32r/mappi/defconfig.smp	2005-12-11 19:39:15.000000000 +0100
@@ -13,8 +13,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
--- linux-2.6.15-rc5-mm2-full/arch/m32r/mappi/defconfig.up.old	2005-12-11 19:39:25.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/m32r/mappi/defconfig.up	2005-12-11 19:39:32.000000000 +0100
@@ -13,8 +13,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
--- linux-2.6.15-rc5-mm2-full/arch/m32r/mappi3/defconfig.smp.old	2005-12-11 19:39:41.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/m32r/mappi3/defconfig.smp	2005-12-11 19:39:48.000000000 +0100
@@ -13,8 +13,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
--- linux-2.6.15-rc5-mm2-full/arch/parisc/configs/712_defconfig.old	2005-12-11 19:40:00.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/parisc/configs/712_defconfig	2005-12-11 19:40:08.000000000 +0100
@@ -16,8 +16,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
--- linux-2.6.15-rc5-mm2-full/arch/parisc/configs/a500_defconfig.old	2005-12-11 19:40:32.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/parisc/configs/a500_defconfig	2005-12-11 19:40:38.000000000 +0100
@@ -16,8 +16,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
--- linux-2.6.15-rc5-mm2-full/arch/parisc/configs/c3000_defconfig.old	2005-12-11 19:40:50.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/parisc/configs/c3000_defconfig	2005-12-11 19:40:57.000000000 +0100
@@ -16,8 +16,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
--- linux-2.6.15-rc5-mm2-full/arch/ppc/configs/mpc86x_ads_defconfig.old	2005-12-11 19:41:53.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/ppc/configs/mpc86x_ads_defconfig	2005-12-11 19:42:01.000000000 +0100
@@ -17,8 +17,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
--- linux-2.6.15-rc5-mm2-full/arch/ppc/configs/mpc885ads_defconfig.old	2005-12-11 19:42:21.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/ppc/configs/mpc885ads_defconfig	2005-12-11 19:42:30.000000000 +0100
@@ -17,8 +17,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 
--- linux-2.6.15-rc5-mm2-full/arch/ppc/configs/rpxcllf_defconfig.old	2005-12-11 19:42:40.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/ppc/configs/rpxcllf_defconfig	2005-12-11 19:42:48.000000000 +0100
@@ -15,8 +15,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 
 #
--- linux-2.6.15-rc5-mm2-full/arch/ppc/configs/rpxlite_defconfig.old	2005-12-11 19:43:21.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/ppc/configs/rpxlite_defconfig	2005-12-11 19:43:27.000000000 +0100
@@ -15,8 +15,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 
 #
--- linux-2.6.15-rc5-mm2-full/arch/sh/configs/hp680_defconfig.old	2005-12-11 19:43:36.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/sh/configs/hp680_defconfig	2005-12-11 19:43:43.000000000 +0100
@@ -14,8 +14,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 
 #
--- linux-2.6.15-rc5-mm2-full/arch/sh/configs/sh03_defconfig.old	2005-12-11 19:43:53.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/sh/configs/sh03_defconfig	2005-12-11 19:44:02.000000000 +0100
@@ -14,8 +14,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
 
--- linux-2.6.15-rc5-mm2-full/arch/sh/configs/systemh_defconfig.old	2005-12-11 19:44:19.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/arch/sh/configs/systemh_defconfig	2005-12-11 19:44:40.000000000 +0100
@@ -14,8 +14,7 @@
 # Code maturity level options
 #
 CONFIG_EXPERIMENTAL=y
-# CONFIG_CLEAN_COMPILE is not set
-CONFIG_BROKEN=y
+CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_LOCK_KERNEL=y
 

