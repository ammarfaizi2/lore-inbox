Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751816AbWCOLrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbWCOLrl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 06:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWCOLrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 06:47:41 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:27057 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751816AbWCOLrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 06:47:40 -0500
Date: Wed, 15 Mar 2006 12:45:10 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>,
       Esben Nielsen <simlo@phys.au.dk>, Jan Altenberg <tb10alj@tglx.de>,
       Hugh Dickins <hugh@veritas.com>, Lee Revell <rlrevell@joe-job.com>,
       karsten wiese <annabellesgarden@yahoo.de>
Subject: 2.6.16-rc6-rt4
Message-ID: <20060315114510.GA32276@elte.hu>
References: <20060314084658.GA28947@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314084658.GA28947@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i have released the 2.6.16-rc6-rt4 tree, which can be downloaded from 
the usual place:

   http://redhat.com/~mingo/realtime-preempt/

this too is a fixes-only release. Changes since -rt3:

 - PI boosting fixes (Thomas Gleixner, found by Esben Nielsen)

 - task-exit latency breaker for !PREEMPT_RT preemption modes
   (Hugh Dickins, reported by Lee Revell)

 - SLAB fixes (based on Karsten Wiese's patch)

the SLAB fix might solve the USB problems reported by many.

to build a 2.6.16-rc6-rt4 tree, the following patches should be applied:

  http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.15.tar.bz2
  http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.16-rc6.bz2
  http://redhat.com/~mingo/realtime-preempt/patch-2.6.16-rc6-rt4

	Ingo
