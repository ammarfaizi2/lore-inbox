Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUBQEhA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 23:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUBQEg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 23:36:59 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:29967 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265973AbUBQEg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 23:36:59 -0500
Date: Tue, 17 Feb 2004 04:36:56 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: small fbmem.c fix.
Message-ID: <Pine.LNX.4.44.0402170435070.24924-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The platinum framebuffer is repeated twice. Removed one of them.


--- fbmem.c	2004-02-16 00:50:15.000000000 -0800
+++ fbmem.c.new	2004-02-16 04:42:15.000000000 -0800
@@ -107,8 +107,6 @@
 extern int platinumfb_setup(char*);
 extern int control_init(void);
 extern int control_setup(char*);
-extern int platinum_init(void);
-extern int platinum_setup(char*);
 extern int valkyriefb_init(void);
 extern int valkyriefb_setup(char*);
 extern int chips_init(void);
r

