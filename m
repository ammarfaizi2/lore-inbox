Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271685AbRHUOJg>; Tue, 21 Aug 2001 10:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271681AbRHUOJR>; Tue, 21 Aug 2001 10:09:17 -0400
Received: from e24.nc.us.ibm.com ([32.97.136.230]:40860 "EHLO
	e24.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S271677AbRHUOJL>; Tue, 21 Aug 2001 10:09:11 -0400
Subject: Announcing Journaled File System (JFS)  release 1.0.3 available
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF24A34168.0F477E02-ON85256B29.0052E00A@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 21 Dec 2001 09:08:54 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 08/21/2001 10:08:58 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.3 of JFS was made available on August 20, 2001.

Drop 41 on August 20, 2001 (jfs-2.2-1.0.3-patch.tar.gz
or jfs-2.4-1.0.3-patch.tar.gz) includes fixes to the
file system and utilities.

Function and Fixes in release 1.0.3

- Fixed compiler warnings in the utilities on 64 bit systems
- Created jfsutils package
- Patch to move from previous release to latest release needs to
  update the version number in super.c
- Jitterbug problems (134,140,152) removing files have been fixed
- Set rc=ENOSPC if ialloc fails in jfs_create and jfs_mkdir
- Fixed jfs_txnmgr.c 775! assert
- Fixed jfs_txnmgr.c 884! assert(mp->nohomeok==0)
- Fix hang - prevent tblocks from being exhausted
- Fix oops trying to mount reiserfs
- Fail more gracefully in jfs_imap.c
- Print more information when char2uni fails
- Fix timing problem between Block map and metapage cache - jitterbug 139
- Code Cleanup (removed many ifdef's, obsolete code, ran code
  through indent) Mostly 2.4 tree
- Split source tree (Now have a separate source tree for 2.2, 2.4,
  and jfsutils)


For more details about JFS, please see the README or changelog.jfs.

Steve
JFS for Linux http://oss.software.ibm.com/jfs

