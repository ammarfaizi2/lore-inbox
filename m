Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUECC1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUECC1S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbUECC1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:27:18 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:41890 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263540AbUECC1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:27:14 -0400
Subject: [PATCH] Numdimmies MUST DIE!
From: Rusty Russell <rusty@rustcorp.com.au>
To: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1083551201.25582.149.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 03 May 2004 12:26:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Status: Vitally Important

I'm sure this is violating the trademark of a pre-schooler's TV show
somewhere in the world.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18765-linux-2.6.6-rc3-bk4/drivers/net/dummy.c .18765-linux-2.6.6-rc3-bk4.updated/drivers/net/dummy.c
--- .18765-linux-2.6.6-rc3-bk4/drivers/net/dummy.c	2004-04-29 17:29:43.000000000 +1000
+++ .18765-linux-2.6.6-rc3-bk4.updated/drivers/net/dummy.c	2004-05-03 12:25:11.000000000 +1000
@@ -104,7 +104,7 @@ static struct net_device **dummies;
 
 /* Number of dummy devices to be set up by this module. */
 module_param(numdummies, int, 0);
-MODULE_PARM_DESC(numdimmies, "Number of dummy psuedo devices");
+MODULE_PARM_DESC(numdummies, "Number of dummy psuedo devices");
 
 static int __init dummy_init_one(int index)
 {

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

