Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291081AbSBVBvW>; Thu, 21 Feb 2002 20:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291123AbSBVBvN>; Thu, 21 Feb 2002 20:51:13 -0500
Received: from starbug.ugh.net.au ([203.31.238.37]:37644 "EHLO
	starbug.ugh.net.au") by vger.kernel.org with ESMTP
	id <S291081AbSBVBvD>; Thu, 21 Feb 2002 20:51:03 -0500
Date: Fri, 22 Feb 2002 12:51:00 +1100 (EST)
From: David Burrows <snadge@ugh.net.au>
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dodgey Linus BogoMIPS code ;) (was Re: baffling linux bug)
In-Reply-To: <Pine.LNX.4.33.0202212038150.16271-100000@coffee.psychology.mcmaster.ca>
Message-ID: <20020222124629.F15623-100000@starbug.ugh.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2002, Mark Hahn wrote:
> > > > loop.  FreeBSD and Windows still work.  If I knew how init/main.c worked,
> > > > what jiffies are and how they are updated (timer interrupt?), then I would
> > > sorry if you've already mentioned this, but do you have
> > > CONFIG_X86_UP_*APIC selected (something like "use local apic
> > > for uniprocessors")?  if so, it could explain why you
> > > might be failing to receive timer irq's.
> >
> > I've tried with 2.0 kernels, 2.2 kernels and 2.4 kernels.  Some of them I
> > can actually get to oops, but most of the time just a hard lock.  I
> > believe I have that option disabled, I can't verify that at the moment
> > because I can't even run Linux.
>
> and you said that you have in the past run linux on this machine?
> and that you haven't made any bios changes/upgrades/etc?
> and that your pre-hang (pre-calibrating-delay-loop) messages
> are completely uninformative?  also, that you are not making the
> TSC-ful-cpu mistake?  actually the latter would be my guess...

Yes, I have been running various versions of Linux without problem on this
same machine for a number of years.  I had not changed any hardware or
software between when it was working and when it suddenly started failing.
It is for this reason alone I posted on linux-kernel to get some help.

> > Then why does FreeBSD still work?
>
> I was answering your hypothetical question.  freeBSD works because
> it doesn't share any code with linux, of course, same with windows.

I would assume that FreeBSD and Windows would still use the timer for some
reason or another.  Therefore whatever sudden quirk that appeared in my
hardware has revealed a bug in Linux..

> > There are folks who would claim that
> > FreeBSD is superior to Linux.... ;)
>
> yeah, and Bhuddism is better than Christianity.  such claims tell
> you exactly one thing: the utterer is a twit.

Well I personally don't believe one way or another.  Its apples and
oranges as far as I'm concerned, however in this case one could say that
FreeBSD is better because it actually works. ;)

Cheers,

David.

