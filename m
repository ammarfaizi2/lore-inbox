Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUGRTIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUGRTIN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jul 2004 15:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbUGRTIN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jul 2004 15:08:13 -0400
Received: from web53804.mail.yahoo.com ([206.190.36.199]:24702 "HELO
	web53804.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264443AbUGRTIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jul 2004 15:08:12 -0400
Message-ID: <20040718190812.96765.qmail@web53804.mail.yahoo.com>
Date: Sun, 18 Jul 2004 12:08:12 -0700 (PDT)
From: Carl Spalletta <cspalletta@yahoo.com>
Subject: [PATCH] Remove prototypes of nonexistent functions from fs/jfs files
To: lkml <linux-kernel@vger.kernel.org>
Cc: shaggy@austin.ibm.com, jfs-discussion@oss.software.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ru linux-2.6.7-orig/fs/jfs/jfs_txnmgr.c linux-2.6.7-new/fs/jfs/jfs_txnmgr.c
--- linux-2.6.7-orig/fs/jfs/jfs_txnmgr.c        2004-06-15 22:19:36.000000000 -0700
+++ linux-2.6.7-new/fs/jfs/jfs_txnmgr.c 2004-07-18 08:29:12.000000000 -0700
@@ -165,7 +165,6 @@
  * external references
  */
 extern int lmGroupCommit(struct jfs_log *, struct tblock *);
-extern void lmSync(struct jfs_log *);
 extern int jfs_commit_inode(struct inode *, int);
 extern int jfs_stop_threads;

