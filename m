Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281808AbRLBVJT>; Sun, 2 Dec 2001 16:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276369AbRLBVJH>; Sun, 2 Dec 2001 16:09:07 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:6148 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S281743AbRLBVJC>; Sun, 2 Dec 2001 16:09:02 -0500
Date: Sun, 2 Dec 2001 13:19:43 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Larry McVoy <lm@bitmover.com>
cc: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
In-Reply-To: <20011202122940.B2622@work.bitmover.com>
Message-ID: <Pine.LNX.4.40.0112021303070.7375-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Dec 2001, Larry McVoy wrote:

> On Sat, Dec 01, 2001 at 08:05:59PM -0300, Horst von Brand wrote:
> > Larry McVoy <lm@bitmover.com> said:
> >
> > [...]
> >
> > > Because, just like the prevailing wisdom in the Linux hackers, they thought
> > > it would be relatively straightforward to get SMP to work.  They started at
> > > 2, went to 4, etc., etc.  Noone ever asked them to go from 1 to 100 in one
> > > shot.  It was always incremental.
> >
> > Maybe that is because 128 CPU machines aren't exactly common... just as
> > SPARC, m68k, S/390 development lags behind ia32 just because there are
> > many, many more of the later around.
> >
> > Just as Linus said, the development is shaped by its environment.
>
> Really?  So then people should be designing for 128 CPU machines, right?
> So why is it that 100% of the SMP patches are incremental?  Linux is
> following exactly the same path taken by every other OS, 1->2, then 2->4,
> then 4->8, etc.  By your logic, someone should be sitting down and saying
> here is how you get to 128.  Other than myself, noone is doing that and
> I'm not really a Linux kernel hack, so I don't count.
>
> So why is it that the development is just doing what has been done before?

That's exactly the Linus point: no long term preventive design.
That means short term design on what we actually have or on what we can
think available in a very near future.
Because, again, if you start designing now an SMP solution for 128 CPUs,
you're going to model it on the current technology that won't probably fit
in future SMP architectures and you'll be screwed up.
There should be a reason why software evolves in this way, think about it.
Either everyone else is fool or you're the prophet.
And if you're the prophet and you think that the future of multiprocessing
is UP on clusters, why instead of spreading your word between us poor
kernel fans don't you pull out money from your pocket ( or investors ) and
start a new Co. that will have that solution has primary and unique goal ?
You could be the J.C. Maxwell of the next century.



- Davide


