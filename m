Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263096AbVGNSgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbVGNSgF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbVGNSd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:33:59 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.47.40]:59613 "EHLO
	ms-smtp-01-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S263082AbVGNSbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:31:36 -0400
Message-Id: <200507141830.j6EIUeH9014839@ms-smtp-01-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Sun, 17 Jul 2005 08:53:43 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc2-mm2 1/7] v9fs: Documentation, Makefiles, Configuration (2.0.2)
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [1/7] of the v9fs-2.0.2 patch against Linux 2.6.13-rc2-mm2

This part of the patch contains Documentation, Makefiles, 
and configuration file changes related to hch's comments.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>


 ----------

 fs/9p/Makefile |    1 -
 1 files changed, 1 deletion(-)

 ----------

--- a/fs/9p/Makefile
+++ b/fs/9p/Makefile
@@ -6,7 +6,6 @@ obj-$(CONFIG_9P_FS) := 9p2000.o
 	vfs_file.o \
 	vfs_dir.o \
 	vfs_dentry.o \
-	idpool.o \
 	error.o \
 	mux.o \
 	trans_sock.o \
