Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264942AbRHEX4v>; Sun, 5 Aug 2001 19:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265810AbRHEX4n>; Sun, 5 Aug 2001 19:56:43 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2790 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264942AbRHEX4d>;
	Sun, 5 Aug 2001 19:56:33 -0400
Subject: Announcing Journaled File System (JFS)  release 1.0.2 available
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFEFFFDFEE.7FB171F6-ON86256A9F.0083141F@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Sun, 5 Aug 2001 18:56:32 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 08/05/2001 07:56:36 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.2 of JFS was made available on August 3, 2001.

Drop 40 on August 3, 2001 (jfs-1.0.2-patch.tar.gz) includes fixes to the
file system and utilities. There is now a patch being provided that will
make it easier to move from release 1.0.1 to 1.0.2, the patch file
is call jfs-1_0_1-to-1_0_2.patch.gz.

Function and Fixes in release 1.0.2

  - Fixed mkfs to display the correct error message if device name is
    not valid or missing (Thanks Evgeni Gechev)
  - gzip the man pages and place them /usr/share/man/man8 during make
    install (Thanks Greg Lehey)
  - Fixed mkfs to properly setup buf_ai (caused Bus error with mkfs on
    SPARC Linux)
  - Fixed fsck to display path correctly
  - Fixed multiple truncate hang (Thanks Anne Milicia)
  - Fixed hang on unlink a file and sync happening at the same time
  - Improved handling of kmalloc error conditions
  - Fixed hang in blk_get_queue and SMP deadlock: bh_end_io call
    generic_make_request (jitterbug 145 and 146)
  - stbl was not set correctly in dtDelete
  - changed trap to printk in dbAllocAG to avoid system hang

For more details about JFS, please see the README or changelog.jfs.

Steve
JFS for Linux http://oss.software.ibm.com/jfs



