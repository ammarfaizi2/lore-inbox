Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279992AbRKIRAv>; Fri, 9 Nov 2001 12:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279993AbRKIRAm>; Fri, 9 Nov 2001 12:00:42 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:28804 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S279987AbRKIRAd>; Fri, 9 Nov 2001 12:00:33 -0500
Subject: [ANNOUNCEMENT]  Journaled File System (JFS)  release 1.0.9
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFAB7E736A.A5C21A90-ON85256AFF.005D3B1C@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 9 Nov 2001 11:00:24 -0600
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 11/09/2001 12:00:25 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.9 of JFS was made available today.

Drop 47 on November 9, 2001 (jfs-2.4-1.0.9-patch.tar.gz
and jfsutils-1.0.9.tar.gz) includes fixes to the file system
and utilities.

Function and Fixes in release 1.0.9

- don't print heartbeat if fsck.jfs output is redirected
- make mkfs.jfs options conform to mkfs, clean up parse code
- fix typo in mkfs.jfs man_html page
- allow xpeek to show us directory xtrees
- fix fsck.jfs infinite loop on big endian hardware (jitterbug 182)
- fix infinite loop when endian swapping bad directory tree page
- Fix data corruption problem when creating files while deleting
  others. (jitterbug 183)
- Make sure all metadata is written before finalizing the log
- Fix serialization problem in shutdown by setting i_size of directory
  sooner. (bugzilla # 334)
- JFS should quit whining when special files are marked dirty during
  read-only mount.
- Must always check rc after DT_GETPAGE
- Add diExtendFS
- Removing defconfig from JFS source - not really needed

For more details about JFS, please see the README or changelog.jfs.

Steve
JFS for Linux http://oss.software.ibm.com/jfs


