Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274667AbRJJUh3>; Wed, 10 Oct 2001 16:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272882AbRJJUhK>; Wed, 10 Oct 2001 16:37:10 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:134 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S274299AbRJJUhG>;
	Wed, 10 Oct 2001 16:37:06 -0400
Subject: [ANNOUNCEMENT]  Journaled File System (JFS)  release 1.0.7
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF8ED7FFFC.DC981A86-ON85256AE1.0070EA18@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Wed, 10 Oct 2001 15:37:19 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/10/2001 04:37:20 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.7 of JFS was made available today.

Drop 45 on October 10, 2001 (jfs-2.4-1.0.7-patch.tar.gz
and jfsutils-1.0.7.tar.gz) includes fixes to the file system
and utilities.

Function and Fixes in release 1.0.7

- improve fsck's 'mounted' detection
  This will remove the fsck message 'Cannot access file system
  description   file to determine mount status and file system type of
  /dev/device name'.
- improve utils' checking for fs type jfs
- replace __uX with uintX_t - (Thanks Fred Oberhauser)
- change fsck.jfs options to be similar to e2fsck
- set fsck.jfs default to automatically fix the file system

- cleanup remove IS_KIOBUFIO define.
- cleanup remove TRUNC_NO_TOSS define.(Thanks Christoph Hellwig)
- have jFYI's use the name directly from dentry (Thanks Christoph Hellwig)
- Remove nul _ALLOC and _FREE macros and also make spinlocks static.
  (Thanks Christoph Hellwig)
- cleanup add externs where needed in the header files
  (Thanks Christoph Hellwig)
- jfs_write_inode is a bad place to call iput.  Also limit warnings.
- More truncate cleanup (Thanks Christoph Hellwig)
- Truncate cleanup (Thanks Christoph Hellwig)
- Add missing statics in jfs_metapage.c (Thanks Christoph Hellwig)
- fsync fixes
- Clean up symlink code - use page_symlink_inode_operations
  (Thanks Christoph Hellwig)
- unicode handling cleanup (Thanks Christoph Hellwig)
- cleanup replace UniChar with wchar_t
- Get rid of CDLL_* macros - use list.h instead (Thanks Christoph Hellwig)
- 2.4.11-prex mount problem Call new_inode instead of get_empty_inode
- use kernel min/max macros (Thanks Christoph Hellwig)
- Add MODULE_LICENSE stub for older kernels (Thanks Christoph Hellwig)
- IA64/gcc3 fixes (Thanks Christoph Hellwig)
- Log Manager fixes, introduce __SLEEP_COND macro
  (Thanks Christoph Hellwig)
- Mark superblock dirty when some errors detected (forcing fsck to be run).
- More robust remounting from r/o to r/w.
- Misc. cleanup add static where appropriate (Thanks Christoph Hellwig)
- small cleanup in jfs_umount_rw (Thanks Christoph Hellwig)
- add MODULE_ stuff (Thanks Christoph Hellwig)
- Set *dropped_lock in alloc_metapage (Thanks Christoph Hellwig)
- Get rid of unused log list (Thanks Christoph Hellwig)
- cleanup jfs_imap.c to remove _OLD_STUFF and _NO_MORE_MOUNT_INODE
  defines (Thanks Christoph Hellwig)
- Log manager cleanup (Thanks Christoph Hellwig)
- Transaction manager cleanup (Thanks Christoph Hellwig)
- correct memory allocations flags (Thanks Christoph Hellwig)
- Better handling of iterative truncation
- Change continue to break, otherwise we don't re-acquire LAZY_LOCK


For more details about JFS, please see the README or changelog.jfs.

Steve
JFS for Linux http://oss.software.ibm.com/jfs



