Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272121AbTG1CnM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 22:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272315AbTG1CnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 22:43:12 -0400
Received: from [129.187.202.12] ([129.187.202.12]:18939 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S272121AbTG1CnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 22:43:10 -0400
Date: Mon, 28 Jul 2003 04:58:12 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: dm@uk.sistina.com
Cc: linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: [2.6 patch] remove #include blk.h in dm-ioctl-v{1,4}.c
Message-ID: <20030728025811.GI22218@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below removed two #include's of the obsolete blk.h.

I've tested the compilation with 2.6.0-test2.

Please apply
Adrian

--- linux-2.6.0-test2-full-no-smp/drivers/md/dm-ioctl-v1.c.tmp	2003-07-28 04:50:45.000000000 +0200
+++ linux-2.6.0-test2-full-no-smp/drivers/md/dm-ioctl-v1.c	2003-07-28 04:51:13.000000000 +0200
@@ -12,7 +12,6 @@
 #include <linux/dm-ioctl.h>
 #include <linux/init.h>
 #include <linux/wait.h>
-#include <linux/blk.h>
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 
--- linux-2.6.0-test2-full-no-smp/drivers/md/dm-ioctl-v4.c.tmp	2003-07-28 04:51:20.000000000 +0200
+++ linux-2.6.0-test2-full-no-smp/drivers/md/dm-ioctl-v4.c	2003-07-28 04:51:30.000000000 +0200
@@ -11,7 +11,6 @@
 #include <linux/miscdevice.h>
 #include <linux/init.h>
 #include <linux/wait.h>
-#include <linux/blk.h>
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 
