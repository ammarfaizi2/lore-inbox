Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264819AbUEYJRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264819AbUEYJRX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 05:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264824AbUEYJRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 05:17:23 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36487 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264819AbUEYJRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 05:17:22 -0400
Date: Tue, 25 May 2004 13:18:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Christian Meder <chris@onestepahead.de>
Subject: [patch] sched.h comment typo fix, BK-curr
Message-ID: <20040525111841.GA6001@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


sched.h typo fix from Christian Meder.

	Ingo

Signed-off-by: Christian Meder <chris@onestepahead.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/include/linux/sched.h.orig
+++ linux/include/linux/sched.h
@@ -301,7 +301,7 @@
  * in the range MAX_RT_PRIO..MAX_PRIO-1. Priority values
  * are inverted: lower p->prio value means higher priority.
  *
- * The MAX_RT_USER_PRIO value allows the actual maximum
+ * The MAX_USER_RT_PRIO value allows the actual maximum
  * RT priority to be separate from the value exported to
  * user-space.  This allows kernel threads to set their
  * priority to a value higher than any user task. Note:
