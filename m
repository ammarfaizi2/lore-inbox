Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261663AbTIWPe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 11:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTIWPeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 11:34:25 -0400
Received: from hal-5.inet.it ([213.92.5.24]:59274 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S261663AbTIWPeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 11:34:22 -0400
From: Paolo Ornati <ornati@despammed.com>
To: torvalds@osdl.org
Subject: [PATCH] Small fix for DOC/kbuild/makefiles.txt
Date: Tue, 23 Sep 2003 17:34:45 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308221745.35331.javaman@katamail.com>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a writing error.

--- linux/Documentation/kbuild/makefiles.txt.orig	2003-08-15 11:47:30.000000000 +0200
+++ linux/Documentation/kbuild/makefiles.txt	2003-08-15 11:47:53.000000000 +0200
@@ -256,7 +256,7 @@
 
 	Example:
 		#fs/Makefile
-		obj-$(CONfIG_EXT2_FS) += ext2/
+		obj-$(CONFIG_EXT2_FS) += ext2/
 
 	If CONFIG_EXT2_FS is set to either 'y' (built-in) or 'm' (modular)
 	the corresponding obj- variable will be set, and kbuild will descend

