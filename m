Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131323AbRDBVik>; Mon, 2 Apr 2001 17:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131324AbRDBVib>; Mon, 2 Apr 2001 17:38:31 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:23211 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S131320AbRDBViT>; Mon, 2 Apr 2001 17:38:19 -0400
Importance: Normal
Subject: Announcing Journaled  File System (JFS)  release 0.2.2 available
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From: "Steve Best" <sbest@us.ibm.com>
Date: Mon, 2 Apr 2001 17:37:35 -0400
Message-ID: <OF189F5459.F38C9965-ON85256A22.00761CAB@raleigh.ibm.com>
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 04/02/2001 05:37:37 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest drop of JFS was made available today.

The file system has fixes included. Also, the utilities have
been cleaned up to use standard types.

In the file system the following problems have been fixed.

- Fix for assert(iagp->wmap[extno] & mask); (line #2875) in jfs_imap
  while running dbench
- Fixed hang on scsi
- added /proc/fs/jfs/jfsFYI (2.4.* kernels only)
     echo 1 > /proc/fs/jfs/jfsFYI  ; Turns on very verbose output to syslog
     echo 0 > /proc/fs/jfs/jfsFYI  ; Turns it back off

For more details about the problems fixed, please see the README.

Steve
JFS for Linux http://oss.software.ibm.com/developerworks/opensource/jfs

