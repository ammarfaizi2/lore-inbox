Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261682AbUJ1PDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUJ1PDm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbUJ1PBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:01:37 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:25504 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S261692AbUJ1PBB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:01:01 -0400
From: james4765@verizon.net
To: kernel-janitors@lists.osdl.org
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, james4765@verizon.net
Message-Id: <20041028150057.2776.70475.54914@localhost.localdomain>
In-Reply-To: <20041028150029.2776.69333.50087@localhost.localdomain>
References: <20041028150029.2776.69333.50087@localhost.localdomain>
Subject: [PATCH 5/9] to arch/sparc/Kconfig
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 10:00:57 -0500
Date: Thu, 28 Oct 2004 10:00:58 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Remove x86-specific help in arch/sparc/Kconfig.
Apply against 2.6.9.

Signed-off by: James Nelson <james4765@gmail.com>

diff -u ./arch/sparc/Kconfig.orig ./arch/sparc/Kconfig
--- ./arch/sparc/Kconfig.orig	2004-10-16 09:53:49.626021592 -0400
+++ ./arch/sparc/Kconfig	2004-10-16 10:18:35.964664772 -0400
@@ -188,10 +188,10 @@
 	  (/dev/tty0) will still be used as the system console by default, but
 	  you can alter that using a kernel command line option such as
 	  "console=ttyS1". (Try "man bootparam" or see the documentation of
-	  your boot loader (lilo or loadlin) about how to pass options to the
-	  kernel at boot time.)
+	  your boot loader (silo) about how to pass options to the kernel at
+	  boot time.)
 
-	  If you don't have a VGA card installed and you say Y here, the
+	  If you don't have a graphics card installed and you say Y here, the
 	  kernel will automatically use the first serial line, /dev/ttyS0, as
 	  system console.
 
