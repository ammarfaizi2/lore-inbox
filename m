Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266078AbTAFED3>; Sun, 5 Jan 2003 23:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266043AbTAFEDZ>; Sun, 5 Jan 2003 23:03:25 -0500
Received: from dp.samba.org ([66.70.73.150]:42976 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266069AbTAFEDO>;
	Sun, 5 Jan 2003 23:03:14 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Remove unused prototype for init_modules()
Date: Mon, 06 Jan 2003 14:49:18 +1100
Message-Id: <20030106041151.737572C29D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Geert Uytterhoeven <geert@linux-m68k.org>

  
  Remove unused prototype for init_modules()
  

--- trivial-2.5-bk/init/main.c.orig	2003-01-06 14:08:49.000000000 +1100
+++ trivial-2.5-bk/init/main.c	2003-01-06 14:08:49.000000000 +1100
@@ -58,7 +58,6 @@
 static int init(void *);
 
 extern void init_IRQ(void);
-extern void init_modules(void);
 extern void sock_init(void);
 extern void fork_init(unsigned long);
 extern void extable_init(void);
-- 
  Don't blame me: the Monkey is driving
  File: Geert Uytterhoeven <geert@linux-m68k.org>: [PATCH] Remove unused prototype for init_modules()
