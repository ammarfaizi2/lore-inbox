Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWELM72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWELM72 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 08:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWELM72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 08:59:28 -0400
Received: from mta05.mail.t-online.hu ([195.228.240.88]:56027 "EHLO
	mta05.mail.t-online.hu") by vger.kernel.org with ESMTP
	id S1751246AbWELM72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 08:59:28 -0400
Subject: [PATCH] arm: Trivial typo fixes
From: Egry =?ISO-8859-1?Q?G=E1bor?= <gaboregry@t-online.hu>
To: spyro@f2s.com
Cc: trivial-list <trivial@kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 12 May 2006 14:59:22 +0200
Message-Id: <1147438762.27820.21.camel@spirit>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trivial typo fixes in Kconfig files (ARM).

Signed-off-by: Egry Gabor <gaboregry@t-online.hu>

---

 linux-2.6.17-rc4-i18n-kconfig-gabaman/arch/arm/Kconfig.debug               |    2 +-
 linux-2.6.17-rc4-i18n-kconfig-gabaman/arch/arm/mach-ixp4xx/Kconfig         |    2 +-
 linux-2.6.17-rc4-i18n-kconfig-gabaman/arch/arm/mach-s3c2410/Kconfig        |    2 +-

diff -puN arch/arm/Kconfig.debug~kconfig-i18n-22-typo-fixes arch/arm/Kconfig.debug
--- linux-2.6.17-rc4-i18n-kconfig/arch/arm/Kconfig.debug~kconfig-i18n-22-typo-fixes	2006-05-12 12:43:50.000000000 +0200
+++ linux-2.6.17-rc4-i18n-kconfig-gabaman/arch/arm/Kconfig.debug	2006-05-12 12:43:50.000000000 +0200
@@ -101,7 +101,7 @@ config DEBUG_S3C2410_UART
 	help
 	  Choice for UART for kernel low-level using S3C2410 UARTS,
 	  should be between zero and two. The port must have been
-	  initalised by the boot-loader before use.
+	  initialised by the boot-loader before use.
 
 	  The uncompressor code port configuration is now handled
 	  by CONFIG_S3C2410_LOWLEVEL_UART_PORT.
diff -puN arch/arm/mach-ixp4xx/Kconfig~kconfig-i18n-22-typo-fixes arch/arm/mach-ixp4xx/Kconfig
--- linux-2.6.17-rc4-i18n-kconfig/arch/arm/mach-ixp4xx/Kconfig~kconfig-i18n-22-typo-fixes	2006-05-12 12:43:50.000000000 +0200
+++ linux-2.6.17-rc4-i18n-kconfig-gabaman/arch/arm/mach-ixp4xx/Kconfig	2006-05-12 12:43:50.000000000 +0200
@@ -141,7 +141,7 @@ config IXP4XX_INDIRECT_PCI
           2) If > 64MB of memory space is required, the IXP4xx can be 
 	     configured to use indirect registers to access PCI This allows 
 	     for up to 128MB (0x48000000 to 0x4fffffff) of memory on the bus. 
-	     The disadvantadge of this is that every PCI access requires 
+	     The disadvantage of this is that every PCI access requires 
 	     three local register accesses plus a spinlock, but in some 
 	     cases the performance hit is acceptable. In addition, you cannot 
 	     mmap() PCI devices in this case due to the indirect nature
diff -puN arch/arm/mach-s3c2410/Kconfig~kconfig-i18n-22-typo-fixes arch/arm/mach-s3c2410/Kconfig
--- linux-2.6.17-rc4-i18n-kconfig/arch/arm/mach-s3c2410/Kconfig~kconfig-i18n-22-typo-fixes	2006-05-12 12:43:50.000000000 +0200
+++ linux-2.6.17-rc4-i18n-kconfig-gabaman/arch/arm/mach-s3c2410/Kconfig	2006-05-12 12:43:50.000000000 +0200
@@ -170,7 +170,7 @@ config S3C2410_PM_DEBUG
 	depends on ARCH_S3C2410 && PM
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and
-	  Resume code. See `Documentation/arm/Samsing-S3C24XX/Suspend.txt`
+	  Resume code. See <file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>
 	  for more information.
 
 config S3C2410_PM_CHECK
_

