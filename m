Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965079AbWACXeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965079AbWACXeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWACXeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:34:09 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:31384 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965083AbWACX3B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:29:01 -0500
To: torvalds@osdl.org
Subject: [PATCH 31/41] m68k: zorro __user annotations
Cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org
Message-Id: <E1EtvaO-0003Om-No@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 23:29:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1135011952 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 drivers/zorro/proc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

058382ec23b56fd05928b3d1336aa25ea38af26d
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

