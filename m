Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbUJ1PMd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUJ1PMd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbUJ1PIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:08:40 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:44707 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S261700AbUJ1PBV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:01:21 -0400
From: james4765@verizon.net
To: kernel-janitors@lists.osdl.org
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, james4765@verizon.net
Message-Id: <20041028150118.2776.11985.87844@localhost.localdomain>
In-Reply-To: <20041028150029.2776.69333.50087@localhost.localdomain>
References: <20041028150029.2776.69333.50087@localhost.localdomain>
Subject: [PATCH 8/9] to arch/sparc/Kconfig
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 10:01:18 -0500
Date: Thu, 28 Oct 2004 10:01:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Make config choice for OpenPROM more obvious in arch/sparc/Kconfig.
Apply against 2.6.9.

Signed-off by: James Nelson <james4765@gmail.com>

diff -u ./arch/sparc/Kconfig.orig ./arch/sparc/Kconfig
--- arch/sparc/Kconfig.orig	2004-10-16 09:53:49.626021592 -0400
+++ arch/sparc/Kconfig	2004-10-18 18:38:05.125374024 -0400
@@ -248,7 +248,10 @@
 	  -t openpromfs none /proc/openprom".
 
 	  To compile the /proc/openprom support as a module, choose M here: the
-	  module will be called openpromfs.  If unsure, choose M.
+	  module will be called openpromfs.
+
+	  Only choose N if you know in advance that you will not need to modify
+	  OpenPROM settings on the running system.
 
 source "fs/Kconfig.binfmt"
 
