Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264629AbUDVSzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264629AbUDVSzb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 14:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264635AbUDVSzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 14:55:31 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9601 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264629AbUDVSz0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 14:55:26 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Charles Shannon Hendrix <shannon@widomaker.com>
Subject: Re: [somewhat OT] binary modules agaaaain
Date: Thu, 22 Apr 2004 20:55:04 +0200
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.33.0404191651300.1869-100000@pcgl.dsa-ac.de> <200404201611.07832.bzolnier@elka.pw.edu.pl> <20040422161957.GF16810@widomaker.com>
In-Reply-To: <20040422161957.GF16810@widomaker.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404222055.04834.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What did I say about moving this discussion from lkml? :-)
[ Well, it's my fault I shouldn't have replied. ]

This is my last mail on this subject with lkml cc:ed, sorry for noise.

On Thursday 22 of April 2004 18:19, Charles Shannon Hendrix wrote:
> Tue, 20 Apr 2004 @ 16:11 +0200, Bartlomiej Zolnierkiewicz said:
> > > A binary module is "considered good" if
> >
> > This is a false assumption IMO no binary only modules can be "good".
>
> True, but non-working hardware is even worse.

For who?  This is a tricky question. 8)

> > I think that binary modules are evil because:
> >
> > - they slow down development (indirectly - think about it)
>
> I don't think this is true at all.

Have you followed x86 4kb stacks discussion?

> > - some vendors claim Linux support
> >   while they only provide binary only modules
>
> If they provide a binary for Linux, then they can claim Linux support.
>
> We may not like it, but it is a legitimate claim.

No, they instead should claim support for specific distribution
and specific distribution versions (and some vendors do this).

> > - less informed users tend to put blame on kernel or distribution
> >   not the binary only module (!)
>
> True, but this is just noise in the signal in terms of what the less
> informed users think.
>
> > I'm not a fanatic :-), I can see good sides of binary only modules:
> >
> > - additional hardware and features is supported
> >
> > - wider usage of Linux
>
> - some driver code is tied up in legal issues that are not currently
>   solvable

They can often be solved with some effort (i.e. Intel WLAN driver).

> - For some hardware, only the company has enough knowledge to write
>   a decent driver.  I can't blame a company for wanting to control
>   the drivers for their hardware for quality reasons.

Use Windows then. ;-)  Most bugs (any OS) are *driver* bugs.

The whole thing is about you having control over hardware
(thus drivers) not hardware/software vendor.

Yes, this scares some people. :)

> - As a user, I need to get work done, not play politics with my
>   hardware.  I prefer open solutions, but each day I have work to
>   do and can't afford to play politics with my hardware.

And you are free to do this, just don't bring your problems on lkml
wasting my time.  Reproduce problem without binary modules,
if you can't then bring your problems to the authors of these modules
or pay somebody to debug+solve your problems.

"Linux is free but my time is not." (hi Andre)

> - I personally don't believe that building barriers to binary drives is
>   helpful.  In fact, I think it ultimately means *less* open source
>   from manufacturers.  I think of a good binary interface as a good
>   ambassador.

I'm not advocating artificial barriers.  I'm saying that IMO most kernel
developers have _zero_ interest in supporting such interfaces.

My point is that use/write/whatever binary only drivers if you like
but don't waste my and other people time if you have problems.

> > but I still think that cons > pros...
>
> Of course.  We live in a highly imperfect world, and the computer
> industry is among the most imperfect parts of it.
>
> At the same time, we need to make sure that in our posturing and
> political moves, we don't end up making things worse.

This list is for development not for politics.

I personally hate kernel politics and try to concentrate on kernel hacking.

> > > With this restrictions those "good" binary modules could be debugged,
> > > run in a sandbox... The question remains if anybody will want to debug
> > > them:-)
> >
> > In my opinion using binary only modules is equal to modifying your kernel
> > but being unable to show your modifications so you are on your own and
> > you shouldn't bring it on lkml.
>
> Sounds illogical to me.
>
> That's like saying that selling a turbocharger for a car is the same as
> illegally copying the design of a car and selling it as your own.

Sorry, I can't see how this two things are related.

I'm rather saying that if you buy a turbocharger (binary only module)
and modify your car you shouldn't expect car (kernel) producer to accept
your warranty claims.  [ and remember that you got kernel for free! ]

I think you agree with this :-).

By using binary only module you modify your kernel code (on runtime)
and I can no longer see what really is going on and how do you expect
me to solve your problems?

> > Useful thing will be to create mailing list about Linux kernel
> > + binary only modules and to move discussion from lkml there...
>
> True.  Also useful would be to get manufacturers involved in any
> such list so you can hear from them.

True, this can be interesting and constructive.

Regards,
Bartlomiej

