Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263766AbUFBR5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263766AbUFBR5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 13:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263756AbUFBR5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 13:57:48 -0400
Received: from fmr12.intel.com ([134.134.136.15]:50077 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S263772AbUFBRyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 13:54:18 -0400
Date: Wed, 2 Jun 2004 12:42:26 -0700
From: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Message-Id: <200406021942.i52JgQOE002496@snoqualmie.dp.intel.com>
To: akpm@osdl.org
Subject: update elilo loader location in Kconfig
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The elilo EFI boot loader has been moved to sourceforge. So,
update the location of where one might look for it...

matt


diff -urN linux-2.6.7-rc2/arch/i386/Kconfig linux-2.6.7-rc2-m/arch/i386/Kconfig
--- linux-2.6.7-rc2/arch/i386/Kconfig	2004-05-29 23:25:51.000000000 -0700
+++ linux-2.6.7-rc2-m/arch/i386/Kconfig	2004-06-02 02:45:38.903322072 -0700
@@ -823,7 +823,7 @@
 	This option is only useful on systems that have EFI firmware
 	and will result in a kernel image that is ~8k larger.  In addition,
 	you must use the latest ELILO loader available at
-	<ftp://ftp.hpl.hp.com/pub/linux-ia64/> in order to take advantage of
+	<http://elilo.sourceforge.net> in order to take advantage of
 	kernel initialization using EFI information (neither GRUB nor LILO know
 	anything about EFI).  However, even with this option, the resultant
 	kernel should continue to boot on existing non-EFI platforms.
