Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVC0I6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVC0I6f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 03:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbVC0I6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 03:58:35 -0500
Received: from mx1.elte.hu ([157.181.1.137]:20679 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261480AbVC0I60 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 03:58:26 -0500
Date: Sun, 27 Mar 2005 10:58:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-10
Message-ID: <20050327085814.GA23082@elte.hu>
References: <20050325145908.GA7146@elte.hu> <1111790009.23430.19.camel@mindpipe> <20050325223959.GA24800@elte.hu> <1111814065.24049.21.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111814065.24049.21.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Running for several days with PREEMPT_DESKTOP, on the Athlon XP the 
> worst latency I am seeing is ~150 usecs!  But on the C3 its about 4ms:

could you run a bit with tracing disabled (in the .config) on the C3?  
(but wakeup timing still enabled) It may very well be tracing overhead 
that makes those latencies that high.  Also, we'd thus have some hard 
data on how much overhead tracing is in such a situation, on that CPU.

	Ingo
