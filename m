Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVCCMSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVCCMSh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVCCLGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:06:13 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:5300 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261545AbVCCKmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:42:11 -0500
Date: Thu, 3 Mar 2005 11:41:55 +0100
Message-Id: <200503031041.j23Aftc3020717@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 6/16] DocBook: fix function parameter descriptin in fbmem
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: fix function parameter descriptin in fbmem
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2030  -> 1.2031 
#	drivers/video/fbmem.c	1.150   -> 1.151  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/01/26	tali@admingilde.org	1.2031
# DocBook: fix function parameter descriptin in fbmem
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Thu Mar  3 11:42:00 2005
+++ b/drivers/video/fbmem.c	Thu Mar  3 11:42:00 2005
@@ -1211,9 +1211,10 @@
 
 /**
  * fb_get_options - get kernel boot parameters
- * @name - framebuffer name as it would appear in
- *         the boot parameter line
- *         (video=<name>:<options>)
+ * @name:   framebuffer name as it would appear in
+ *          the boot parameter line
+ *          (video=<name>:<options>)
+ * @option: the option will be stored here
  *
  * NOTE: Needed to maintain backwards compatibility
  */
