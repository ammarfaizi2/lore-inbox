Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269387AbRHaV2i>; Fri, 31 Aug 2001 17:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269390AbRHaV23>; Fri, 31 Aug 2001 17:28:29 -0400
Received: from e22.nc.us.ibm.com ([32.97.136.228]:19876 "EHLO
	e22.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S269387AbRHaV2N>; Fri, 31 Aug 2001 17:28:13 -0400
Subject: Announcing Journaled File System (JFS)  release 1.0.4 available
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF1FB25572.4B2FACA2-ON85256AB9.007597A0@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 31 Aug 2001 16:27:14 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 08/31/2001 05:27:14 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.4 of JFS was made available today.

Drop 42 on August 31, 2001 (jfs-2.2-1.0.4-patch.tar.gz
or jfs-2.4-1.0.4-patch.tar.gz) includes fixes to the
file system and utilities.

Function and Fixes in release 1.0.4

- Fixed typecast problem causing intermittent fsck failures on
  64 bit hardware (jitterbug 159)
- Fixed pointer calculation problem causing intermittent fsck
  failures on 64 bit hardware
- Fixed compiler warnings on s/390 and IA64
- Fixed structure size mismatch between file system and utilities
  causing fsck problems when large numbers of inodes are used
- Fixed seg fault in fsck when logging path lengths greater than
  512 characters
- Fixed fsck printf format errors
- Fixed compiler warnings in the FS when building on 64 bits systems
- Fixed deadlock where jfsCommit hung in hold_metapage
- Fixed problems with remount
- Reserve metapages for jfsCommit thread
- Get rid of buggy invalidate_metapage & use discard_metapage
- Don't hand metapages to jfsIOthread (too many context switches)
  (jitterbug 125, bugzilla 238)
- Fix error message in jfs_strtoUCS


For more details about JFS, please see the README or changelog.jfs.

Steve
JFS for Linux http://oss.software.ibm.com/jfs

