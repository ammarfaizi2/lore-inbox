Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268030AbUIGNEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268030AbUIGNEH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 09:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUIGNCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 09:02:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22989 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268019AbUIGNCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 09:02:46 -0400
Date: Tue, 7 Sep 2004 14:02:32 +0100
Message-Id: <200409071302.i87D2W0O030915@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mingming Cao <cmm@us.ibm.com>, pbadari@us.ibm.com,
       Ram Pai <linuxram@us.ibm.com>
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 3/6]: ext3 reservations: Remove unneeded declaration.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc1-mm4/include/linux/ext3_fs.h.=K0002=.orig
+++ linux-2.6.9-rc1-mm4/include/linux/ext3_fs.h
@@ -758,7 +758,6 @@ extern int  ext3_setattr (struct dentry 
 extern void ext3_put_inode (struct inode *);
 extern void ext3_delete_inode (struct inode *);
 extern int  ext3_sync_inode (handle_t *, struct inode *);
-extern void ext3_discard_prealloc (struct inode *);
 extern void ext3_discard_reservation (struct inode *);
 extern void ext3_dirty_inode(struct inode *);
 extern int ext3_change_inode_journal_flag(struct inode *, int);
