Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbUJ2Ihi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUJ2Ihi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 04:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbUJ2Ihf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 04:37:35 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:14464 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263149AbUJ2Ihb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 04:37:31 -0400
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Remove duplicate safe_for_read(READ_BUFFER) entry in scsi_ioctl.c
Cc: linux-kernel@vger.kernel.org
From: Miles Bader <miles@gnu.org>
Message-Id: <20041029081546.C8EC74D9@mctpc71>
Date: Fri, 29 Oct 2004 17:15:46 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Miles Bader <miles@gnu.org>

 drivers/block/scsi_ioctl.c |    1 -
 1 files changed, 1 deletion(-)

diff -ruN -X../cludes linux-2.6.9-uc0/drivers/block/scsi_ioctl.c linux-2.6.9-uc0-v850-20041028/drivers/block/scsi_ioctl.c
--- linux-2.6.9-uc0/drivers/block/scsi_ioctl.c	2004-10-25 15:14:43 +0900
+++ linux-2.6.9-uc0-v850-20041028/drivers/block/scsi_ioctl.c	2004-10-28 13:32:47 +0900
@@ -129,7 +129,6 @@
 		safe_for_read(START_STOP),
 		safe_for_read(GPCMD_VERIFY_10),
 		safe_for_read(VERIFY_16),
-		safe_for_read(READ_BUFFER),
 
 		/* Audio CD commands */
 		safe_for_read(GPCMD_PLAY_CD),
