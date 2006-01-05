Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWAETPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWAETPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 14:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbWAETPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 14:15:31 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:60822 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750945AbWAETPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 14:15:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=TZFUoXrcajFl51GuWo747LAyWfzkCublonFJ38HvKnkV7DtDzJtdlgEjt7hAhyDpFoX1KIdcta9fhRt2M7Leg4f1fSnKLdzExtETWtpfGNy58I1d7WA/Pa8SzjvcPc78hMqGS+3511tYu6HZgjs27OwMlyjHJYv3XRlCxZIkaEs=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] Docs update: missing files and descriptions for filesystems/00-INDEX
Date: Thu, 5 Jan 2006 20:15:22 +0100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200601052015.22575.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>

Add missing files and descriptions to 
 Documentation/filesystems/00-INDEX

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/filesystems/00-INDEX |   56 ++++++++++++++++++++++++++++++++-----
 1 files changed, 49 insertions(+), 7 deletions(-)

--- linux-2.6.15-mm1-orig/Documentation/filesystems/00-INDEX	2006-01-05 18:15:25.000000000 +0100
+++ linux-2.6.15-mm1/Documentation/filesystems/00-INDEX	2006-01-05 19:53:25.000000000 +0100
@@ -1,31 +1,53 @@
 00-INDEX
 	- this file (info on some of the filesystems supported by linux).
+Exporting
+	- explanation of how to make filesystems exportable.
 Locking
 	- info on locking rules as they pertain to Linux VFS.
 adfs.txt
 	- info and mount options for the Acorn Advanced Disc Filing System.
 affs.txt
 	- info and mount options for the Amiga Fast File System.
+afs.txt
+	- info and examples for the distributed AFS (Andrew File System) fs.
 asfs.txt
 	- info and mount options for the Amiga Smart File System.
+automount-support.txt
+	- information about filesystem automount support.
+befs.txt
+	- information about the BeOS filesystem for Linux.
 bfs.txt
 	- info for the SCO UnixWare Boot Filesystem (BFS).
 cifs.txt
-	- description of the CIFS filesystem
+	- description of the CIFS filesystem.
 coda.txt
 	- description of the CODA filesystem.
 configfs/
 	- directory containing configfs documentation and example code.
 cramfs.txt
-	- info on the cram filesystem for small storage (ROMs etc)
+	- info on the cram filesystem for small storage (ROMs etc).
+dentry-locking.txt
+	- info on the RCU-based dcache locking model.
 devfs/
 	- directory containing devfs documentation.
+directory-locking
+	- info about the locking scheme used for directory operations.
 dlmfs.txt
 	- info on the userspace interface to the OCFS2 DLM.
 ext2.txt
 	- info, mount options and specifications for the Ext2 filesystem.
+ext3.txt
+	- info, mount options and specifications for the Ext3 filesystem.
+files.txt
+	- info on file management in the Linux kernel.
+fuse.txt
+	- info on the Filesystem in User SpacE including mount options.
+hfs.txt
+	- info on the Macintosh HFS Filesystem for Linux.
 hpfs.txt
 	- info and mount options for the OS/2 HPFS.
+inotify.txt
+	- info on the inotify file change notification system.
 isofs.txt
 	- info and mount options for the ISO 9660 (CDROM) filesystem.
 jfs.txt
@@ -34,23 +56,43 @@
 	- info on Novell Netware(tm) filesystem using NCP protocol.
 ntfs.txt
 	- info and mount options for the NTFS filesystem (Windows NT).
-proc.txt
-	- info on Linux's /proc filesystem.
 ocfs2.txt
 	- info and mount options for the OCFS2 clustered filesystem.
+porting
+	- various information on filesystem porting.
+proc.txt
+	- info on Linux's /proc filesystem.
+ramfs-rootfs-initramfs.txt
+	- info on the 'in memory' filesystems ramfs, rootfs and initramfs.
+reiser4.txt
+	- info on the Reiser4 filesystem based on dancing tree algorithms.
+relayfs.txt
+	- info on relayfs, for efficient streaming from kernel to user space.
 romfs.txt
-	- Description of the ROMFS filesystem.
+	- description of the ROMFS filesystem.
 smbfs.txt
-	- info on using filesystems with the SMB protocol (Windows 3.11 and NT)
+	- info on using filesystems with the SMB protocol (Win 3.11 and NT).
+spufs.txt
+	- info and mount options for the SPU filesystem used on Cell.
+sysfs-pci.txt
+	- info on accessing PCI device resources through sysfs.
+sysfs.txt
+	- info on sysfs, a ram-based filesystem for exporting kernel objects.
 sysv-fs.txt
 	- info on the SystemV/V7/Xenix/Coherent filesystem.
+tmpfs.txt
+	- info on tmpfs, a filesystem that holds all files in virtual memory.
 udf.txt
 	- info and mount options for the UDF filesystem.
 ufs.txt
 	- info on the ufs filesystem.
+v9fs.txt
+	- v9fs is a Unix implementation of the Plan 9 9p remote fs protocol.
 vfat.txt
 	- info on using the VFAT filesystem used in Windows NT and Windows 95
 vfs.txt
-	- Overview of the Virtual File System
+	- overview of the Virtual File System
 xfs.txt
 	- info and mount options for the XFS filesystem.
+xip.txt
+	- info on execute-in-place for file mappings.



