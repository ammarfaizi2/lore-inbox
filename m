Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWDHH2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWDHH2M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 03:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWDHH2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 03:28:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:62385 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751393AbWDHH2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 03:28:12 -0400
Date: Sat, 8 Apr 2006 09:25:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
Message-ID: <20060408072530.GA14364@elte.hu>
References: <200604052025.05679.darren@dvhart.com> <20060407091946.GA28421@elte.hu> <20060407103926.GC11706@gnuppy.monkey.org> <200604070756.21625.darren@dvhart.com> <20060407210633.GA15971@gnuppy.monkey.org> <20060408071657.GA11660@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060408071657.GA11660@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> * Bill Huey <billh@gnuppy.monkey.org> wrote:
> 
> > I'm quite aware of what you're saying as well as a much of the 
> > contents of the -rt patch. Please don't assume that I'm not aware of 
> > this. The -rt patch doesn't do SWSRPS, [...]
> 
> to the contrary, the "RT overload" code in the -rt tree does strict, 
> system-wide RT priority scheduling. That's the whole point of it.

so after this "clarification of terminology" i hope you are in picture 
now, so could you please explain to me what you meant by:

> > You should consider for a moment to allow for the binding of a 
> > thread to a CPU to determine the behavior of a SCHED_FIFO class task 
> > instead of creating a new run category. [...]

to me it still makes no sense, and much of the followups were based on 
this. Or were you simply confused about what the scheduling code in -rt 
does precisely? Did that get clarified now?

	Ingo
