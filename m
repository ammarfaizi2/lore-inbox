Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbVKPGPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbVKPGPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 01:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVKPGPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 01:15:34 -0500
Received: from [218.25.172.144] ([218.25.172.144]:28435 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1751185AbVKPGPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 01:15:33 -0500
Date: Wed, 16 Nov 2005 14:15:25 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Jens Axboe <axboe@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] new block/ directory comment tidy
Message-ID: <20051116061525.GA3035@localhost.localdomain>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <20051113090156.GA4417@infradead.org> <20051113110517.GG3699@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051113110517.GG3699@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2005 at 12:05:18PM +0100, Jens Axboe wrote:
> On Sun, Nov 13 2005, Christoph Hellwig wrote:
> > Shouldn't fs/bio.c, fs/block_dev.c and fs/partitions/* move to block/
> > aswell?
> 
> Yup, that's the intention. I just started off with drivers/block/* to
> get it going.
 

New block/ directory comment tidy.

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---

 as-iosched.c       |    2 +-
 cfq-iosched.c      |    2 +-
 deadline-iosched.c |    2 +-
 elevator.c         |    2 +-
 ll_rw_blk.c        |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff -pruN 2.6.14-mm2/block/as-iosched.c 2.6.14-mm2-cy/block/as-iosched.c
--- 2.6.14-mm2/block/as-iosched.c	2005-11-11 16:50:55.000000000 +0800
+++ 2.6.14-mm2-cy/block/as-iosched.c	2005-11-16 14:05:43.000000000 +0800
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/block/as-iosched.c
+ *  linux/block/as-iosched.c
  *
  *  Anticipatory & deadline i/o scheduler.
  *
diff -pruN 2.6.14-mm2/block/cfq-iosched.c 2.6.14-mm2-cy/block/cfq-iosched.c
--- 2.6.14-mm2/block/cfq-iosched.c	2005-11-11 16:50:55.000000000 +0800
+++ 2.6.14-mm2-cy/block/cfq-iosched.c	2005-11-16 14:06:03.000000000 +0800
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/block/cfq-iosched.c
+ *  linux/block/cfq-iosched.c
  *
  *  CFQ, or complete fairness queueing, disk scheduler.
  *
diff -pruN 2.6.14-mm2/block/deadline-iosched.c 2.6.14-mm2-cy/block/deadline-iosched.c
--- 2.6.14-mm2/block/deadline-iosched.c	2005-11-11 16:50:55.000000000 +0800
+++ 2.6.14-mm2-cy/block/deadline-iosched.c	2005-11-16 14:06:28.000000000 +0800
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/block/deadline-iosched.c
+ *  linux/block/deadline-iosched.c
  *
  *  Deadline i/o scheduler.
  *
diff -pruN 2.6.14-mm2/block/elevator.c 2.6.14-mm2-cy/block/elevator.c
--- 2.6.14-mm2/block/elevator.c	2005-11-11 16:50:55.000000000 +0800
+++ 2.6.14-mm2-cy/block/elevator.c	2005-11-16 14:06:49.000000000 +0800
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/block/elevator.c
+ *  linux/block/elevator.c
  *
  *  Block device elevator/IO-scheduler.
  *
diff -pruN 2.6.14-mm2/block/ll_rw_blk.c 2.6.14-mm2-cy/block/ll_rw_blk.c
--- 2.6.14-mm2/block/ll_rw_blk.c	2005-11-11 16:50:55.000000000 +0800
+++ 2.6.14-mm2-cy/block/ll_rw_blk.c	2005-11-16 14:04:53.000000000 +0800
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/block/ll_rw_blk.c
+ *  linux/block/ll_rw_blk.c
  *
  * Copyright (C) 1991, 1992 Linus Torvalds
  * Copyright (C) 1994,      Karl Keyte: Added support for disk statistics
