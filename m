Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWHaMcx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWHaMcx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 08:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWHaMcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 08:32:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46311 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750720AbWHaMcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 08:32:52 -0400
Date: Thu, 31 Aug 2006 14:32:41 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: kernel/stop_machine.c: whose code is it?
Message-ID: <20060831123241.GB3923@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Would kernel/stop_machine.c author please step up?

Signed-off-by: Pavel Machek <pavel@suse.cz>

(but I guess it would be better if author added signature to his work)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 51cacd1..ec0592c 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -1,3 +1,9 @@
+/*
+ * Copyright A.N.Onymous
+ *
+ * GPLv2
+ */
+
 #include <linux/stop_machine.h>
 #include <linux/kthread.h>
 #include <linux/sched.h>
@@ -132,8 +138,7 @@ static void restart_machine(void)
 	preempt_enable_no_resched();
 }
 
-struct stop_machine_data
-{
+struct stop_machine_data {
 	int (*fn)(void *);
 	void *data;
 	struct completion done;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
