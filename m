Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751946AbWCPJ6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbWCPJ6r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 04:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752023AbWCPJ6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 04:58:47 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:25027 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751946AbWCPJ6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 04:58:47 -0500
Date: Thu, 16 Mar 2006 10:56:08 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       Lee Revell <rlrevell@joe-job.com>
Subject: 2.6.16-rc6-rt7
Message-ID: <20060316095607.GA28571@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4983]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.16-rc6-rt7 tree, which can be downloaded from 
the usual place:

   http://redhat.com/~mingo/realtime-preempt/

the main change in this release is the merge up to John Stultz's GTOD 
-B20 patchset, and Thomas Gleixner's latest -hrt (high resolution 
timers) queue. This, amongst many other fixes, resolves a system-time 
(and uptime) anomaly observable under high load.

Changes since -rt4:

 - merge to John Stultz's GTOD -B20 (Thomas Gleixner)

 - merge to latest -hrt (Thomas Gleixner)

 - zap_pte_range() latency breaker (Hugh Dickins)

 - small latency tracer cleanups

to build a 2.6.16-rc6-rt7 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.16-rc6.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.16-rc6-rt7

	Ingo
