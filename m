Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272563AbTG1BC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272562AbTG1AD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:03:57 -0400
Received: from zeus.kernel.org ([204.152.189.113]:28659 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272720AbTG0W6Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 18:58:16 -0400
Date: Sun, 27 Jul 2003 21:17:28 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272017.h6RKHS7j029743@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: fix binfmt_flat typos
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Steven Cole)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/fs/binfmt_flat.c linux-2.6.0-test2-ac1/fs/binfmt_flat.c
--- linux-2.6.0-test2/fs/binfmt_flat.c	2003-07-10 21:03:33.000000000 +0100
+++ linux-2.6.0-test2-ac1/fs/binfmt_flat.c	2003-07-23 16:39:58.000000000 +0100
@@ -501,7 +501,7 @@
 	extra = max(bss_len + stack_len, relocs * sizeof(unsigned long));
 
 	/*
-	 * there are a couple of cases here,  the seperate code/data
+	 * there are a couple of cases here,  the separate code/data
 	 * case,  and then the fully copied to RAM case which lumps
 	 * it all together.
 	 */
