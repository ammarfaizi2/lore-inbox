Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbWCWRR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWCWRR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWCWRR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:17:28 -0500
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:42981 "EHLO
	ppsw-9.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750787AbWCWRR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:17:27 -0500
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Thu, 23 Mar 2006 17:17:17 +0000 (GMT)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6-git] NTFS: Release 2.1.27
Message-ID: <Pine.LNX.4.64.0603231713430.18984@hermes-2.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git

This is the next NTFS update containing various bugfixes and cleanups. 

Please apply.  Thanks!

Diffstat:

 Documentation/filesystems/ntfs.txt |    5 +
 fs/ntfs/ChangeLog                  |   32 +++++++++-
 fs/ntfs/Makefile                   |    2
 fs/ntfs/aops.c                     |   15 +++-
 fs/ntfs/attrib.c                   |   36 ++++++-----
 fs/ntfs/compress.c                 |    4 -
 fs/ntfs/dir.c                      |    2
 fs/ntfs/file.c                     |   17 -----
 fs/ntfs/inode.c                    |  114 +++++++++++++++++++++----------------
 fs/ntfs/inode.h                    |   13 ++--
 fs/ntfs/layout.h                   |   46 +++++++-------
 fs/ntfs/mft.c                      |   69 ++++++++++------------
 fs/ntfs/mft.h                      |    6 -
 fs/ntfs/namei.c                    |   10 +--
 fs/ntfs/ntfs.h                     |    2
 fs/ntfs/runlist.c                  |   12 ++-
 fs/ntfs/super.c                    |   88 +++++++++++++++-------------
 fs/ntfs/unistr.c                   |   52 ++++++++++------
 18 files changed, 296 insertions(+), 229 deletions(-)

I am sending the changesets as actual patches generated using git
format-patch for non-git users in follow up emails (in reply to this one).

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
