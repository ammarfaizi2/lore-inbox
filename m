Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVFMU0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFMU0M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbVFMUW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:22:57 -0400
Received: from mail.dif.dk ([193.138.115.101]:62954 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261165AbVFMUVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:21:05 -0400
Date: Mon, 13 Jun 2005 22:26:23 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] add note about verify_area removal to
 Documentation/feature-removal-schedule.txt
Message-ID: <Pine.LNX.4.62.0506132221380.2555@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add note about the soon-to-come removal of verify_area() to 
Documentation/feature-removal-schedule.txt, so it can be clearly 
deprecated *and* documented to go away real-soon-now in 2.6.12 (if there's 
time to push it to Linus before 2.6.12 hits).

This was already in -mm earlier, but some duplicate patch submission 
(error on my part) caused it to be messed up and then removed.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 Documentation/feature-removal-schedule.txt |    8 ++++++++
 1 files changed, 8 insertions(+)

--- linux-2.6.12-rc6-mm1-orig/Documentation/feature-removal-schedule.txt	2005-06-12 15:58:39.000000000 +0200
+++ linux-2.6.12-rc6-mm1/Documentation/feature-removal-schedule.txt	2005-06-13 22:20:30.000000000 +0200
@@ -100,3 +100,11 @@
 Files:	kernel/panic.c
 Why:	No modular usage in the kernel.
 Who:	Adrian Bunk <bunk@stusta.de>
+
+---------------------------
+
+What:	remove verify_area()
+When:	July 2006
+Files:	Various uaccess.h headers.
+Why:	Deprecated and redundant. access_ok() should be used instead.
+Who:	Jesper Juhl <juhl-lkml@dif.dk>



