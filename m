Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVHLDH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVHLDH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 23:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVHLDH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 23:07:27 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:22404 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750740AbVHLDH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 23:07:27 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.53-01, High
	Resolution Timers & RCU-tasklist features
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       george anzinger <george@mvista.com>
In-Reply-To: <20050811110051.GA20872@elte.hu>
References: <20050811110051.GA20872@elte.hu>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 23:07:24 -0400
Message-Id: <1123816044.4453.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 13:00 +0200, Ingo Molnar wrote:
> i have released the -53-01 Real-Time Preemption patch, which can be 
> downloaded from:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> there are two new features in this release, which justified the jump 
> from .52 to .53:
> 
>  - the inclusion of the High Resolution Timers patch, written by
>    George Anzinger, and ported/improved/cleaned-up by Thomas Gleixner.
> 

George,

Very nice to see this going in (via) the RT patch.

Can we get a real help text here:

Clock & Timer Selection
> 1. Legacy Timer Support (LEGACY_TIMER) (NEW)
  2. HPET Timer Support (HPET_TIMER)
  3. High Resolution Timer Support (HIGH_RES_TIMERS) (NEW)
choice[1-3?]: ?

You may have either HPET, High Resolution, or Legacy timer support.

This would be a great place to put some of your extensive docs about the
various timer sources and issues on x86.  I have always thought the HRT
docs were the best source on the net for this info, and I refer people
to it whenever someone has a question about timers on the linux audio
lists.

The docs for "High Resolution Timer clock source" are great.

Can we get more docs here:

HRT Softirg dynamic priority adjustment (HIGH_RES_TIMERS_DYN_PRIO) 
        ^^^ typo
[N/y/?] (NEW) ?

This option enables the dynamic priority adjustment of the
high resolution timer soft interrupt

No point documenting this one if it's expected to go away though.

Lee


