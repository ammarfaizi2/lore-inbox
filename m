Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284831AbRL3UOn>; Sun, 30 Dec 2001 15:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284842AbRL3UOd>; Sun, 30 Dec 2001 15:14:33 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:9676 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S284831AbRL3UO0>; Sun, 30 Dec 2001 15:14:26 -0500
Date: Sun, 30 Dec 2001 13:14:19 -0700
Message-Id: <200112302014.fBUKEJM29085@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Bogus devfs ChangeLog change in 2.5.2-pre4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, Linus. Someone sneaked the appended patch into 2.5.2-pre4, which
is not necessary and obviously wrong (the ChangeLog was correct
previously). Please revert.

Looks like the result of an automated global search-and-replace
(i.e. lazy cleanup). Pity a sanity a last-minute sanity check wasn't
performed by the guilty party.
</grumble>

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

diff -urN linux-2.5.2-pre3/fs/devfs/base.c linux/fs/devfs/base.c
--- linux-2.5.2-pre3/fs/devfs/base.c	Sun Dec 30 11:38:08 2001
+++ linux/fs/devfs/base.c	Sun Dec 30 11:38:12 2001
@@ -517,7 +517,6 @@
     20010730   Richard Gooch <rgooch@atnf.csiro.au>
 	       Added DEVFSD_NOTIFY_DELETE event.
     20010801   Richard Gooch <rgooch@atnf.csiro.au>
-	       Removed #include <asm/segment.h>.
   v0.109
     20010807   Richard Gooch <rgooch@atnf.csiro.au>
 	       Fixed inode table races by removing it and using
