Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVJQH7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVJQH7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 03:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbVJQH7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 03:59:34 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:46533 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932173AbVJQH7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 03:59:34 -0400
Date: Mon, 17 Oct 2005 09:59:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, George Anzinger <george@mvista.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       johnstul@us.ibm.com, paulmck@us.ibm.com,
       Christoph Hellwig <hch@infradead.org>, oleg@tv-sign.ru,
       tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
Message-ID: <20051017075917.GA4827@elte.hu>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509301825290.3728@scrub.home> <1128168344.15115.496.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510100213480.3728@scrub.home> <1129016558.1728.285.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com> <Pine.LNX.4.61.0510150143500.1386@scrub.home> <1129490809.1728.874.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0510170021050.1386@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0510170021050.1386@scrub.home>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Roman Zippel <zippel@linux-m68k.org> wrote:

> > > The spec is not really clear and Thomas refusal to explain his design 
> > > decision is as also not really helpful. :-(
> > 
> > I did explain, why I did the rounding in the way it is implemented. If
> > you define the fact that I have a different interpretation of SUS than
> > you as refusal, then we can stop this thread right here.
> 
> I have no problem with you having a different opinion, I have a problem 
> with your childish behaviour. :-(

Roman, IMO Thomas has been more than reasonable in replying to you - i'd 
have stopped replying to you after the first couple of mails, and we are 
at mail round 10 now! Thomas is being very patient with you. You are 
being difficult, and IMO you are wasting his and others' time.

the thing is that Thomas has advanced the whole issue of timeouts and 
timekeeping by leaps and bounds and he has written thousands of lines of 
new and excellent code for a kernel subsystem that has seen little 
activity for many years, before John got involved. One of Thomas' 
accomplishments is a timer/time design that allows the enabling of HRT 
timers via an _18 lines_ architecture patch. (!)

on the other hand, i have yet to see a single line of code from you and 
have yet to receive a single bugreport from you. (!)

so for me as a patch integrator and upstream maintainer the equation is 
very simple, and i am not nearly as tolerant as Thomas: shut up Roman 
already and show us the code!

really, start sending in patches. Testreports. Useful feedback. Those we 
can judge by their merits. Talk is cheap. The time subsystem has been 
dormant for years, and it has had more than enough talk already.

the moment you express yourself via patches we'll know that 1) you 
understand what we have done so far 2) you have useful ideas of what 
should be done differently 3) you have the coder capability to implement 
and test those ideas. Patches wont be ignored, i can assure you. Get the 
patches rolling!

	Ingo
