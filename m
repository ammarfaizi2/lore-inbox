Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268370AbUIQEQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268370AbUIQEQG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 00:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268399AbUIQEOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 00:14:10 -0400
Received: from [12.177.129.25] ([12.177.129.25]:6852 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268401AbUIQENG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 00:13:06 -0400
Message-Id: <200409170517.i8H5HT2J005382@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - Get rid of the arch EXTRAVERSION
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Sep 2004 01:17:29 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought this was gone already.  It was only intended for my own patch
numbering, and never intended for any other trees.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/Makefile
===================================================================
--- 2.6.9-rc2.orig/arch/um/Makefile	2004-09-16 22:59:06.000000000 -0400
+++ 2.6.9-rc2/arch/um/Makefile	2004-09-16 23:19:11.000000000 -0400
@@ -48,8 +48,6 @@
 include $(ARCH_DIR)/Makefile-$(SUBARCH)
 include $(ARCH_DIR)/Makefile-os-$(OS)
 
-EXTRAVERSION := $(EXTRAVERSION)-1um
-
 ARCH_INCLUDE = -I$(ARCH_DIR)/include
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into

