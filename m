Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288302AbSAHUp0>; Tue, 8 Jan 2002 15:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288311AbSAHUpR>; Tue, 8 Jan 2002 15:45:17 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:58569 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S288302AbSAHUo7>;
	Tue, 8 Jan 2002 15:44:59 -0500
Subject: [ANNOUNCEMENT]  Journaled File System (JFS)  release 1.0.12
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF891E48A1.7E241F6C-ON85256B3B.0071A4E1@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Tue, 8 Jan 2002 14:44:51 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/08/2002 03:44:51 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.12 of JFS was made available today.

Drop 50 on January 8, 2002 (jfs-2.4-1.0.12-patch.tar.gz
and jfsutils-1.0.12.tar.gz) includes fixes to the file system
and utilities.

Function and Fixes in release 1.0.12

- autoheader must precede automake or config.h doesn't make the tarball
- use current date as release date in jfs utils (Christoph Hellwig)
- fix fsck to update maps at auto check time (fixes file
  system corruption).
- fix file system utilities to be more portable (Christoph Hellwig)
- Add O_DIRECT support (Christoph Hellwig)
- Add support for 2.4.17 kernel
- Make sure COMMIT_STALE gets reset before the inode is unlocked.
  Fixing this gets rid of XT_GETPAGE errors
- Remove invalid __exit keyword from metapage_exit and txExit.
- fix assert(log->cqueue.head == NULL by waiting longer


For more details about JFS, please see the README or changelog.jfs

Steve
JFS for Linux http://oss.software.ibm.com/jfs

