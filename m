Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVHNCM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVHNCM2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 22:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVHNCM2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 22:12:28 -0400
Received: from mx2.elte.hu ([157.181.151.9]:30637 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932417AbVHNCM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 22:12:27 -0400
Date: Sun, 14 Aug 2005 04:12:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: George Anzinger <george@mvista.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Ryan Brown <some.nzguy@gmail.com>,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High Resolution Timers & RCU-tasklist features
Message-ID: <20050814021258.GA25877@elte.hu>
References: <20050811110051.GA20872@elte.hu> <1c1c8636050812172817b14384@mail.gmail.com> <1123893158.12680.70.camel@mindpipe> <42FD4593.9030702@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42FD4593.9030702@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=none autolearn=disabled SpamAssassin version=3.0.4
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* George Anzinger <george@mvista.com> wrote:

> Ingo, all
> 
> I, silly person that I am, configured an RT, SMP, PREEMPT_DEBUG system. 
>  Someone put code in the NMI path to modify the preempt count which, 
> often as not will generate a PREEMPT_DEBUG message as there is no tell 
> what state the preempt count is in on an NMI interrupt.  I have sent 
> the attached patch to Andrew on this, but meanwhile, if you want RT, 
> SMP, PREEMPT_DEBUG you will be much better off with this.

ah - thanks, applied. Might explain some of the recent SMP weirdnesses 
i'm seeing. Attributed them to the HRT patch ;-)

	Ingo
