Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbUJaKDB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbUJaKDB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 05:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbUJaKDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 05:03:00 -0500
Received: from baikonur.stro.at ([213.239.196.228]:19874 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S261520AbUJaKCY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:02:24 -0500
Date: Sun, 31 Oct 2004 11:02:06 +0100
From: maximilian attems <janitor@sternwelten.at>
To: akpm@osdl.org
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: [patch 2.6] maintainer vfs email
Message-ID: <20041031100206.GB1882@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Diagnostic-Code: X-Postfix; host leibniz.math.psu.edu[146.186.130.2] said: 550
    5.1.1 <viro@math.psu.edu>... User unknown (in reply to RCPT TO command)

maybe thats an temporary error,
if not please update MAINTAINERS entry and other bunch of places.


---

 Documentation/DocBook/procfs-guide.tmpl   |    4 ++--
 Documentation/filesystems/devfs/ChangeLog |    2 +-
 MAINTAINERS                               |    2 +-
 fs/ext2/namei.c                           |    3 ++-
 fs/sysv/CHANGES                           |    2 +-
 fs/sysv/ChangeLog                         |   12 ++++++------
 6 files changed, 13 insertions(+), 12 deletions(-)

diff -puN MAINTAINERS~maintainer-viro MAINTAINERS
--- a/MAINTAINERS~maintainer-viro	2004-10-31 10:53:16.000000000 +0100
+++ b/MAINTAINERS	2004-10-31 10:53:54.000000000 +0100
@@ -832,7 +832,7 @@ S:	Maintained
 
 FILESYSTEMS (VFS and infrastructure)
 P:	Alexander Viro
-M:	viro@math.psu.edu
+M:	viro@parcelfarce.linux.theplanet.co.uk
 S:	Maintained
 
 FIRMWARE LOADER (request_firmware)
diff -puN fs/sysv/ChangeLog~maintainer-viro fs/sysv/ChangeLog
--- a/fs/sysv/ChangeLog~maintainer-viro	2004-10-31 10:53:16.000000000 +0100
+++ b/fs/sysv/ChangeLog	2004-10-31 10:54:47.000000000 +0100
@@ -4,7 +4,7 @@ Thu Feb 14 2002  Andrew Morton  <akpm@zi
 	  waitfor_one_page() for IS_SYNC directories, so that we
 	  actually do sync the directory. (forward-port from 2.4).
 
-Thu Feb  7 2002  Alexander Viro  <viro@math.psu.edu>
+Thu Feb  7 2002  Alexander Viro  <viro@parcelfarce.linux.theplanet.co.uk>
 
 	* super.c: switched to ->get_sb()
 	* ChangeLog: fixed dates ;-)
@@ -13,7 +13,7 @@ Thu Feb  7 2002  Alexander Viro  <viro@m
 
 	* inode.c: Include linux/init.h
 
-Mon Jan 21 2002  Alexander Viro  <viro@math.psu.edu>
+Mon Jan 21 2002  Alexander Viro  <viro@parcelfarce.linux.theplanet.co.uk>
 	* ialloc.c (sysv_new_inode): zero SYSV_I(inode)->i_data out.
 	* i_vnode renamed to vfs_inode.  Sorry, but let's keep that
 	  consistent.
@@ -43,7 +43,7 @@ Sat Jan 19 2002  Christoph Hellwig  <hch
 	* symlink.c (sysv_readlink): Likewise.
 	(sysv_follow_link): Likewise.
 
-Fri Jan  4 2002  Alexander Viro  <viro@math.psu.edu>
+Fri Jan  4 2002  Alexander Viro  <viro@parcelfarce.linux.theplanet.co.uk>
 
 	* ialloc.c (sysv_free_inode): Use sb->s_id instead of bdevname().
 	* inode.c (sysv_read_inode): Likewise.
@@ -59,16 +59,16 @@ Sun Dec 30 2001  Manfred Spraul  <manfre
 	* dir.c (dir_commit_chunk): Do not set dir->i_version.
 	(sysv_readdir): Likewise.
 
-Thu Dec 27 2001  Alexander Viro  <viro@math.psu.edu>
+Thu Dec 27 2001  Alexander Viro  <viro@parcelfarce.linux.theplanet.co.uk>
 
 	* itree.c (get_block): Use map_bh() to fill out bh_result.
 
-Tue Dec 25 2001  Alexander Viro  <viro@math.psu.edu>
+Tue Dec 25 2001  Alexander Viro  <viro@parcelfarce.linux.theplanet.co.uk>
 
 	* super.c (sysv_read_super): Use sb_set_blocksize() to set blocksize.
 	  (v7_read_super): Likewise.
 
-Tue Nov 27 2001  Alexander Viro  <viro@math.psu.edu>
+Tue Nov 27 2001  Alexander Viro  <viro@parcelfarce.linux.theplanet.co.uk>
 
 	* itree.c (get_block): Change type for iblock argument to sector_t.
 	* super.c (sysv_read_super): Set s_blocksize early.
diff -puN fs/sysv/CHANGES~maintainer-viro fs/sysv/CHANGES
--- a/fs/sysv/CHANGES~maintainer-viro	2004-10-31 10:53:17.000000000 +0100
+++ b/fs/sysv/CHANGES	2004-10-31 10:54:55.000000000 +0100
@@ -19,7 +19,7 @@ Wed, 4 Feb 1998   Krzysztof G. Baranowsk
 	*    namei.c: removed static subdir(); is_subdir() from dcache.c
 		      is used instead. Cosmetic changes.
 
-Thu, 3 Dec 1998   Al Viro (viro@math.psu.edu)
+Thu, 3 Dec 1998   Al Viro (viro@parcelfarce.linux.theplanet.co.uk)
 	*    namei.c (sysv_rmdir):
 		      Bugectomy: old check for victim being busy
 		      (inode->i_count) wasn't replaced (with checking
diff -puN fs/ext2/namei.c~maintainer-viro fs/ext2/namei.c
--- a/fs/ext2/namei.c~maintainer-viro	2004-10-31 10:53:17.000000000 +0100
+++ b/fs/ext2/namei.c	2004-10-31 10:55:04.000000000 +0100
@@ -2,7 +2,8 @@
  * linux/fs/ext2/namei.c
  *
  * Rewrite to pagecache. Almost all code had been changed, so blame me
- * if the things go wrong. Please, send bug reports to viro@math.psu.edu
+ * if the things go wrong. Please, send bug reports to
+ * viro@parcelfarce.linux.theplanet.co.uk
  *
  * Stuff here is basically a glue between the VFS and generic UNIXish
  * filesystem that keeps everything in pagecache. All knowledge of the
diff -puN Documentation/DocBook/procfs-guide.tmpl~maintainer-viro Documentation/DocBook/procfs-guide.tmpl
--- a/Documentation/DocBook/procfs-guide.tmpl~maintainer-viro	2004-10-31 10:53:17.000000000 +0100
+++ b/Documentation/DocBook/procfs-guide.tmpl	2004-10-31 10:55:22.000000000 +0100
@@ -100,8 +100,8 @@
     <para>
       I'd like to thank Jeff Garzik
       <email>jgarzik@pobox.com</email> and Alexander Viro
-      <email>viro@math.psu.edu</email> for their input, Tim Waugh
-      <email>twaugh@redhat.com</email> for his <ulink
+      <email>viro@parcelfarce.linux.theplanet.co.uk</email> for their input,
+      Tim Waugh <email>twaugh@redhat.com</email> for his <ulink
       url="http://people.redhat.com/twaugh/docbook/selfdocbook/">Selfdocbook</ulink>,
       and Marc Joosen <email>marcj@historia.et.tudelft.nl</email> for
       proofreading.
diff -puN Documentation/filesystems/devfs/ChangeLog~maintainer-viro Documentation/filesystems/devfs/ChangeLog
--- a/Documentation/filesystems/devfs/ChangeLog~maintainer-viro	2004-10-31 10:53:17.000000000 +0100
+++ b/Documentation/filesystems/devfs/ChangeLog	2004-10-31 10:55:28.000000000 +0100
@@ -1632,7 +1632,7 @@ Changes for patch v177
 - Fixed bugs in handling symlinks: could leak or cause Oops
 
 - Cleaned up directory handling by separating fops
-  Thanks to Alexander Viro <viro@math.psu.edu>
+  Thanks to Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
 ===============================================================================
 Changes for patch v178
 
_
