Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262334AbULMUXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262334AbULMUXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 15:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbULMUS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 15:18:59 -0500
Received: from gprs215-194.eurotel.cz ([160.218.215.194]:43392 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261334AbULMUQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 15:16:19 -0500
Date: Mon, 13 Dec 2004 21:15:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: fix naming in swsusp
Message-ID: <20041213201523.GA4613@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

At few points we still reference to swsusp as "pmdisk"... it might
confuse someone not knowing full history. Please apply,
								Pavel

--- clean/kernel/power/swsusp.c	2004-10-19 14:16:29.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-12-12 21:14:03.000000000 +0100
@@ -1202,7 +1190,7 @@
 }
 
 /**
- *	pmdisk_read - Read saved image from swap.
+ *	swsusp_read - Read saved image from swap.
  */
 
 int __init swsusp_read(void)
@@ -1226,6 +1214,6 @@
 	if (!error)
 		pr_debug("Reading resume file was successful\n");
 	else
-		pr_debug("pmdisk: Error %d resuming\n", error);
+		pr_debug("swsusp: Error %d resuming\n", error);
 	return error;
 }

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
