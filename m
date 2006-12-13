Return-Path: <linux-kernel-owner+w=401wt.eu-S965124AbWLMTyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbWLMTyW (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbWLMTyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:54:20 -0500
Received: from ns.suse.de ([195.135.220.2]:45465 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965106AbWLMTxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:53:54 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 8/14] DebugFS : coding style fixes
Date: Wed, 13 Dec 2006 11:52:59 -0800
Message-Id: <11660396133624-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <11660396091326-git-send-email-greg@kroah.com>
References: <20061213195226.GA6736@kroah.com> <1166039585152-git-send-email-greg@kroah.com> <11660395913232-git-send-email-greg@kroah.com> <11660395951158-git-send-email-greg@kroah.com> <11660395998-git-send-email-greg@kroah.com> <11660396032350-git-send-email-greg@kroah.com> <1166039606191-git-send-email-greg@kroah.com> <11660396091326-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Desnoyers <compudj@krystal.dyndns.org>

Minor coding style fixes along the way : 80 cols and a white space.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/debugfs/inode.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 020da4c..05d1a9c 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -55,7 +55,8 @@ static struct inode *debugfs_get_inode(struct super_block *sb, int mode, dev_t d
 			inode->i_op = &simple_dir_inode_operations;
 			inode->i_fop = &simple_dir_operations;
 
-			/* directory inodes start off with i_nlink == 2 (for "." entry) */
+			/* directory inodes start off with i_nlink == 2
+			 * (for "." entry) */
 			inc_nlink(inode);
 			break;
 		}
@@ -143,7 +144,7 @@ static int debugfs_create_by_name(const char *name, mode_t mode,
 	 * block. A pointer to that is in the struct vfsmount that we
 	 * have around.
 	 */
-	if (!parent ) {
+	if (!parent) {
 		if (debugfs_mount && debugfs_mount->mnt_sb) {
 			parent = debugfs_mount->mnt_sb->s_root;
 		}
-- 
1.4.4.2

