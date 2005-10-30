Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVJ3PyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVJ3PyT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbVJ3PyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:54:18 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49422 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932165AbVJ3Pxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:53:42 -0500
Date: Sun, 30 Oct 2005 16:53:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/ioprio.c should #include <linux/syscalls.h>
Message-ID: <20051030155341.GE4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Every file should include the headers containing the prototypes for
it's global functions.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.14-rc5-mm1-full/fs/ioprio.c.old	2005-10-30 16:26:29.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/ioprio.c	2005-10-30 16:26:47.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/ioprio.h>
 #include <linux/blkdev.h>
+#include <linux/syscalls.h>
 
 static int set_task_ioprio(struct task_struct *task, int ioprio)
 {

