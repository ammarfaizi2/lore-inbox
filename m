Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTGKRxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 13:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264683AbTGKRwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 13:52:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:65411
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264666AbTGKRvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 13:51:14 -0400
Date: Fri, 11 Jul 2003 19:05:02 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307111805.h6BI52XX017218@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: dtlk comment fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.75/drivers/char/dtlk.c linux-2.5.75-ac1/drivers/char/dtlk.c
--- linux-2.5.75/drivers/char/dtlk.c	2003-07-10 21:08:25.000000000 +0100
+++ linux-2.5.75-ac1/drivers/char/dtlk.c	2003-07-11 14:34:28.000000000 +0100
@@ -55,7 +55,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>		/* for verify_area */
 #include <linux/errno.h>	/* for -EBUSY */
-#include <linux/ioport.h>	/* for check_region, request_region */
+#include <linux/ioport.h>	/* for request_region */
 #include <linux/delay.h>	/* for loops_per_jiffy */
 #include <asm/io.h>		/* for inb_p, outb_p, inb, outb, etc. */
 #include <asm/uaccess.h>	/* for get_user, etc. */
