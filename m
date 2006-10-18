Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWJRIrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWJRIrR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWJRIrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:47:17 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:3461 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932121AbWJRIrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:47:16 -0400
Date: Wed, 18 Oct 2006 10:39:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net,
       Lee Revell <rlrevell@joe-job.com>
Subject: 2.6.18-rt6
Message-ID: <20061018083921.GA10993@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've released the 2.6.18-rt6 tree, which can be downloaded from the 
usual place:

  http://redhat.com/~mingo/realtime-preempt/

this is a fixes-mostly release. Changes since -rt4:

 - fix for module loading / symbol table crash (John Stultz)
 - scheduler fix (Mike Galbraith)
 - fix x86_64 NMI watchdog & preempt-rcu interaction
 - fix time-warp false positives
 - jiffies_to_timespec export fix (Steven Rostedt)
 - ll_rw_block.c warning fix (Mike Galbraith)
 - PPC updates (Daniel Walker)
 - MIPS updates (Manish Lachwani)
 - ARM oprofile fix (Kevin Hilman)
 - traditional futexes queued via plists (Séstien Duguése)
 - (various other smaller fixes)

to build a 2.6.18-rt6 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.18.tar.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.18-rt6

as usual, bugreports, fixes and suggestions are welcome,

	Ingo
