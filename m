Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbULKPzv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbULKPzv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 10:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbULKPzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 10:55:50 -0500
Received: from gprs215-225.eurotel.cz ([160.218.215.225]:1923 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261956AbULKPzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 10:55:44 -0500
Date: Sat, 11 Dec 2004 16:55:33 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: fix types
Message-ID: <20041211155533.GA1952@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes types so that sparse has less stuff to complain
about. Please apply,
							Pavel

--- clean/kernel/power/disk.c	29 Oct 2004 20:20:47 -0000	1.10
+++ linux/kernel/power/disk.c	11 Dec 2004 15:51:13 -0000
@@ -43,7 +43,7 @@
  *	there ain't no turning back.
  */
 
-static void power_down(u32 mode)
+static void power_down(suspend_disk_method_t mode)
 {
 	unsigned long flags;
 	int error = 0;
 

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
