Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbULGToJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbULGToJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 14:44:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbULGTnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 14:43:04 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:47371 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261911AbULGTfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 14:35:43 -0500
Date: Tue, 7 Dec 2004 20:35:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Vasya Pupkin <ptushnik@gmail.com>, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kernel/timer.c comment typo
Message-ID: <20041207193535.GH7250@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The trivial typo fix by Vasya Pupkin forwarded below still applies 
against 2.6.10-rc2-mm4.

Please apply.

----- Forwarded message from Vasya Pupkin <ptushnik@gmail.com> -----

Date:	Sat, 30 Oct 2004 22:46:08 +0400
From: Vasya Pupkin <ptushnik@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] comment typo

Signed-off-by: Vasia Pupkin <ptushnik@gmail.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.9/kernel/timer.c.orig     2004-10-30 22:41:14.000000000 +0400
+++ linux-2.6.9/kernel/timer.c  2004-10-30 22:41:52.000000000 +0400
@@ -654,7 +654,7 @@
 /* 
  * The current time 
  * wall_to_monotonic is what we need to add to xtime (or xtime corrected 
- * for sub jiffie times) to get to monotonic time.  Monotonic is pegged at zero
+ * for sub jiffie times) to get to monotonic time.  Monotonic is pegged
  * at zero at system boot time, so wall_to_monotonic will be negative,
  * however, we will ALWAYS keep the tv_nsec part positive so we can use
  * the usual normalization.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

