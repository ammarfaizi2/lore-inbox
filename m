Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUGRTBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUGRTBD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 15:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264412AbUGRTBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 15:01:03 -0400
Received: from web53805.mail.yahoo.com ([206.190.36.200]:10670 "HELO
	web53805.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264396AbUGRTBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 15:01:01 -0400
Message-ID: <20040718190101.94441.qmail@web53805.mail.yahoo.com>
Date: Sun, 18 Jul 2004 12:01:01 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent functions from fs/befs files
To: lkml <linux-kernel@vger.kernel.org>
Cc: rathamahata@php4.ru
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/fs/befs/befs.h linux-2.6.7-new/fs/befs/befs.h
--- linux-2.6.7-orig/fs/befs/befs.h     2004-06-15 22:19:52.000000000 -0700
+++ linux-2.6.7-new/fs/befs/befs.h      2004-07-18 08:42:01.000000000 -0700
@@ -96,7 +96,6 @@
 void befs_dump_inode(const struct super_block *sb, befs_inode *);
 void befs_dump_index_entry(const struct super_block *sb, befs_btree_super *);
 void befs_dump_index_node(const struct super_block *sb, befs_btree_nodehead *);
-void befs_dump_inode_addr(const struct super_block *sb, befs_inode_addr);
 /****************************/


