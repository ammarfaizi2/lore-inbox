Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbUJ1PDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbUJ1PDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261705AbUJ1PBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:01:51 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:58352 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261688AbUJ1PAy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:00:54 -0400
From: james4765@verizon.net
To: kernel-janitors@lists.osdl.org
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, james4765@verizon.net
Message-Id: <20041028150050.2776.32667.73956@localhost.localdomain>
In-Reply-To: <20041028150029.2776.69333.50087@localhost.localdomain>
References: <20041028150029.2776.69333.50087@localhost.localdomain>
Subject: [PATCH 4/9] to arch/sparc/Kconfig
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 10:00:50 -0500
Date: Thu, 28 Oct 2004 10:00:51 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Remove x86-specific help in arch/sparc/Kconfig.
Apply against 2.6.9.

Signed-off by: James Nelson <james4765@gmail.com>

diff -u ./arch/sparc/Kconfig.orig ./arch/sparc/Kconfig
--- ./arch/sparc/Kconfig.orig	2004-10-16 09:53:49.626021592 -0400
+++ ./arch/sparc/Kconfig	2004-10-16 10:15:30.184460399 -0400
@@ -281,9 +281,9 @@
 
 	  If you have several parallel ports, you can specify which ports to
 	  use with the "lp" kernel command line option.  (Try "man bootparam"
-	  or see the documentation of your boot loader (lilo or loadlin) about
-	  how to pass options to the kernel at boot time.)  The syntax of the
-	  "lp" command line option can be found in <file:drivers/char/lp.c>.
+	  or see the documentation of your boot loader (silo) about how to pass
+	  options to the kernel at boot time.)  The syntax of the "lp" command
+	  line option can be found in <file:drivers/char/lp.c>.
 
 	  If you have more than 8 printers, you need to increase the LP_NO
 	  macro in lp.c and the PARPORT_MAX macro in parport.h.
