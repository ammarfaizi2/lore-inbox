Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287858AbSAYXqg>; Fri, 25 Jan 2002 18:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288477AbSAYXq0>; Fri, 25 Jan 2002 18:46:26 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29402 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S287858AbSAYXqL>; Fri, 25 Jan 2002 18:46:11 -0500
Subject: [ANNOUNCE]  Journaled File System (JFS)  release 1.0.13
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFF9BEB397.80E8A076-ON86256B4C.0081C4B0@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 25 Jan 2002 17:45:57 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/25/2002 06:46:10 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.13 of JFS was made available today.

Drop 51 on January 25, 2002 (jfs-2.4-1.0.13-patch.tar.gz or
jfs-2.5.2-1.0.13-patch.gz and jfsutils-1.0.1.tar.gz)
includes fixes to the file system and utilities.

Function and Fixes in release 1.0.13

Utilities changes

- update xchklog and xchkdump parameters and man pages
- reduce/eliminate instances of 'access beyond end of
  device' error message
- compatibility fix for different versions of automake
- fix typo in spec file
- defines cleanup (Christoph Hellwig)
- unicode cleanup (Christoph Hellwig)
- endian portability fix (Christoph Hellwig)
- convert types uxx, uintxx, sxx, intxx to C99 types (code cleanup)

File System changes

- chmod changes on newly created directories are lost after umount
  (bug 2535)
- Page locking race fixes (Christoph Hellwig)
- Improve metapage locking (Christoph Hellwig)
- Fix timing window. Lock page while metapage is active to avoid
  page going away before the metadata is released. (Fixed crash
  during mount/umount testing)
- Make changes for 2.5.2 kernel
- Fix race condition truncating large files


For more details about JFS, please see the README or changelog.jfs


Steve
JFS for Linux http://oss.software.ibm.com/jfs



