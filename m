Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136329AbRAJVCR>; Wed, 10 Jan 2001 16:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136404AbRAJVCH>; Wed, 10 Jan 2001 16:02:07 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:7690 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S136348AbRAJVBv>;
	Wed, 10 Jan 2001 16:01:51 -0500
Date: Wed, 10 Jan 2001 22:02:14 +0100 (CET)
From: <kernel@ddx.a2000.nu>
To: Hacksaw <hacksaw@hacksaw.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: unexplained high load 
In-Reply-To: <200101102058.f0AKwGr00680@habitrail.home.fools-errant.com>
Message-ID: <Pine.LNX.4.30.0101102159470.4377-100000@ddx.a2000.nu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jan 2001, Hacksaw wrote:

> > Could someone maybe explain this ?
> > (top output, but same load is given with 'uptime')
> > there is no cpu or disk activity
> > kernel is 2.2.18pre9 on sun ultra10-300 (ultrasparc IIi)
> >
> >    9:25pm  up 112 days,  1:52,  1 user,  load average: 1.24, 1.05, 1.02
> >  91 processes: 90 sleeping, 1 running, 0 zombie, 0 stopped
> >  CPU states:  2.5% user,  2.3% system,  0.0% nice, 95.1% idle
> >  Mem:  515144K av, 506752K used,   8392K free,  73464K shrd,  58472K buff
> >  Swap: 131528K av,  15968K used, 115560K free                358904K cached
>
> You have no processes??? My gosh, that is a problem. :-)
91 processes, only 1 running (think top)

>
> The load average is how many processes are runnable, therefore you have
> runnable processes.
>
> If you have Netscape or Mozilla running on your box, it may be in a
> permanently runnable state.
it's a firewall/gateway/mail box, so no X or netscape

> Another amusing possibility is that you have a hacked box, and top is
> reporting the stupid IRC bot that is running, but not showing you the actuall
> process, because it too is hacked.
don't think
w,uptime,top give the same value

>
> Replace ps and top, and have a look. Don't believe ls, either.
>
> If none of these things are true, you might have another problem.
think this, but problem, machine is running ok
no slow response, only load 1.00 (it's not getting lower)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
