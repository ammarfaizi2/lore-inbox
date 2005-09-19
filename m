Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVISJ3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVISJ3D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVISJ3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:29:03 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:26307 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S932338AbVISJ3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:29:00 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 19 Sep 2005 10:28:42 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6-BK] More NTFS bugfixes.
Message-ID: <Pine.LNX.4.60.0509190950420.19497@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git/HEAD

 fs/ntfs/ChangeLog |    2 
 fs/ntfs/aops.c    |  122 +++++++++++++++++++++++++++++++++----------------
 fs/ntfs/inode.c   |    9 ++-
 fs/ntfs/malloc.h  |    2 
 fs/ntfs/runlist.c |  132 +++++++++++++++++++++++++++---------------------------
 5 files changed, 158 insertions(+), 109 deletions(-)

This contains several bugfixes for NTFS that need to go in before 2.6.14 
is released.  -  Please apply.  Thanks!

I am sending the changesets as actual diff format patches for non-git
users in follow up emails (in reply to this one).

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
