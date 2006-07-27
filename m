Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161046AbWG0M7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161046AbWG0M7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 08:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbWG0M7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 08:59:49 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:22984 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1161022AbWG0M7s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 08:59:48 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <E1G65Ok-0002fh-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Thu, 27 Jul 2006 14:55:30 +0200)
Subject: [PATCH 3/5] fuse: fix typo
References: <E1G65Ok-0002fh-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1G65SX-0002hh-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 27 Jul 2006 14:59:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
---

Index: linux/fs/fuse/control.c
===================================================================
--- linux.orig/fs/fuse/control.c	2006-07-27 14:35:14.000000000 +0200
+++ linux/fs/fuse/control.c	2006-07-27 14:38:08.000000000 +0200
@@ -105,7 +105,7 @@ static struct dentry *fuse_ctl_add_dentr
 
 /*
  * Add a connection to the control filesystem (if it exists).  Caller
- * must host fuse_mutex
+ * must hold fuse_mutex
  */
 int fuse_ctl_add_conn(struct fuse_conn *fc)
 {
@@ -139,7 +139,7 @@ int fuse_ctl_add_conn(struct fuse_conn *
 
 /*
  * Remove a connection from the control filesystem (if it exists).
- * Caller must host fuse_mutex
+ * Caller must hold fuse_mutex
  */
 void fuse_ctl_remove_conn(struct fuse_conn *fc)
 {
