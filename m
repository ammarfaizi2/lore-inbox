Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267546AbTBJBiR>; Sun, 9 Feb 2003 20:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267500AbTBJBhD>; Sun, 9 Feb 2003 20:37:03 -0500
Received: from dp.samba.org ([66.70.73.150]:44973 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267505AbTBJBg4>;
	Sun, 9 Feb 2003 20:36:56 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] fix comment in module.c in 2.5.59
Date: Mon, 10 Feb 2003 12:35:29 +1100
Message-Id: <20030210014641.3018D2C0F0@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  John Levon <levon@movementarian.org>

  
  

--- trivial-2.5.59-bk3/kernel/module.c.orig	2003-02-10 12:29:51.000000000 +1100
+++ trivial-2.5.59-bk3/kernel/module.c	2003-02-10 12:29:51.000000000 +1100
@@ -1551,7 +1551,7 @@
 	return 0;
 }
 
-/* Format: modulename size refcount deps
+/* Format: modulename size refcount deps address
 
    Where refcount is a number or -, and deps is a comma-separated list
    of depends or -.
-- 
  Don't blame me: the Monkey is driving
  File: John Levon <levon@movementarian.org>: [PATCH] fix comment in module.c in 2.5.59
