Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261548AbRERUVP>; Fri, 18 May 2001 16:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbRERUVF>; Fri, 18 May 2001 16:21:05 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:7384 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261543AbRERUUx>;
	Fri, 18 May 2001 16:20:53 -0400
Subject: Announcing Journaled File System (JFS)  release 0.3.2 available
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF9D3FDE7F.051A36C9-ON85256A50.006F769B@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Fri, 18 May 2001 15:20:44 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 05/18/2001 04:20:46 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 0.3.2 of JFS was made available today.

Drop 32 on May 18, 2001 (jfs-0.3.2-patch.tar.gz) includes fixes to the
file system and utilities.

Function and Fixes in release 0.3.2

- Remove the warning message from fsck when partition is mounted read-only
- Fix for assert(mp->count) jfs_metapage.c 675! report as hardlink problem
  in drop 31 (dtDeleteUp was discarding the wrong metapage_t.)
- Fix seg fault problem while creating hard links.
- Fixed dbench hang, do to transaction locks not being freed.
- Added support to correctly handle read-only and remounting the file
system.

For more details about the problems fixed, please see the README.

Steve
JFS for Linux http://oss.software.ibm.com/developerworks/opensource/jfs

