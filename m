Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUGRSzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUGRSzQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 14:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUGRSzQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 14:55:16 -0400
Received: from web53809.mail.yahoo.com ([206.190.36.204]:9551 "HELO
	web53809.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264388AbUGRSzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 14:55:14 -0400
Message-ID: <20040718185513.42009.qmail@web53809.mail.yahoo.com>
Date: Sun, 18 Jul 2004 11:55:13 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent functions from fs/adfs files
To: linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/fs/adfs/adfs.h linux-2.6.7-new/fs/adfs/adfs.h
--- linux-2.6.7-orig/fs/adfs/adfs.h     2004-06-15 22:20:03.000000000 -0700
+++ linux-2.6.7-new/fs/adfs/adfs.h      2004-07-18 08:41:19.000000000 -0700
@@ -71,7 +71,6 @@
 int adfs_get_block(struct inode *inode, sector_t block,
                   struct buffer_head *bh, int create);
 struct inode *adfs_iget(struct super_block *sb, struct object_info *obj);
-void adfs_read_inode(struct inode *inode);
 void adfs_write_inode(struct inode *inode,int unused);
 int adfs_notify_change(struct dentry *dentry, struct iattr *attr);

