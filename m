Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUGRTLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUGRTLJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 15:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUGRTLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 15:11:09 -0400
Received: from web53807.mail.yahoo.com ([206.190.36.202]:53878 "HELO
	web53807.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264479AbUGRTLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 15:11:08 -0400
Message-ID: <20040718191107.97920.qmail@web53807.mail.yahoo.com>
Date: Sun, 18 Jul 2004 12:11:07 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent functions from fs/proc files
To: lkml <linux-kernel@vger.kernel.org>
Cc: viro@math.psu.edu
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/fs/proc/base.c linux-2.6.7-new/fs/proc/base.c
--- linux-2.6.7-orig/fs/proc/base.c     2004-06-15 22:19:37.000000000 -0700
+++ linux-2.6.7-new/fs/proc/base.c      2004-07-18 08:46:47.000000000 -0700
@@ -180,7 +180,6 @@
 int proc_pid_stat(struct task_struct*,char*);
 int proc_pid_status(struct task_struct*,char*);
 int proc_pid_statm(struct task_struct*,char*);
-int proc_pid_cpu(struct task_struct*,char*);

 static int proc_fd_link(struct inode *inode, struct dentry **dentry, struct vfsmount **mnt)
 {

