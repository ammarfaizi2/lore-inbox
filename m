Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269284AbUINKBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269284AbUINKBr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 06:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269256AbUINKAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 06:00:53 -0400
Received: from rdrz.de ([217.160.107.209]:47793 "HELO rdrz.de")
	by vger.kernel.org with SMTP id S269296AbUINJ6v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:58:51 -0400
Date: Tue, 14 Sep 2004 11:58:47 +0200
From: Raphael Zimmerer <killekulla@rdrz.de>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH 2/2] ide: remove obsolete CONFIG_BLK_DEV_ADMA - cleanup arch
Message-ID: <20040914095847.GG9994@rdrz.de>
Reply-To: linux-ide@vger.kernel.org, Raphael Zimmerer <killekulla@rdrz.de>
References: <20040914095330.GF9994@rdrz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914095330.GF9994@rdrz.de>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Zimmerer <killekulla@rdrz.de>

Cleans up default config for various archs, removing
CONFIG_BLK_DEV_IDEPCI

Signed-off-by: Raphael Zimmerer <killekulla@rdrz.de>
---

 arch/alpha/defconfig                 |    1 -
 arch/arm/configs/iq80321_defconfig   |    1 -
 arch/arm/configs/ixp4xx_defconfig    |    1 -
 arch/arm/configs/netwinder_defconfig |    1 -
 arch/i386/defconfig                  |    1 -
 arch/ia64/configs/generic_defconfig  |    1 -
 arch/ia64/configs/sn2_defconfig      |    1 -
 arch/ia64/configs/zx1_defconfig      |    1 -
 arch/ia64/defconfig                  |    1 -
 arch/mips/configs/lasat200_defconfig |    1 -
 arch/mips/configs/pb1500_defconfig   |    1 -
 arch/mips/configs/pb1550_defconfig   |    1 -
 arch/parisc/configs/c3000_defconfig  |    1 -
 arch/ppc/configs/common_defconfig    |    1 -
 arch/ppc/configs/k2_defconfig        |    1 -
 arch/ppc/configs/lopec_defconfig     |    1 -
 arch/ppc/configs/mcpn765_defconfig   |    1 -
 arch/ppc/configs/pmac_defconfig      |    1 -
 arch/ppc/defconfig                   |    1 -
 arch/ppc64/configs/g5_defconfig      |    1 -
 arch/ppc64/configs/pSeries_defconfig |    1 -
 arch/ppc64/defconfig                 |    1 -
 arch/sparc64/defconfig               |    1 -
 arch/x86_64/defconfig                |    1 -
 24 files changed, 24 deletions(-)

diff -Nur linux-2.6.8.1/arch/alpha/defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/alpha/defconfig
--- linux-2.6.8.1/arch/alpha/defconfig	2004-08-16 10:00:24.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/alpha/defconfig	2004-09-14 08:07:52.000000000 +0200
@@ -181,7 +181,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 CONFIG_BLK_DEV_ALI15X3=y
 # CONFIG_WDC_ALI15X3 is not set
diff -Nur linux-2.6.8.1/arch/arm/configs/iq80321_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/arm/configs/iq80321_defconfig
--- linux-2.6.8.1/arch/arm/configs/iq80321_defconfig	2004-08-16 10:00:25.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/arm/configs/iq80321_defconfig	2004-09-13 17:39:44.000000000 +0200
@@ -439,7 +439,6 @@
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
 CONFIG_BLK_DEV_IDEDMA=y
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/arm/configs/ixp4xx_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/arm/configs/ixp4xx_defconfig
--- linux-2.6.8.1/arch/arm/configs/ixp4xx_defconfig	2004-08-16 10:00:25.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/arm/configs/ixp4xx_defconfig	2004-09-13 17:40:13.000000000 +0200
@@ -674,7 +674,6 @@
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/arm/configs/netwinder_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/arm/configs/netwinder_defconfig
--- linux-2.6.8.1/arch/arm/configs/netwinder_defconfig	2004-08-16 10:00:25.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/arm/configs/netwinder_defconfig	2004-09-13 17:39:19.000000000 +0200
@@ -437,7 +437,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/i386/defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/i386/defconfig
--- linux-2.6.8.1/arch/i386/defconfig	2004-08-16 10:00:29.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/i386/defconfig	2004-09-13 17:41:28.000000000 +0200
@@ -288,7 +288,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/ia64/configs/generic_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ia64/configs/generic_defconfig
--- linux-2.6.8.1/arch/ia64/configs/generic_defconfig	2004-08-16 10:00:30.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ia64/configs/generic_defconfig	2004-09-14 08:06:29.000000000 +0200
@@ -207,7 +207,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/ia64/configs/sn2_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ia64/configs/sn2_defconfig
--- linux-2.6.8.1/arch/ia64/configs/sn2_defconfig	2004-08-16 10:00:30.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ia64/configs/sn2_defconfig	2004-09-14 08:05:56.000000000 +0200
@@ -206,7 +206,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/ia64/configs/zx1_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ia64/configs/zx1_defconfig
--- linux-2.6.8.1/arch/ia64/configs/zx1_defconfig	2004-08-16 10:00:30.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ia64/configs/zx1_defconfig	2004-09-14 08:06:12.000000000 +0200
@@ -187,7 +187,6 @@
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/ia64/defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ia64/defconfig
--- linux-2.6.8.1/arch/ia64/defconfig	2004-08-16 10:00:30.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ia64/defconfig	2004-09-14 08:10:19.000000000 +0200
@@ -204,7 +204,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/mips/configs/lasat200_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/mips/configs/lasat200_defconfig
--- linux-2.6.8.1/arch/mips/configs/lasat200_defconfig	2004-08-16 10:00:31.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/mips/configs/lasat200_defconfig	2004-09-14 08:07:05.000000000 +0200
@@ -266,7 +266,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/mips/configs/pb1500_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/mips/configs/pb1500_defconfig
--- linux-2.6.8.1/arch/mips/configs/pb1500_defconfig	2004-08-16 10:00:33.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/mips/configs/pb1500_defconfig	2004-09-14 08:06:47.000000000 +0200
@@ -238,7 +238,6 @@
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/mips/configs/pb1550_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/mips/configs/pb1550_defconfig
--- linux-2.6.8.1/arch/mips/configs/pb1550_defconfig	2004-08-16 10:00:33.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/mips/configs/pb1550_defconfig	2004-09-14 08:07:27.000000000 +0200
@@ -237,7 +237,6 @@
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/parisc/configs/c3000_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/parisc/configs/c3000_defconfig
--- linux-2.6.8.1/arch/parisc/configs/c3000_defconfig	2004-08-16 10:00:35.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/parisc/configs/c3000_defconfig	2004-09-14 08:09:06.000000000 +0200
@@ -170,7 +170,6 @@
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/ppc/configs/common_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc/configs/common_defconfig
--- linux-2.6.8.1/arch/ppc/configs/common_defconfig	2004-08-16 10:00:36.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc/configs/common_defconfig	2004-09-14 08:05:12.000000000 +0200
@@ -215,7 +215,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/ppc/configs/k2_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc/configs/k2_defconfig
--- linux-2.6.8.1/arch/ppc/configs/k2_defconfig	2004-08-16 10:00:36.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc/configs/k2_defconfig	2004-09-13 17:41:04.000000000 +0200
@@ -191,7 +191,6 @@
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 CONFIG_BLK_DEV_ALI15X3=y
 # CONFIG_WDC_ALI15X3 is not set
diff -Nur linux-2.6.8.1/arch/ppc/configs/lopec_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc/configs/lopec_defconfig
--- linux-2.6.8.1/arch/ppc/configs/lopec_defconfig	2004-08-16 10:00:36.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc/configs/lopec_defconfig	2004-09-13 17:40:27.000000000 +0200
@@ -200,7 +200,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/ppc/configs/mcpn765_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc/configs/mcpn765_defconfig
--- linux-2.6.8.1/arch/ppc/configs/mcpn765_defconfig	2004-07-26 15:03:28.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc/configs/mcpn765_defconfig	2004-09-14 08:04:53.000000000 +0200
@@ -181,7 +181,6 @@
 CONFIG_BLK_DEV_IDEDMA_PCI=y
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/ppc/configs/pmac_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc/configs/pmac_defconfig
--- linux-2.6.8.1/arch/ppc/configs/pmac_defconfig	2004-08-16 10:00:36.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc/configs/pmac_defconfig	2004-09-13 17:40:49.000000000 +0200
@@ -223,7 +223,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/ppc/defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc/defconfig
--- linux-2.6.8.1/arch/ppc/defconfig	2004-08-16 10:00:36.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc/defconfig	2004-09-14 08:05:29.000000000 +0200
@@ -223,7 +223,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/ppc64/configs/g5_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc64/configs/g5_defconfig
--- linux-2.6.8.1/arch/ppc64/configs/g5_defconfig	2004-08-16 10:00:37.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc64/configs/g5_defconfig	2004-09-14 08:08:07.000000000 +0200
@@ -170,7 +170,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 # CONFIG_BLK_DEV_AMD74XX is not set
diff -Nur linux-2.6.8.1/arch/ppc64/configs/pSeries_defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc64/configs/pSeries_defconfig
--- linux-2.6.8.1/arch/ppc64/configs/pSeries_defconfig	2004-08-16 10:00:37.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc64/configs/pSeries_defconfig	2004-09-14 08:08:21.000000000 +0200
@@ -173,7 +173,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 CONFIG_BLK_DEV_AMD74XX=y
diff -Nur linux-2.6.8.1/arch/ppc64/defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc64/defconfig
--- linux-2.6.8.1/arch/ppc64/defconfig	2004-08-16 10:00:38.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/ppc64/defconfig	2004-09-14 08:08:39.000000000 +0200
@@ -173,7 +173,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 CONFIG_BLK_DEV_AMD74XX=y
diff -Nur linux-2.6.8.1/arch/sparc64/defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/sparc64/defconfig
--- linux-2.6.8.1/arch/sparc64/defconfig	2004-08-16 10:00:42.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/sparc64/defconfig	2004-09-14 08:08:54.000000000 +0200
@@ -251,7 +251,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_IDEDMA_ONLYDISK=y
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 CONFIG_BLK_DEV_ALI15X3=y
 # CONFIG_WDC_ALI15X3 is not set
diff -Nur linux-2.6.8.1/arch/x86_64/defconfig linux-2.6.8.1-no-BLK_DEV_ADMA/arch/x86_64/defconfig
--- linux-2.6.8.1/arch/x86_64/defconfig	2004-08-16 10:00:43.000000000 +0200
+++ linux-2.6.8.1-no-BLK_DEV_ADMA/arch/x86_64/defconfig	2004-09-14 08:09:21.000000000 +0200
@@ -212,7 +212,6 @@
 # CONFIG_BLK_DEV_IDEDMA_FORCED is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 # CONFIG_IDEDMA_ONLYDISK is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
 CONFIG_BLK_DEV_AMD74XX=y
