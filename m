Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264005AbUCZJj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 04:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263984AbUCZJj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 04:39:28 -0500
Received: from gprs214-219.eurotel.cz ([160.218.214.219]:896 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264121AbUCZJjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 04:39:24 -0500
Date: Fri, 26 Mar 2004 01:11:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: B.Zolnierkiewicz@elka.pw.edu.pl,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Kill IDE debug messages during suspend
Message-ID: <20040326001154.GA3353@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Suspend/resume support in ide seems to work okay these days, so this
should be applied...
								Pavel

--- clean/include/linux/ide.h	2004-03-11 18:11:23.000000000 +0100
+++ linux/include/linux/ide.h	2004-03-26 01:08:28.000000000 +0100
@@ -24,8 +24,6 @@
 #include <asm/io.h>
 #include <asm/semaphore.h>
 
-#define DEBUG_PM
-
 /*
  * This is the multiple IDE interface driver, as evolved from hd.c.
  * It supports up to four IDE interfaces, on one or more IRQs (usually 14 & 15).

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
