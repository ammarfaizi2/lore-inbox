Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVCCKuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVCCKuG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbVCCKtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:49:41 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:8372 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261575AbVCCKmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:42:45 -0500
Date: Thu, 3 Mar 2005 11:42:34 +0100
Message-Id: <200503031042.j23AgYv2020750@faui31y.informatik.uni-erlangen.de>
From: Martin Waitz <tali@admingilde.org>
To: tali@admingilde.org
Cc: linux-kernel@vger.kernel.org
References: <20050303102852.GG8617@admingilde.org>
Subject: [PATCH 10/16] DocBook: move kernel-doc comment next to function
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DocBook: move kernel-doc comment next to function
Signed-off-by: Martin Waitz <tali@admingilde.org>


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.2034  -> 1.2035 
#	drivers/video/fbmem.c	1.151   -> 1.152  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 05/02/08	tali@admingilde.org	1.2035
# DocBook: move kernel-doc comment next to function
# 
# Signed-off-by: Martin Waitz <tali@admingilde.org>
# --------------------------------------------
#
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	Thu Mar  3 11:42:38 2005
+++ b/drivers/video/fbmem.c	Thu Mar  3 11:42:38 2005
@@ -1249,6 +1249,9 @@
 	return retval;
 }
 
+
+extern const char *global_mode_option;
+
 /**
  *	video_setup - process command line options
  *	@options: string of options
@@ -1262,9 +1265,6 @@
  *	Returns zero.
  *
  */
-
-extern const char *global_mode_option;
-
 int __init video_setup(char *options)
 {
 	int i, global = 0;
