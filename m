Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261663AbULZNtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbULZNtm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 08:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbULZNrj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 08:47:39 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:11908 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261657AbULZNrD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 08:47:03 -0500
From: James Nelson <james4765@verizon.net>
To: ultralinux@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       James Nelson <james4765@verizon.net>
Message-Id: <20041226134721.11731.74495.27433@localhost.localdomain>
In-Reply-To: <20041226134715.11731.39190.49206@localhost.localdomain>
References: <20041226134715.11731.39190.49206@localhost.localdomain>
Subject: [PATCH] sparc64: remove x86 bootloader reference in Kconfig
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [209.158.220.243] at Sun, 26 Dec 2004 07:47:00 -0600
Date: Sun, 26 Dec 2004 07:47:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes refences to x86-specific bootloader in arch/sparc64/Kconfig.

Signed-off-by: James Nelson <james4765@gmail.com>

diff -urN --exclude='*~' linux-2.6.10-original/arch/sparc64/Kconfig linux-2.6.10/arch/sparc64/Kconfig
--- linux-2.6.10-original/arch/sparc64/Kconfig	2004-12-24 16:35:25.000000000 -0500
+++ linux-2.6.10/arch/sparc64/Kconfig	2004-12-26 08:29:28.653936457 -0500
@@ -79,8 +79,8 @@
 	  terminal (/dev/tty0) will be used as system console. You can change
 	  that with a kernel command line option such as "console=tty3" which
 	  would use the third virtual terminal as system console. (Try "man
-	  bootparam" or see the documentation of your boot loader (lilo or
-	  loadlin) about how to pass options to the kernel at boot time.)
+	  bootparam" or see the documentation of your boot loader (silo)
+	  about how to pass options to the kernel at boot time.)
 
 	  If unsure, say Y.
 
