Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbVLVEv5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbVLVEv5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 23:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965099AbVLVEv4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 23:51:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37840 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965101AbVLVEvp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 23:51:45 -0500
To: linux-m68k@vger.kernel.org
Subject: [PATCH 32/36] m68k: zorro __user annotations
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1EpIQa-0004tn-OZ@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Thu, 22 Dec 2005 04:51:44 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135011952 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/zorro/proc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

ea6db3171bc2fc1ba2fb09ece99f064dbbdcf66b
diff --git a/drivers/zorro/proc.c b/drivers/zorro/proc.c
index 1a409c2..7aa2d3d 100644
--- a/drivers/zorro/proc.c
+++ b/drivers/zorro/proc.c
@@ -45,7 +45,7 @@ proc_bus_zorro_lseek(struct file *file, 
 }
 
 static ssize_t
-proc_bus_zorro_read(struct file *file, char *buf, size_t nbytes, loff_t *ppos)
+proc_bus_zorro_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 {
 	struct inode *ino = file->f_dentry->d_inode;
 	struct proc_dir_entry *dp = PDE(ino);
-- 
0.99.9.GIT

