Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276764AbRJQPyp>; Wed, 17 Oct 2001 11:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276737AbRJQPyg>; Wed, 17 Oct 2001 11:54:36 -0400
Received: from e23.nc.us.ibm.com ([32.97.136.229]:27853 "EHLO
	e23.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272244AbRJQPyU>; Wed, 17 Oct 2001 11:54:20 -0400
Subject: [ANNOUNCEMENT]  Journaled File System (JFS)  release 1.0.8
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFDFF9CE20.CF0E8A48-ON85256AE8.0056F1BA@raleigh.ibm.com>
From: "Steve Best" <sbest@us.ibm.com>
Date: Wed, 17 Oct 2001 10:53:34 -0500
X-MIMETrack: Serialize by Router on D04NM201/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/17/2001 11:53:36 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Release 1.0.8 of JFS was made available today.

Drop 46 on October 17, 2001 (jfs-2.4-1.0.8-patch.tar.gz
and jfsutils-1.0.8.tar.gz) includes fixes to the file system
and utilities.

Function and Fixes in release 1.0.8

- Christoph Hellwig: install prefix support for jfsutils
- cleanup option handling make -y behave (jitterbug 177),
  -f override -p
- Add more informative error message when running fsck.jfs RO,
  (jitterbug 173)
- clean up remove carriage return after new line in messaging
- print mkfs.jfs version correctly
- Synclist was being built backwards causing logredo to quit too early
- Christoph Hellwig: jfs_compat.h needs to include module.h
- Christoph Hellwig: uncomment EXPORTS_NO_SYMBOLS in super.c
- Christoph Hellwig: Minor code cleanup
- xtree of zero-truncated file not being logged
- Fix logging on file truncate
- Christoph Hellwig: remove unused metapage fields


For more details about JFS, please see the README or changelog.jfs.

Steve
JFS for Linux http://oss.software.ibm.com/jfs

