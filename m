Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274990AbTHRUgd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 16:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274969AbTHRUgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 16:36:32 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:35240 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S274990AbTHRUcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 16:32:54 -0400
Date: Mon, 18 Aug 2003 15:32:35 -0500
Subject: spelling fix
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
From: Hollis Blanchard <hollisb@us.ibm.com>
Content-Transfer-Encoding: 7bit
Message-Id: <19E73078-D1BB-11D7-B5CB-000A95A0560C@us.ibm.com>
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply. Especially since this message seems to be popping up a 
lot these days... :)

===== arch/i386/kernel/timers/timer_tsc.c 1.22 vs edited =====
--- 1.22/arch/i386/kernel/timers/timer_tsc.c	Thu Jul  3 19:52:12 2003
+++ edited/arch/i386/kernel/timers/timer_tsc.c	Mon Aug 18 08:46:24 2003
@@ -182,9 +182,9 @@
  	if (lost >= 2) {
  		jiffies += lost-1;

-		/* sanity check to ensure we're not always loosing ticks */
+		/* sanity check to ensure we're not always losing ticks */
  		if (lost_count++ > 100) {
-			printk(KERN_WARNING "Loosing too many ticks!\n");
+			printk(KERN_WARNING "Losing too many ticks!\n");
  			printk(KERN_WARNING "TSC cannot be used as a timesource."
  					" (Are you running with SpeedStep?)\n");
  			printk(KERN_WARNING "Falling back to a sane timesource.\n");

-- 
Hollis Blanchard
IBM Linux Technology Center

