Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264334AbRFGGVF>; Thu, 7 Jun 2001 02:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264335AbRFGGUp>; Thu, 7 Jun 2001 02:20:45 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:64905 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S264334AbRFGGUi>; Thu, 7 Jun 2001 02:20:38 -0400
Date: Thu, 7 Jun 2001 00:20:36 -0600
Message-Id: <200106070620.f576KaI23581@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Matt D. Robinson" <yakker@aparity.com>
Cc: "David S. Miller" <davem@redhat.com>,
        "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>,
        <linux-kernel@vger.kernel.org>, <sctp-developers-list@cig.mot.com>
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister
 table
In-Reply-To: <Pine.LNX.4.30.0106062153540.3846-100000@nakedeye.aparity.com>
In-Reply-To: <200106062351.f56NpOs20522@vindaloo.ras.ucalgary.ca>
	<Pine.LNX.4.30.0106062153540.3846-100000@nakedeye.aparity.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt D. Robinson writes:
> Richard Gooch wrote:
> > David S. Miller writes:
> > > Matt D. Robinson writes:
> > >  > > This allows people to make proprietary implementations of TCP under
> > >  > > Linux.  And we don't want this just as we don't want to add a way to
> > >  > > allow someone to do a proprietary Linux VM.
> > >  >
> > >  > And if as Joe User I don't want Linux TCP, but Joe's TCP, they can't
> > >  > do that (in a supportable way)?  Are you saying Linux is, "do it my
> > >  > way, or it's the highway"?
> >
> > Pardon my cynicism, but this reads more like "I'm an ACME Inc. and I
> > want to sell a proprietary TCP stack for Linux, please change Linux to
> > make this possible/easy". I doubt there are many Joe Users out there
> > who want to replace their TCP stack. I bet they would be much happier
> > to see patches go in which improve the performance of the generic
> > kernel.

I can see this thread is degenerating. I don't plan on responding
after this. I've said my piece.

> Performance Improvements != Innovation.  If the maintainers of the
> Linux kernel only want evolution, not revolution, then that's fine,
> but it should be a bit more clear to everyone.
> 
> Let's say someone wanted to come in and completely restructure devfs.
> And let's say 75% of the people out there loved it, but you didn't.
> Are you willing to stand in the way of allowing the new code to come
> into the kernel for sake of your exclusive opinion?  And if you
> are willing to promote the changes, what does the community say if
> they don't like it?  And is this thought process consistent among
> all maintainers?

I'm the maintainer of devfs, so I'll judge things on their merits as I
see them. If I think something is a bad idea, I'll reject it. If 75%
of people disagree with me, then so be it. I'll listen to others, but
in the and I'll do what I think is right. Devfs had plenty of
opposition. I thought I was right so I went ahead and implemented it.

Ultimately, Linus decides, of course.

> Mr. Yarroll has a great patch, one that offers some help to all kinds
> of developers.  I worry now that it'll either not be accepted or
> it'll end up changing enough that developers using it will have a
> hard time taking advantage of its benefits.

Perhaps if lots of OSS developers call for the changes to be included,
Dave and Linus will change their minds. Or perhaps someone will figure
out a way of give the OSS people what they want without sacrificing
the policy that Dave expressed. Or perhaps few people will really want
to replace the TCP stack. Time will tell.

> > But I'm sure there are plenty of ACME Inc.'s out there who would love
> > to sell a replacement TCP stack. And suck users down a proprietary
> > solution path. But I don't see why the Linux community should help the
> > ACME's of this world. And Linux is doing very nicely in the corporate
> > world, so we needn't to lose any sleep over what our current policies
> > do for our acceptance levels.
> >
> > If it bothers you that Linux caters more the the users and less to the
> > vendors, then use another OS. We don't mind. The door is over there.
> > Please don't slam it on your way out.
> 
> I'm sorry, I normally wouldn't respond, but there are so many points
> to make.  I don't mean to make this into a OSS religious war, but I'm
> curious:
> 
> 1) Why would you limit people's ability to use solutions that are
>    not open source?  I mean, you don't do it in user space, so why
>    bother doing it in the kernel?  Doesn't the eventual goal of
>    opening up solutions to everyone also provide room for companies
>    to make a profit, if it does nothing to hurt the kernel's
>    eventual dominance over other kernels?  And if not, why not?

Actually, it is done in user-space. See GPL'ed libraries (c.f. LGPL'ed
libraries).

> 2) Why won't Linux take FreeBSD OSL'd code into the kernel without
>    also requiring a dual license which also allows for the GNU GPL?
>    I mean, the FreeBSD license is OSL certified, right?  Or is it so
>    important to use GPL over other OSL's that you'd rather styme
>    innovation for the sake of purity?

Yep, the Linux crowd prefer the GPL and the *BSD crowd prefer their
license. Different philosophy. We think the GPL is better for the
greater good, they think the BSD license is better.

> 3) Why take the position that if you don't like it, go to some other
>    OS?  What if I like Linux?  Does that mean I have to give up all
>    thought of using Linux because I want a proprietary solution for
>    one or two things?  Doesn't that seem completely counterintuitive
>    to being "open"?

Look, the GPL is the license that Linux was written under, and is the
license that attracted all these developers. We're already being more
friendly to proprietary solutions than the GPL strictly allows. Be
happy with that. A line has been drawn. Live with it. Either Linux
provides sufficient benefit that it's worth it for your company to
continue working with it, or you decide you can't live with the
restrictions and change to another OS. It's your choice. Don't bitch
about it. No-one is forcing you to use Linux.

People have to make all sorts of choices. Chosing to use proprietary
software means you have to give up certain freedoms. People do it
every day, and pay money for the privilege.

> 4) Why are Linux kernel developers turning into a community of
>    gatekeepers who are increasingly less "open" about changes to the
>    product?  Is it really these days only what Linus wants?  By that
>    I mean, does he really control the majority of changes, or just
>    those things he has time to look at or really cares about?  All
>    those other tree components are now maintained, some loosely,
>    some in a draconian fashion.  If someone isn't flexible, how is
>    innovation maintained?

If the community thinks someone isn't performing, they get replaced.
It's happened in the kernel, and it's happened in other OSS
projects. Innovation doesn't appear to be suffering.

> > > If Joe's TCP is opensource, they are more than welcome to publish
> > > such changes.
> >
> > Yep. And then we can all benefit.
> 
> And if it's released under the FreeBSD OSL, it won't be placed into
> the Linux kernel (at least according to one rather important
> maintainer).  So Linux users as a whole won't benefit.  And that's a
> real shame.

Quite a few developers are happy to dual license their code, if the
original license was BSD.

> Just my opinion.  I just get the feeling that some of the
> maintainers are taking a "I'd rather cut off my nose to spite my
> face" stand on their beliefs rather than considering how the Linux
> kernel can evolve to help everyone -- even those that want to make
> money.  The kernel can allow for both, but they (meaning the
> maintainers) just choose not to permit it.

This isn't about spite. You just don't get what Linux is about. It's a
hackers' OS. Made by hackers for hackers. It's great that many other
people can use it, and that people can make money off it, more power
to them. But ultimately, we *don't care* if others use it. Sure, it's
nice if others do, and we try and help them. But not by sacrificing
what we believe in. And no-one should ask us to.

> Maybe they just want some more of those RedHat stock options ...

How dare you! This isn't about RedHat stock options. I don't have any
myself, and people like Alan and Dave have shown their integrity and
their commitment to the community and don't deserve to have mud slung
at them. Maybe the problem is that you're trying to push a proprietary
product, and want the kernel to be changed to suit your narrow,
commercial interests, and the "gatekeepers" aren't rolling out the red
carpet for you.

Get real, mate.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
