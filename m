Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVDKWe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVDKWe0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbVDKWQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:16:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31762 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261961AbVDKWPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:15:20 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix help text for ixdp465
X-Patch-Ref: 01-fixes/02-ixp-comments
Message-Id: <E1DL7Ba-0003C6-DB@raistlin.arm.linux.org.uk>
Date: Mon, 11 Apr 2005 23:15:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason, this help text was missed when the file was
last audited by the documentation referencing folk.  Fix this
incorrect documentation reference.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/arch/arm/mach-ixp4xx/Kconfig linux/arch/arm/mach-ixp4xx/Kconfig
--- orig/arch/arm/mach-ixp4xx/Kconfig	Sun Feb  6 11:37:44 2005
+++ linux/arch/arm/mach-ixp4xx/Kconfig	Tue Feb  1 00:05:28 2005
@@ -41,7 +41,7 @@ config MACH_IXDP465
 	help
 	  Say 'Y' here if you want your kernel to support Intel's
 	  IXDP465 Development Platform (Also known as BMP).
-	  For more information on this platform, see Documentation/arm/IXP4xx.
+	  For more information on this platform, see <file:Documentation/arm/IXP4xx>.
 
 
 #

