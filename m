Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935001AbWKXSqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935001AbWKXSqd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 13:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935000AbWKXSqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 13:46:33 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:23539 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S935001AbWKXSqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 13:46:32 -0500
Date: Fri, 24 Nov 2006 13:46:30 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Greg KH <greg@kroah.com>
Cc: ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] DebugFS : coding style fixes, 2.6.19-rc6
Message-ID: <20061124184630.GB8952@Krystal>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com> <20061123075256.GC1703@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061123075256.GC1703@Krystal>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 13:45:41 up 93 days, 15:53,  4 users,  load average: 0.21, 0.25, 0.22
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor coding style fixes along the way : 80 cols and a white space.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>


--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -54,7 +54,8 @@ static struct inode *debugfs_get_inode(s
 			inode->i_op = &simple_dir_inode_operations;
 			inode->i_fop = &simple_dir_operations;
 
-			/* directory inodes start off with i_nlink == 2 (for "." entry) */
+			/* directory inodes start off with i_nlink == 2
+			 * (for "." entry) */
 			inc_nlink(inode);
 			break;
 		}
@@ -142,7 +143,7 @@ static int debugfs_create_by_name(const 
 	 * block. A pointer to that is in the struct vfsmount that we
 	 * have around.
 	 */
-	if (!parent ) {
+	if (!parent) {
 		if (debugfs_mount && debugfs_mount->mnt_sb) {
 			parent = debugfs_mount->mnt_sb->s_root;
 		}

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
