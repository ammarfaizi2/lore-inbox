Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbWGTPPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbWGTPPT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 11:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWGTPPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 11:15:19 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:13166 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030332AbWGTPPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 11:15:17 -0400
Message-ID: <44BF9E89.2040202@oracle.com>
Date: Thu, 20 Jul 2006 08:17:29 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH 3/3] kernel-doc: move filesystems together
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Move all VFS + filesystem docs together.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |   78 +++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 39 deletions(-)

--- linux-2618-rc2.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2618-rc2/Documentation/DocBook/kernel-api.tmpl
@@ -178,6 +178,38 @@ X!Ilib/string.c
      </sect1>
   </chapter>
 
+  <chapter id="vfs">
+     <title>The Linux VFS</title>
+     <sect1><title>The Filesystem types</title>
+!Iinclude/linux/fs.h
+     </sect1>
+     <sect1><title>The Directory Cache</title>
+!Efs/dcache.c
+!Iinclude/linux/dcache.h
+     </sect1>
+     <sect1><title>Inode Handling</title>
+!Efs/inode.c
+!Efs/bad_inode.c
+     </sect1>
+     <sect1><title>Registration and Superblocks</title>
+!Efs/super.c
+     </sect1>
+     <sect1><title>File Locks</title>
+!Efs/locks.c
+!Ifs/locks.c
+     </sect1>
+     <sect1><title>Other Functions</title>
+!Efs/mpage.c
+!Efs/namei.c
+!Efs/buffer.c
+!Efs/bio.c
+!Efs/seq_file.c
+!Efs/filesystems.c
+!Efs/fs-writeback.c
+!Efs/block_dev.c
+     </sect1>
+  </chapter>
+
   <chapter id="proc">
      <title>The proc filesystem</title>
  
@@ -190,6 +222,13 @@ X!Ilib/string.c
      </sect1>
   </chapter>
 
+  <chapter id="sysfs">
+     <title>The Filesystem for Exporting Kernel Objects</title>
+!Efs/sysfs/file.c
+!Efs/sysfs/symlink.c
+!Efs/sysfs/bin.c
+  </chapter>
+
   <chapter id="debugfs">
      <title>The debugfs filesystem</title>
  
@@ -215,38 +254,6 @@ X!Ilib/string.c
      </sect1>
   </chapter>
 
-  <chapter id="vfs">
-     <title>The Linux VFS</title>
-     <sect1><title>The Filesystem types</title>
-!Iinclude/linux/fs.h
-     </sect1>
-     <sect1><title>The Directory Cache</title>
-!Efs/dcache.c
-!Iinclude/linux/dcache.h
-     </sect1>
-     <sect1><title>Inode Handling</title>
-!Efs/inode.c
-!Efs/bad_inode.c
-     </sect1>
-     <sect1><title>Registration and Superblocks</title>
-!Efs/super.c
-     </sect1>
-     <sect1><title>File Locks</title>
-!Efs/locks.c
-!Ifs/locks.c
-     </sect1>
-     <sect1><title>Other Functions</title>
-!Efs/mpage.c
-!Efs/namei.c
-!Efs/buffer.c
-!Efs/bio.c
-!Efs/seq_file.c
-!Efs/filesystems.c
-!Efs/fs-writeback.c
-!Efs/block_dev.c
-     </sect1>
-  </chapter>
-
   <chapter id="netcore">
      <title>Linux Networking</title>
      <sect1><title>Networking Base Types</title>
@@ -362,13 +369,6 @@ X!Earch/i386/kernel/mca.c
      </sect1>
   </chapter>
 
-  <chapter id="sysfs">
-     <title>The Filesystem for Exporting Kernel Objects</title>
-!Efs/sysfs/file.c
-!Efs/sysfs/symlink.c
-!Efs/sysfs/bin.c
-  </chapter>
-
   <chapter id="security">
      <title>Security Framework</title>
 !Esecurity/security.c



