Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932128AbWC3JO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWC3JO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 04:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWC3JO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 04:14:58 -0500
Received: from mail2.ameuro.de ([195.140.232.8]:7634 "EHLO mail2.ameuro.de")
	by vger.kernel.org with ESMTP id S932128AbWC3JO4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 04:14:56 -0500
Date: Thu, 30 Mar 2006 11:14:34 +0200
From: Anders Larsen <al@alarsen.net>
Subject: [PATCH] MTD: remove obsolete Kconfig options
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Trivial Patch Monkey <trivial@kernel.org>
X-Mailer: Balsa 2.3.12
Message-Id: <1143710074l.24552l.0l@ecxwww1.reanet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-AEV-Kundenmail-Information: AEV Virus and Spam Secure Mail System
X-AEV-Kundenmail-VirusScanner: Found to be clean
X-AEV-Kundenmail-SpamCheck: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Larsen <al@alarsen.net>

Remove the obsolete Kconfig options MTD_CFI_AMDSTD_RETRY
and MTD_CFI_AMDSTD_RETRY_MAX

The code that depended on these was removed in early 2004, but
Kconfig was not updated accordingly.

Signed-off-by: Anders Larsen <al@alarsen.net>

---

This patch was accepted into the public MTD tree (cvs.infradead.org)
on 2005-12-06 but apparantly has not been pushed upstream yet.

Cheers
 Anders


 arch/arm/configs/at91rm9200dk_defconfig |    1 -
 arch/arm/configs/at91rm9200ek_defconfig |    1 -
 arch/arm/configs/ep93xx_defconfig       |    1 -
 arch/arm/configs/realview_defconfig     |    1 -
 arch/arm/configs/s3c2410_defconfig      |    1 -
 arch/arm/configs/shannon_defconfig      |    1 -
 arch/cris/defconfig                     |    1 -
 arch/mips/configs/db1000_defconfig      |    1 -
 arch/mips/configs/db1100_defconfig      |    1 -
 arch/mips/configs/db1200_defconfig      |    1 -
 arch/mips/configs/db1500_defconfig      |    1 -
 arch/mips/configs/db1550_defconfig      |    1 -
 arch/mips/configs/lasat200_defconfig    |    1 -
 arch/mips/configs/pb1100_defconfig      |    1 -
 arch/mips/configs/pb1500_defconfig      |    1 -
 arch/mips/configs/pb1550_defconfig      |    1 -
 arch/mips/configs/rbhma4500_defconfig   |    1 -
 arch/ppc/configs/TQM8540_defconfig      |    1 -
 arch/ppc/configs/TQM8541_defconfig      |    1 -
 arch/ppc/configs/TQM8555_defconfig      |    1 -
 arch/ppc/configs/TQM8560_defconfig      |    1 -
 arch/sh/configs/se7705_defconfig        |    1 -
 arch/sh/configs/se7750_defconfig        |    1 -
 arch/sh/configs/se7751_defconfig        |    1 -
 drivers/mtd/chips/Kconfig               |   21 ---------------------
 25 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/arch/arm/configs/at91rm9200dk_defconfig b/arch/arm/configs/at91rm9200dk_defconfig
index 1fe73d1..244788c 100644
--- a/arch/arm/configs/at91rm9200dk_defconfig
+++ b/arch/arm/configs/at91rm9200dk_defconfig
@@ -343,7 +343,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/arm/configs/at91rm9200ek_defconfig b/arch/arm/configs/at91rm9200ek_defconfig
index b7d934c..5322ebb 100644
--- a/arch/arm/configs/at91rm9200ek_defconfig
+++ b/arch/arm/configs/at91rm9200ek_defconfig
@@ -334,7 +334,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 8dcc8e8..f8a7516 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -346,7 +346,6 @@ # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_OTP is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 CONFIG_MTD_CFI_STAA=y
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index 3f1ec4e..9742a54 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -267,7 +267,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index 3cec29d..e533e9a 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -360,7 +360,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/arm/configs/shannon_defconfig b/arch/arm/configs/shannon_defconfig
index d052c8f..5e7622b 100644
--- a/arch/arm/configs/shannon_defconfig
+++ b/arch/arm/configs/shannon_defconfig
@@ -227,7 +227,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/cris/defconfig b/arch/cris/defconfig
index 142a108..d2c440e 100644
--- a/arch/cris/defconfig
+++ b/arch/cris/defconfig
@@ -220,7 +220,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 CONFIG_MTD_RAM=y
diff --git a/arch/mips/configs/db1000_defconfig b/arch/mips/configs/db1000_defconfig
index 7f07140..aee767a 100644
--- a/arch/mips/configs/db1000_defconfig
+++ b/arch/mips/configs/db1000_defconfig
@@ -412,7 +412,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/mips/configs/db1100_defconfig b/arch/mips/configs/db1100_defconfig
index 98590ca..b4e1add 100644
--- a/arch/mips/configs/db1100_defconfig
+++ b/arch/mips/configs/db1100_defconfig
@@ -401,7 +401,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index 9288847..cee62b8 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -403,7 +403,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/mips/configs/db1500_defconfig b/arch/mips/configs/db1500_defconfig
index 5a415b1..644358d 100644
--- a/arch/mips/configs/db1500_defconfig
+++ b/arch/mips/configs/db1500_defconfig
@@ -420,7 +420,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/mips/configs/db1550_defconfig b/arch/mips/configs/db1550_defconfig
index 8dc1f18..0ff4a00 100644
--- a/arch/mips/configs/db1550_defconfig
+++ b/arch/mips/configs/db1550_defconfig
@@ -419,7 +419,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/mips/configs/lasat200_defconfig b/arch/mips/configs/lasat200_defconfig
index ef0fa9f..e8d7275 100644
--- a/arch/mips/configs/lasat200_defconfig
+++ b/arch/mips/configs/lasat200_defconfig
@@ -366,7 +366,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/mips/configs/pb1100_defconfig b/arch/mips/configs/pb1100_defconfig
index 194b3c7..9dd952f 100644
--- a/arch/mips/configs/pb1100_defconfig
+++ b/arch/mips/configs/pb1100_defconfig
@@ -414,7 +414,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/mips/configs/pb1500_defconfig b/arch/mips/configs/pb1500_defconfig
index 8985725..46f99a7 100644
--- a/arch/mips/configs/pb1500_defconfig
+++ b/arch/mips/configs/pb1500_defconfig
@@ -420,7 +420,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/mips/configs/pb1550_defconfig b/arch/mips/configs/pb1550_defconfig
index adbf997..4fe0b71 100644
--- a/arch/mips/configs/pb1550_defconfig
+++ b/arch/mips/configs/pb1550_defconfig
@@ -420,7 +420,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/mips/configs/rbhma4500_defconfig b/arch/mips/configs/rbhma4500_defconfig
index b126f76..cc200b6 100644
--- a/arch/mips/configs/rbhma4500_defconfig
+++ b/arch/mips/configs/rbhma4500_defconfig
@@ -425,7 +425,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/ppc/configs/TQM8540_defconfig b/arch/ppc/configs/TQM8540_defconfig
index 99bf3b7..9cac7b0 100644
--- a/arch/ppc/configs/TQM8540_defconfig
+++ b/arch/ppc/configs/TQM8540_defconfig
@@ -296,7 +296,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/ppc/configs/TQM8541_defconfig b/arch/ppc/configs/TQM8541_defconfig
index 0ff5669..4144cf3 100644
--- a/arch/ppc/configs/TQM8541_defconfig
+++ b/arch/ppc/configs/TQM8541_defconfig
@@ -297,7 +297,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/ppc/configs/TQM8555_defconfig b/arch/ppc/configs/TQM8555_defconfig
index 730b3db..6f853fd 100644
--- a/arch/ppc/configs/TQM8555_defconfig
+++ b/arch/ppc/configs/TQM8555_defconfig
@@ -297,7 +297,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/ppc/configs/TQM8560_defconfig b/arch/ppc/configs/TQM8560_defconfig
index 1d90207..1dd7998 100644
--- a/arch/ppc/configs/TQM8560_defconfig
+++ b/arch/ppc/configs/TQM8560_defconfig
@@ -297,7 +297,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/sh/configs/se7705_defconfig b/arch/sh/configs/se7705_defconfig
index e4a1460..bb6cb7e 100644
--- a/arch/sh/configs/se7705_defconfig
+++ b/arch/sh/configs/se7705_defconfig
@@ -217,7 +217,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/sh/configs/se7750_defconfig b/arch/sh/configs/se7750_defconfig
index 6dc3158..7e28476 100644
--- a/arch/sh/configs/se7750_defconfig
+++ b/arch/sh/configs/se7750_defconfig
@@ -217,7 +217,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
diff --git a/arch/sh/configs/se7751_defconfig b/arch/sh/configs/se7751_defconfig
index 1ce0289..e5315b2 100644
--- a/arch/sh/configs/se7751_defconfig
+++ b/arch/sh/configs/se7751_defconfig
@@ -223,7 +223,6 @@ # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
 # CONFIG_MTD_CFI_INTELEXT is not set
 CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_CFI_AMDSTD_RETRY=0
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
 CONFIG_MTD_RAM=y
diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
index 0f6bb2e..a7ec595 100644
--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -200,27 +200,6 @@ config MTD_CFI_AMDSTD
 	  provides support for one of those command sets, used on chips
 	  including the AMD Am29LV320.
 
-config MTD_CFI_AMDSTD_RETRY
-	int "Retry failed commands (erase/program)"
-	depends on MTD_CFI_AMDSTD
-	default "0"
-	help
-	  Some chips, when attached to a shared bus, don't properly filter
-	  bus traffic that is destined to other devices.  This broken
-	  behavior causes erase and program sequences to be aborted when
-	  the sequences are mixed with traffic for other devices.
-
-	  SST49LF040 (and related) chips are know to be broken.
-
-config MTD_CFI_AMDSTD_RETRY_MAX
-	int "Max retries of failed commands (erase/program)"
-	depends on MTD_CFI_AMDSTD_RETRY
-	default "0"
-	help
-	  If you have an SST49LF040 (or related chip) then this value should
-	  be set to at least 1.  This can also be adjusted at driver load
-	  time with the retry_cmd_max module parameter.
-
 config MTD_CFI_STAA
 	tristate "Support for ST (Advanced Architecture) flash chips"
 	depends on MTD_GEN_PROBE

