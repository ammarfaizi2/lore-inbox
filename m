Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279580AbRJXTZX>; Wed, 24 Oct 2001 15:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279577AbRJXTZM>; Wed, 24 Oct 2001 15:25:12 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:16602 "EHLO snfc21.pbi.net")
	by vger.kernel.org with ESMTP id <S279573AbRJXTZC>;
	Wed, 24 Oct 2001 15:25:02 -0400
Date: Wed, 24 Oct 2001 12:25:36 -0700 (PDT)
From: Chris Rankin <rankinc@pacbell.net>
Subject: [PATCH] MODULE_LICENSE for loop device
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Message-id: <200110241925.f9OJPaOw001568@twopit.underworld>
MIME-version: 1.0
X-Mailer: ELM [version 2.5 PL6]
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a totally trivial patch (against 2.4.13) to give the loop
device a MODULE_LICENSE tag.

Cheers,
Chris

--- drivers/block/loop.c.orig	Wed Oct 24 01:03:59 2001
+++ drivers/block/loop.c	Wed Oct 24 12:23:34 2001
@@ -951,6 +951,7 @@
  */
 MODULE_PARM(max_loop, "i");
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices (1-255)");
+MODULE_LICENSE("GPL");
 
 int loop_register_transfer(struct loop_func_table *funcs)
 {
