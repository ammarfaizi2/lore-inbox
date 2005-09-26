Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbVIZNbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbVIZNbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 09:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbVIZNbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 09:31:23 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:57987 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1750890AbVIZNbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 09:31:23 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Mon, 26 Sep 2005 14:31:15 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [2.6.14-rc2-git] NTFS: Even more bug fixes!
Message-ID: <Pine.LNX.4.60.0509261427520.32257@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from

rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs-2.6.git/HEAD

 fs/ntfs/ChangeLog  |   26 +++++++++++++++++---------
 fs/ntfs/Makefile   |    4 ++--
 fs/ntfs/layout.h   |    9 +++++----
 fs/ntfs/lcnalloc.c |   31 +++++++++++++------------------
 fs/ntfs/lcnalloc.h |   27 +++++++++++++--------------
 fs/ntfs/logfile.c  |   30 +++++++++++++++++++++++++-----
 fs/ntfs/logfile.h  |    2 +-
 fs/ntfs/mft.c      |    2 +-
 8 files changed, 77 insertions(+), 54 deletions(-)

This contains more bugfixes for NTFS that need to go in before 2.6.14
is released.  -  Please apply.  Thanks!  -  There should really not be any 
more for 2.6.14!  Famous last, last words...

Diff style patches generated with git format-patch follow as replies to 
this email.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
