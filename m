Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263206AbUJ2B7d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263206AbUJ2B7d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUJ2B6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 21:58:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:15110 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263160AbUJ2AR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:17:57 -0400
Date: Fri, 29 Oct 2004 02:17:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] floppy.c: remove an unused function
Message-ID: <20041029001719.GH29142@stusta.de>
References: <20041028221835.GN3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028221835.GN3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes an unused function from drivers/block/floppy.c


diffstat output:
 drivers/block/floppy.c |    5 -----
 1 files changed, 5 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/block/floppy.c.old	2004-10-28 22:52:49.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/block/floppy.c	2004-10-28 22:53:05.000000000 +0200
@@ -3325,11 +3325,6 @@
 	return 0;
 }
 
-static inline void clear_write_error(int drive)
-{
-	CLEARSTRUCT(UDRWE);
-}
-
 static inline int set_geometry(unsigned int cmd, struct floppy_struct *g,
 			       int drive, int type, struct block_device *bdev)
 {
