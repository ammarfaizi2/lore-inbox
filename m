Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVDDVxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVDDVxT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 17:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVDDVu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 17:50:59 -0400
Received: from host201.dif.dk ([193.138.115.201]:40453 "EHLO
	diftmgw2.backbone.dif.dk") by vger.kernel.org with ESMTP
	id S261406AbVDDVly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 17:41:54 -0400
Date: Mon, 4 Apr 2005 23:43:22 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] cifs: cifsfs.h whitespace cleanups
Message-ID: <Pine.LNX.4.62.0504042341330.2496@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch also available here: 
http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_cifsfs_h-whitespace.patch

Misc minor whitespace cleanups.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>


--- linux-2.6.12-rc1-mm4-orig/fs/cifs/cifsfs.h	2005-03-31 21:19:59.000000000 +0200
+++ linux-2.6.12-rc1-mm4/fs/cifs/cifsfs.h	2005-04-04 23:39:17.000000000 +0200
@@ -38,21 +38,21 @@
 extern struct super_operations cifs_super_ops;
 extern void cifs_read_inode(struct inode *);
 extern void cifs_delete_inode(struct inode *);
-/* extern void cifs_write_inode(struct inode *); *//* BB not needed yet */
+/* extern void cifs_write_inode(struct inode *); */ /* BB not needed yet */
 
 /* Functions related to inodes */
 extern struct inode_operations cifs_dir_inode_ops;
-extern int cifs_create(struct inode *, struct dentry *, int, 
-		       struct nameidata *);
-extern struct dentry * cifs_lookup(struct inode *, struct dentry *,
-				  struct nameidata *);
+extern int cifs_create(struct inode *, struct dentry *, int,
+	struct nameidata *);
+extern struct dentry *cifs_lookup(struct inode *, struct dentry *,
+	struct nameidata *);
 extern int cifs_unlink(struct inode *, struct dentry *);
 extern int cifs_hardlink(struct dentry *, struct inode *, struct dentry *);
 extern int cifs_mknod(struct inode *, struct dentry *, int, dev_t);
 extern int cifs_mkdir(struct inode *, struct dentry *, int);
 extern int cifs_rmdir(struct inode *, struct dentry *);
 extern int cifs_rename(struct inode *, struct dentry *, struct inode *,
-		       struct dentry *);
+	struct dentry *);
 extern int cifs_revalidate(struct dentry *);
 extern int cifs_getattr(struct vfsmount *, struct dentry *, struct kstat *);
 extern int cifs_setattr(struct dentry *, struct iattr *);
@@ -67,9 +67,9 @@
 extern int cifs_close(struct inode *inode, struct file *file);
 extern int cifs_closedir(struct inode *inode, struct file *file);
 extern ssize_t cifs_user_read(struct file *file, char __user *read_data,
-			 size_t read_size, loff_t * poffset);
-extern ssize_t cifs_user_write(struct file *file, const char __user *write_data,
-			 size_t write_size, loff_t * poffset);
+	size_t read_size, loff_t * poffset);
+extern ssize_t cifs_user_write(struct file *file,
+	const char __user *write_data, size_t write_size, loff_t * poffset);
 extern int cifs_lock(struct file *, int, struct file_lock *);
 extern int cifs_fsync(struct file *, struct dentry *, int);
 extern int cifs_flush(struct file *);
@@ -85,14 +85,14 @@
 /* Functions related to symlinks */
 extern int cifs_follow_link(struct dentry *direntry, struct nameidata *nd);
 extern void cifs_put_link(struct dentry *direntry, struct nameidata *nd);
-extern int cifs_readlink(struct dentry *direntry, char __user *buffer, 
-			 int buflen);
+extern int cifs_readlink(struct dentry *direntry, char __user *buffer,
+	int buflen);
 extern int cifs_symlink(struct inode *inode, struct dentry *direntry,
-			const char *symname);
-extern int	cifs_removexattr(struct dentry *, const char *);
-extern int 	cifs_setxattr(struct dentry *, const char *, const void *,
-			 size_t, int);
-extern ssize_t	cifs_getxattr(struct dentry *, const char *, void *, size_t);
-extern ssize_t	cifs_listxattr(struct dentry *, char *, size_t);
+	const char *symname);
+extern int cifs_removexattr(struct dentry *, const char *);
+extern int  cifs_setxattr(struct dentry *, const char *, const void *,
+	size_t, int);
+extern ssize_t cifs_getxattr(struct dentry *, const char *, void *, size_t);
+extern ssize_t cifs_listxattr(struct dentry *, char *, size_t);
 #define CIFS_VERSION   "1.31"
-#endif				/* _CIFSFS_H */
+#endif	/* _CIFSFS_H */

