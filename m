Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWELNEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWELNEv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 09:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWELNEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 09:04:51 -0400
Received: from mta04.mail.t-online.hu ([195.228.240.57]:7155 "EHLO
	mta01.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S1751269AbWELNEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 09:04:51 -0400
Subject: [PATCH] mtd: Trivial typo fixes
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: dwmw2@infradead.org
Cc: trivial-list <trivial@kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 12 May 2006 15:04:48 +0200
Message-Id: <1147439088.27820.27.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial typo fixes in Kconfig files (MTD).

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>

---

 linux-2.6.17-rc4-i18n-kconfig-gabaman/drivers/mtd/Kconfig                  |    4 ++--
 linux-2.6.17-rc4-i18n-kconfig-gabaman/drivers/mtd/maps/Kconfig             |    2 +-
 linux-2.6.17-rc4-i18n-kconfig-gabaman/drivers/mtd/nand/Kconfig             |    2 +-

diff -puN drivers/mtd/Kconfig~kconfig-i18n-22-typo-fixes drivers/mtd/Kconfig
--- linux-2.6.17-rc4-i18n-kconfig/drivers/mtd/Kconfig~kconfig-i18n-22-typo-fixes	2006-05-12 12:43:50.000000000 +0200
+++ linux-2.6.17-rc4-i18n-kconfig-gabaman/drivers/mtd/Kconfig	2006-05-12 12:43:50.000000000 +0200
@@ -78,7 +78,7 @@ config MTD_REDBOOT_DIRECTORY_BLOCK
 	  option.
 
 	  The option specifies which Flash sectors holds the RedBoot
-	  partition table.  A zero or positive value gives an absolete
+	  partition table.  A zero or positive value gives an absolute
 	  erase block number. A negative value specifies a number of
 	  sectors before the end of the device.
 
@@ -103,7 +103,7 @@ config MTD_CMDLINE_PARTS
 	bool "Command line partition table parsing"
 	depends on MTD_PARTITIONS = "y"
 	---help---
-	  Allow generic configuration of the MTD paritition tables via the kernel
+	  Allow generic configuration of the MTD partition tables via the kernel
 	  command line. Multiple flash resources are supported for hardware where
 	  different kinds of flash memory are available.
 
diff -puN drivers/mtd/maps/Kconfig~kconfig-i18n-22-typo-fixes drivers/mtd/maps/Kconfig
--- linux-2.6.17-rc4-i18n-kconfig/drivers/mtd/maps/Kconfig~kconfig-i18n-22-typo-fixes	2006-05-12 12:43:50.000000000 +0200
+++ linux-2.6.17-rc4-i18n-kconfig-gabaman/drivers/mtd/maps/Kconfig	2006-05-12 12:43:50.000000000 +0200
@@ -109,7 +109,7 @@ config MTD_TS5500
 	  mtd1 allows you to reprogram your BIOS. BE VERY CAREFUL.
 
 	  Note that jumper 3 ("Write Enable Drive A") must be set
-	  otherwise detection won't succeeed.
+	  otherwise detection won't succeed.
 
 config MTD_SBC_GXX
 	tristate "CFI Flash device mapped on Arcom SBC-GXx boards"
diff -puN drivers/mtd/nand/Kconfig~kconfig-i18n-22-typo-fixes drivers/mtd/nand/Kconfig
--- linux-2.6.17-rc4-i18n-kconfig/drivers/mtd/nand/Kconfig~kconfig-i18n-22-typo-fixes	2006-05-12 12:43:50.000000000 +0200
+++ linux-2.6.17-rc4-i18n-kconfig-gabaman/drivers/mtd/nand/Kconfig	2006-05-12 12:45:56.000000000 +0200
@@ -87,7 +87,7 @@ config MTD_NAND_S3C2410
 	  This enables the NAND flash controller on the S3C2410 and S3C2440
 	  SoCs
 
-	  No board specfic support is done by this driver, each board
+	  No board specific support is done by this driver, each board
 	  must advertise a platform_device for the driver to attach.
 
 config MTD_NAND_S3C2410_DEBUG

_

