Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272324AbTG3XDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272327AbTG3XDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:03:05 -0400
Received: from mail.ccur.com ([208.248.32.212]:30225 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S272324AbTG3XDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:03:01 -0400
Date: Wed, 30 Jul 2003 19:02:54 -0400
From: Joe Korty <joe.korty@ccur.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] nonbug: PF_LESS_THROTTLE
Message-ID: <20030730230253.GA15044@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Although the value that PF_LESS_THROTTLE has does work, it may not be
the value that was intended for it.

Joe



--- linux-2.6.0-test2/include/linux/sched.h.orig	2003-07-27 12:57:39.000000000 -0400
+++ linux-2.6.0-test2/include/linux/sched.h	2003-07-30 18:52:42.000000000 -0400
@@ -485,7 +485,7 @@
 #define PF_FSTRANS	0x00020000	/* inside a filesystem transaction */
 #define PF_KSWAPD	0x00040000	/* I am kswapd */
 #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
-#define PF_LESS_THROTTLE 0x01000000	/* Throttle me less: I clena memory */
+#define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clena memory */
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_READAHEAD	0x00400000	/* I am doing read-ahead */
 
