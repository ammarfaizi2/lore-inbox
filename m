Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSLZDC0>; Wed, 25 Dec 2002 22:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbSLZDCZ>; Wed, 25 Dec 2002 22:02:25 -0500
Received: from user-24-214-12-221.knology.net ([24.214.12.221]:23995 "EHLO
	localdomain") by vger.kernel.org with ESMTP id <S261874AbSLZDCW> convert rfc822-to-8bit;
	Wed, 25 Dec 2002 22:02:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ro0tSiEgE <lkml@ro0tsiege.org>
Subject: Re: CPU failures ... or something else ?
Date: Wed, 25 Dec 2002 21:13:50 -0600
User-Agent: KMail/1.4.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212252113.50757.lkml@ro0tsiege.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I never said that. A bad CPU would be my last guess. My first two are buggy
board (use nomce) or bad addresses in your ram. try running Memtest86
(http://www.memtest86.com) for a few minutes and see if you get any errors.

On Wednesday 25 December 2002 21:04, you wrote:
> So you are saying, that yes, it _is_ possible that my equipment is not
> faulty in any way ?
>
> thanks!
>
> On Wed, 25 Dec 2002, Bubba wrote:
> > try turning off the Machine Check Exception in the kernel as it is just
> > buggy on some machines, not necessarily a bug in the kernel, or without
> > recompiling, use the kernel param "nomce"
> >
> > On Wednesday 25 December 2002 19:53, Josh Brooks wrote:
> > > Hello,
> > >
> > > I have a dual p3 866 running 2.4 kernel that is crashing once every few
> > > days leaving this on the console:
> > >
> > >
> > > Message from syslogd@localhost at Tue Dec 24 11:30:31 2002 ...
> > > localhost kernel: CPU 1: Machine Check Exception: 0000000000000004
> > >
> > > Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
> > > localhost kernel: Bank 4: b200000000040151
> > >
> > > Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
> > > localhost kernel: Kernel panic: CPU context corrupt
> > >
> > >
> > >
> > > Word on the street is that this indicates hardware failure of some kind
> > > (cpu, bus, or memory).  My main question is, is that very surely the
> > > culprit, or is it also possible that all of the hardware is perfect and
> > > that a bug in the kernel code or some outside influence (remote
> > > exploit) is causing this crash ?
> > >
> > > Basically, I am ordering all new hardware to swap out, and I just want
> > > to know if there is some remote possibility that my hardware is
> > > actually just fine and this is some kind of software error ?
> > >
> > > ALSO, I have not been physically at the console when this has happened,
> > > and have not tried this yet, but whatever that thing is where you press
> > > ctrl-alt-printscreen and get to enter those post-crash commands - do
> > > you think that would work in this situation, or does the above error
> > > hard lock the system so you can't do those emergency measures ?
> > >
> > > thanks!
> > >
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

-------------------------------------------------------


