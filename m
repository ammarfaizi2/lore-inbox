Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUGJChZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUGJChZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 22:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266105AbUGJChZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 22:37:25 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:30951 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S266096AbUGJChV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 22:37:21 -0400
Date: Sat, 10 Jul 2004 04:37:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: ext2-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove outdated ext2 help text parts
Message-ID: <20040710023717.GD28324@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below solves Bugzilla #3014 by removing much outdated 
information from the ext2 help text.

The help text is now very short, but few correct information is better 
than outdated information - and if you think it's too short, feel free  
to send a patch that adds more current information.


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.7-mm7-full/fs/Kconfig.old	2004-07-10 04:19:14.000000000 +0200
+++ linux-2.6.7-mm7-full/fs/Kconfig	2004-07-10 04:27:23.000000000 +0200
@@ -7,47 +7,14 @@
 config EXT2_FS
 	tristate "Second extended fs support"
 	help
-	  This is the de facto standard Linux file system (method to organize
-	  files on a storage device) for hard disks.
-
-	  You want to say Y here, unless you intend to use Linux exclusively
-	  from inside a DOS partition using the UMSDOS file system. The
-	  advantage of the latter is that you can get away without
-	  repartitioning your hard drive (which often implies backing
-	  everything up and restoring afterwards); the disadvantage is that
-	  Linux becomes susceptible to DOS viruses and that UMSDOS is somewhat
-	  slower than ext2fs. Even if you want to run Linux in this fashion,
-	  it might be a good idea to have ext2fs around: it enables you to
-	  read more floppy disks and facilitates the transition to a *real*
-	  Linux partition later. Another (rare) case which doesn't require
-	  ext2fs is a diskless Linux box which mounts all files over the
-	  network using NFS (in this case it's sufficient to say Y to "NFS
-	  file system support" below). Saying Y here will enlarge your kernel
-	  by about 44 KB.
-
-	  The Ext2fs-Undeletion mini-HOWTO, available from
-	  <http://www.tldp.org/docs.html#howto>, gives information about
-	  how to retrieve deleted files on ext2fs file systems.
-
-	  To change the behavior of ext2 file systems, you can use the tune2fs
-	  utility ("man tune2fs"). To modify attributes of files and
-	  directories on ext2 file systems, use chattr ("man chattr").
-
-	  Ext2fs partitions can be read from within DOS using the ext2tool
-	  command line tool package (available from
-	  <ftp://ibiblio.org/pub/Linux/system/filesystems/ext2/>) and from
-	  within Windows NT using the ext2nt command line tool package from
-	  <ftp://ibiblio.org/pub/Linux/utils/dos/>.  Explore2fs is a
-	  graphical explorer for ext2fs partitions which runs on Windows 95
-	  and Windows NT and includes experimental write support; it is
-	  available from
-	  <http://jnewbigin-pc.it.swin.edu.au/Linux/Explore2fs.htm>.
+	  Ext2 is a standard Linux file system for hard disks.
 
 	  To compile this file system support as a module, choose M here: the
 	  module will be called ext2.  Be aware however that the file system
 	  of your root partition (the one containing the directory /) cannot
-	  be compiled as a module, and so this could be dangerous.  Most
-	  everyone wants to say Y here.
+	  be compiled as a module, and so this could be dangerous.
+
+	  If unsure, say Y.
 
 config EXT2_FS_XATTR
 	bool "Ext2 extended attributes"

