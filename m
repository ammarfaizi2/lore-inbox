Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbVJXRB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVJXRB6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 13:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVJXRB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 13:01:57 -0400
Received: from 253-121.adsl.pool.ew.hu ([193.226.253.121]:50952 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751165AbVJXRB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 13:01:56 -0400
To: akpm@osdl.org
CC: viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/8] FUSE: bump interface minor version
Message-Id: <E1EU5hX-0005ui-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Oct 2005 19:01:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Though the following changes are all backward compatible (from the
kernel's as well as the library's POV) change the minor version, so
interested applications can detect new features.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/fuse.h
===================================================================
--- linux.orig/include/linux/fuse.h	2005-10-24 14:26:16.000000000 +0200
+++ linux/include/linux/fuse.h	2005-10-24 14:26:41.000000000 +0200
@@ -14,7 +14,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 2
+#define FUSE_KERNEL_MINOR_VERSION 3
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
