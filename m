Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279998AbRK1TBi>; Wed, 28 Nov 2001 14:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280035AbRK1TBb>; Wed, 28 Nov 2001 14:01:31 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:31181 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S280027AbRK1TBQ>; Wed, 28 Nov 2001 14:01:16 -0500
Subject: [ANNOUNCEMENT]  Journaled File System (JFS)  release 1.0.10
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFB0BF2ECD.D74BD3BE-ON85256B12.00684829@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Wed, 28 Nov 2001 13:01:07 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 11/28/2001 02:01:09 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.10 of JFS was made available today.

Drop 48 on November 28, 2001 (jfs-2.4-1.0.10-patch.tar.gz
and jfsutils-1.0.10.tar.gz) includes fixes to the file system
and utilities.

Function and Fixes in release 1.0.10

- fsck shouldn't endian swap dtree struct twice
- Christoph Hellwig: put inodes later on hash queues
- Fix boundary case in xtTruncate
- When invalidating metadata, try to flush the dirty buffers
  rather than sync them.
- Add another sanity check to avoid trapping when imap is corrupt
- Fix file truncate while removing large file (assert(cmp == 0))
- read_cache_page returns ERR_PTR, not NULL on error
- Add dtSearchNode and dtRelocate
- Christoph Hellwig: JFS needs to use generic_file_open &
  generic_file_llseek
- Remove lazyQwait, etc. It created an unnecessary bottleneck in TxBegin.

For more details about JFS, please see the README or changelog.jfs.

Steve
JFS for Linux http://oss.software.ibm.com/jfs

