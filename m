Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269318AbRINUEe>; Fri, 14 Sep 2001 16:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268957AbRINUEY>; Fri, 14 Sep 2001 16:04:24 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:16039 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268835AbRINUEO>; Fri, 14 Sep 2001 16:04:14 -0400
Subject: [ANNOUNCEMENT]  Journaled File System (JFS)  release 1.0.5 
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF4533144C.E45DA046-ON85256AC7.006D585C@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 14 Sep 2001 15:04:29 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 09/14/2001 04:04:31 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.5 of JFS was made available today.

Drop 43 on September 14, 2001 (jfs-2.2-1.0.5-patch.tar.gz
or jfs-2.4-1.0.5-patch.tar.gz) includes fixes to the
file system and utilities.

Function and Fixes in release 1.0.5

- Fixed jfsprogs.spec to handle utilities not being in file system
  source tree (Thanks Andy Dustman and Anthony Liu)
- Cleaned up include files
- Fixed inconsistencies in mkfs man, html pages
- Allow separate allocation of JFS-private superblock/inode data
  (Thanks Christoph Hellwig).
- Remove checks in namei.c that are already done by the VFS (Thanks
  Christoph Hellwig).
- Remove redundant mutex defines (Thanks Christoph Hellwig).
- Replace all occurrences of #include <linux/malloc.h> with
  #include <linux/slab.h> (Thanks Christoph Hellwig).
- Work around race condition in remount -fixes OOPS during shutdown
- Truncate large files incrementally (affects directories too)

For more details about JFS, please see the README or changelog.jfs.

Steve
JFS for Linux http://oss.software.ibm.com/jfs

