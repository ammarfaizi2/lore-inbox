Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbULFXEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbULFXEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 18:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbULFXEU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 18:04:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:37893 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261494AbULFXCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 18:02:43 -0500
Date: Tue, 7 Dec 2004 00:02:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] floppy.c: remove an unused function (fwd)
Message-ID: <20041206230240.GQ7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Fri, 29 Oct 2004 02:17:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] floppy.c: remove an unused function

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

