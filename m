Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbVAPHX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbVAPHX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 02:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVAPHX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 02:23:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29453 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262441AbVAPHXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 02:23:51 -0500
Date: Sun, 16 Jan 2005 08:23:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, domen@coderock.org,
       james4765@gmail.com
Subject: [patch 1/1] floppy: relocate devfs comment (fwd)
Message-ID: <20050116072348.GR4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial patch by James Nelson <james4765@gmail.com> forwarded below 
still applies and compiles against 2.6.11-rc1-mm1.

Signed-off-by: Adrian Bunk <bunk@stusta.de>



----- Forwarded message from domen@coderock.org -----

Date:	Sat, 25 Dec 2004 15:13:04 +0100
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, james4765@gmail.com
Subject: [patch 1/1] floppy: relocate devfs comment


Oops, forgot Signed-off-by: line.

Signed-off-by: James Nelson <james4765@gmail.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/floppy.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/block/floppy.c~comment-drivers_block_floppy.c drivers/block/floppy.c
--- kj/drivers/block/floppy.c~comment-drivers_block_floppy.c	2004-12-25 01:35:26.000000000 +0100
+++ kj-domen/drivers/block/floppy.c	2004-12-25 01:35:26.000000000 +0100
@@ -98,6 +98,10 @@
  */
 
 /*
+ * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
+ */
+
+/*
  * 1998/05/07 -- Russell King -- More portability cleanups; moved definition of
  * interrupt and dma channel to asm/floppy.h. Cleaned up some formatting &
  * use of '0' for NULL.
@@ -159,10 +163,6 @@ static int print_unex = 1;
 #define FDPATCHES
 #include <linux/fdreg.h>
 
-/*
- * 1998/1/21 -- Richard Gooch <rgooch@atnf.csiro.au> -- devfs support
- */
-
 #include <linux/fd.h>
 #include <linux/hdreg.h>
 
_
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

