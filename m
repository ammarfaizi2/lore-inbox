Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261936AbRE2M3R>; Tue, 29 May 2001 08:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262009AbRE2M3H>; Tue, 29 May 2001 08:29:07 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:31724 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261936AbRE2M27>; Tue, 29 May 2001 08:28:59 -0400
Subject: Announcing Journaled File System (JFS)  release 0.3.3 available
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF0882FE85.EA41FCE4-ON86256A5B.0006231C@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Tue, 29 May 2001 07:28:51 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 05/29/2001 08:28:54 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 0.3.3 of JFS was made available May 25, 2001.

Drop 33 on May 25, 2001 (jfs-0.3.3-patch.tar.gz) includes fixes to the
file system and utilities. There is now a patch being provided that
will make it easier to move from release 0.3.2 to 0.3.3, the patch file
is call jfs-0_3_2-to-0_3_3.patch.gz.

Function and Fixes in release 0.3.3

- Fix fsck to handle mount read-only correctly
- Fix top level utilities makefile to be able to easily overide
  version of gcc compiler
- Man pages are now available in html format
- Fixed statfs call to return the maximum number of inodes that
  JFS could allocate. (problem reported as rpm exits with a (x) inodes
  needed message without installing the package).
- Fix to handle a case where a inode wasn't getting written to disk.
- Increase the performance of unlinking files.
- Fix to null terminate symlinks.
- General SMP fixes.

For more details about the problems fixed, please see the README.

Steve
JFS for Linux http://oss.software.ibm.com/jfs



