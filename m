Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbRFGFOq>; Thu, 7 Jun 2001 01:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261861AbRFGFOg>; Thu, 7 Jun 2001 01:14:36 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:36993 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261801AbRFGFOX>; Thu, 7 Jun 2001 01:14:23 -0400
Date: Wed, 6 Jun 2001 22:16:09 -0700 (PDT)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: "David S. Miller" <davem@redhat.com>, Matt Robinson <yakker@aparity.com>,
        "La Monte H.P. Yarroll" <piggy@em.cig.mot.com>,
        <linux-kernel@vger.kernel.org>, <sctp-developers-list@cig.mot.com>
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister
 table
In-Reply-To: <200106062351.f56NpOs20522@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.30.0106062153540.3846-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> David S. Miller writes:
> > Matt D. Robinson writes:
> >  > > This allows people to make proprietary implementations of TCP under
> >  > > Linux.  And we don't want this just as we don't want to add a way to
> >  > > allow someone to do a proprietary Linux VM.
> >  >
> >  > And if as Joe User I don't want Linux TCP, but Joe's TCP, they can't
> >  > do that (in a supportable way)?  Are you saying Linux is, "do it my
> >  > way, or it's the highway"?
>
> Pardon my cynicism, but this reads more like "I'm an ACME Inc. and I
> want to sell a proprietary TCP stack for Linux, please change Linux to
> make this possible/easy". I doubt there are many Joe Users out there
> who want to replace their TCP stack. I bet they would be much happier
> to see patches go in which improve the performance of the generic
> kernel.

Performance Improvements != Innovation.  If the maintainers of the
Linux kernel only want evolution, not revolution, then that's fine,
but it should be a bit more clear to everyone.

Let's say someone wanted to come in and completely restructure devfs.
And let's say 75% of the people out there loved it, but you didn't.
Are you willing to stand in the way of allowing the new code to come
into the kernel for sake of your exclusive opinion?  And if you
are willing to promote the changes, what does the community say if
they don't like it?  And is this thought process consistent among
all maintainers?

Mr. Yarroll has a great patch, one that offers some help to all kinds
of developers.  I worry now that it'll either not be accepted or
it'll end up changing enough that developers using it will have a
hard time taking advantage of its benefits.

> But I'm sure there are plenty of ACME Inc.'s out there who would love
> to sell a replacement TCP stack. And suck users down a proprietary
> solution path. But I don't see why the Linux community should help the
> ACME's of this world. And Linux is doing very nicely in the corporate
> world, so we needn't to lose any sleep over what our current policies
> do for our acceptance levels.
>
> If it bothers you that Linux caters more the the users and less to the
> vendors, then use another OS. We don't mind. The door is over there.
> Please don't slam it on your way out.

I'm sorry, I normally wouldn't respond, but there are so many points
to make.  I don't mean to make this into a OSS religious war, but I'm
curious:

1) Why would you limit people's ability to use solutions that are
   not open source?  I mean, you don't do it in user space, so why
   bother doing it in the kernel?  Doesn't the eventual goal of
   opening up solutions to everyone also provide room for companies
   to make a profit, if it does nothing to hurt the kernel's
   eventual dominance over other kernels?  And if not, why not?

2) Why won't Linux take FreeBSD OSL'd code into the kernel without
   also requiring a dual license which also allows for the GNU GPL?
   I mean, the FreeBSD license is OSL certified, right?  Or is it so
   important to use GPL over other OSL's that you'd rather styme
   innovation for the sake of purity?

3) Why take the position that if you don't like it, go to some other
   OS?  What if I like Linux?  Does that mean I have to give up all
   thought of using Linux because I want a proprietary solution for
   one or two things?  Doesn't that seem completely counterintuitive
   to being "open"?

4) Why are Linux kernel developers turning into a community of
   gatekeepers who are increasingly less "open" about changes to the
   product?  Is it really these days only what Linus wants?  By that
   I mean, does he really control the majority of changes, or just
   those things he has time to look at or really cares about?  All
   those other tree components are now maintained, some loosely,
   some in a draconian fashion.  If someone isn't flexible, how is
   innovation maintained?

> > If Joe's TCP is opensource, they are more than welcome to publish
> > such changes.
>
> Yep. And then we can all benefit.

And if it's released under the FreeBSD OSL, it won't be placed into
the Linux kernel (at least according to one rather important maintainer).
So Linux users as a whole won't benefit.  And that's a real shame.

Just my opinion.  I just get the feeling that some of the maintainers
are taking a "I'd rather cut off my nose to spite my face" stand on
their beliefs rather than considering how the Linux kernel can evolve
to help everyone -- even those that want to make money.  The kernel
can allow for both, but they (meaning the maintainers) just choose not
to permit it.  Maybe they just want some more of those RedHat stock
options ...

>                                 Regards,
>
>                                         Richard....

See ya,

--Matt

P.S.  I guess the next thing on the list for the Linux kernel is to
      create WHQL-like process for drivers before the code can end up
      in newer kernel revisions.  Then I'll really know things have gone
      into the toilet.

