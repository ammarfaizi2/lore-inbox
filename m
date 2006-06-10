Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbWFJIYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbWFJIYt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 04:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWFJIYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 04:24:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:22662 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750795AbWFJIYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 04:24:48 -0400
Date: Sat, 10 Jun 2006 10:24:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Subject: 2.6.17-rc6-rt3
Message-ID: <20060610082406.GA31985@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5009]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.17-rc6-rt3 tree, which can be downloaded from 
the usual place:

   http://redhat.com/~mingo/realtime-preempt/

this is a fixes-only release: lots of fixes from Thomas Gleixner (for 
the softirq problem that caused those ping latency weirdnesses, for 
hrtimers and timers problems and for the RCU related bug that was 
causing instability and more), John Stultz, Jan Altenberg and Clark 
Williams. MIPS update from Manish Lachwani. Futex fix from Dinakar 
Guniguntala. It also includes the RT-scheduling SMP fix that could fix 
the scheduling problem reported by Darren Hart.

I think all of the regressions reported against rt1 are fixed, please 
re-report if any of them is still unfixed.

to build a 2.6.17-rc6-rt3 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.16.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.17-rc6.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.17-rc6-rt3

	Ingo
