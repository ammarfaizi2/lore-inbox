Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbVJ3Plp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbVJ3Plp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 10:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbVJ3Plp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 10:41:45 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:2299 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750957AbVJ3Plp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 10:41:45 -0500
Date: Sun, 30 Oct 2005 10:41:21 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: "K.R. Foley" <kr@cybsft.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>, john stultz <johnstul@us.ibm.com>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: 2.6.14-rt1
In-Reply-To: <4364DFA5.3000109@cybsft.com>
Message-ID: <Pine.LNX.4.58.0510301037520.2819@localhost.localdomain>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu>
 <20051030133316.GA11225@elte.hu> <4364DFA5.3000109@cybsft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Oct 2005, K.R. Foley wrote:

> Ingo Molnar wrote:
> >
> > Please re-report any bugs that remain.
> >
> > Changes since 2.6.14-rc5-rt1:
> >
> >  - GTOD -B9 (John Stultz)
> >
> >  - ktimer updates (Thomas Gleixner, me)
> >
> >  - ktimer debugging check fixes (Steven Rostedt)
> >
> >  - smarter TSC synchronization on SMP - we now rely on it for nsecs (me)
> >
> >  - x64 build fix (reported by Mark Knecht)
> >
> >  - tracing fix (reported by Florian Schmidt)
> >
> >  - rtc histogram fixes (K.R. Foley)
>
> Actually it doesn't look like these made it into the patch. :)

Yeah, I noticed that there isn't even a check anymore in
get_monotonic_clock_ts for time warping backwards.  I guess John's new
updates and Ingo's "smarter" code makes it unnecessary ;-)

Still, thanks for the credit Ingo!

-- Steve


>
> >
> >  - merge to 2.6.14
> >
