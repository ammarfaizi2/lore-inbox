Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263469AbRFYKiV>; Mon, 25 Jun 2001 06:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263476AbRFYKiM>; Mon, 25 Jun 2001 06:38:12 -0400
Received: from Expansa.sns.it ([192.167.206.189]:1811 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S263469AbRFYKiI>;
	Mon, 25 Jun 2001 06:38:08 -0400
Date: Mon, 25 Jun 2001 12:37:50 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Rick Hohensee <humbubba@smarty.smart.net>
cc: <jesse@cats-chateau.net>, <linux-kernel@vger.kernel.org>
Subject: Re: The Joy of Forking
In-Reply-To: <200106250803.EAA20874@smarty.smart.net>
Message-ID: <Pine.LNX.4.33.0106251212490.3000-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Jun 2001, Rick Hohensee wrote:

> >
> > >	rtlinux by default
> > >	no SMP
> > >		SMP doesn't scale. If this fork comes, the smart maintainer
> > >		will take the non-SMP fork.
> >
> > Depends on platform and bus. From reports, it seems to scale just fine on
> > non-intel systems.
>
> Big expensive systems. Non-desktop systems. Non-end-user systems. And
> clustering will eat its lunch eventually anyway.
biprocessor are starting to be also end-user systems. About clustering,
actually it is very usefull, the most of times is a cost effective
solution to avoid to buy an unusefull 64 processor system,
but basically, in front of the computational needs you could have, it can
be used for different things in front of SMP systems.
It happens to me to have a cluster
composed by 4 dual processor systems, because i need a cluster, and i need
the single nodes to be dual processor. With an 8 nodes cluster composed by
uniprocessor I wuld give a mutch less efficient service to my users
computational needs.
>
> >
> > >	x86 only (and similar, e.g. Crusoe)
> >
> > Again, Linux is the only system that CAN run on anything from PDA thorough
> > supercomputer clusters.
> >
>
> NetBSD claims 24 platforms. Forths run on everything you've never heard of
> below a PDA.
yes, but to run on every kind of processor is a BIG strenght for Linux.
I don't think it is necessary to explain why.
>
>
> > >	mimimal VM cacheing
> > >		So you can red-switch the box without journalling with
> > >		reasonable damage, which for an end-user is a file or two.
> > >		Having done a lot of very wrong things with Linux, I'm
> > >		impressed that ext2 doesn't self-destruct under abuse.
> >
> > Not if you want some speed out of it.
>
> Again, throughput is a server thing.
not true. Desktops have to be very responsive to users.
If a users run an application (read click on icon application),
let's say mozilla, and it will not start in about one second, he will
feel the desktop is slow. You need the best throughtput and speed
efficiency with disks on desktops.
Desktop users will never pay atention if the system is efficient, but if
it is fast in a way they can feel fastness. That means, fast to bring up
an application the same second the command is runned.
>
> >
> > >
> > >What about GUI's, and "desktops" and such? They're nice. They are
> > >secondary, however. The free unix world doesn't often enough make the
> > >point that GUI's are much more important when the underlying OS sucks,
> > >which it doesn't in Linux.
> >
> > If you only use a compute/disk server. Otherwise you are saying "no desktop
> > publishing, word processing, or image analysis".
> >
> > Are you still using DOS only?
> >
>
> I haven't started X in about a year. I read pdf's as jpegs, I have Xaos
> running in SVGA, and so on. Not-unix != Dos . I don't dislike X
> particularly, but I live in what I ship, and for maintenance I can't keep
> up with console, considering that I'm doing a bit more than just bundling
> things up.
??? I do not understand the point. I would say that is not a point.
>
> > >In short, an open source OS for end-users should be very serious about
> > >simplicity, and not just pay lip-service to it. There is evidence of the
> > >value of this in the marketplace. What doesn't exist is an OS where
> > >simplicity is systemic. This is why end-user issues pertain to the kernel
> > >at all. This is how open source should be. Simple, or at least clear,
> > >through and through. Linux has lost a lot of simplicity since I got into
> > >it in '96, and that is a loss.
> >
> > For the most part, the base Linux appears simple to the user. There are no
>
> Which distro appears simple to the user?
I write for a review in Italy, we usually include distro's cd every month.
I have readers feed back. You would never say.
Newbies, who never saw a linux before, mandrake, red hat,
newbies coming from some Unix experience as users, slackware, someone
debian.
They write back to the redation, telling us how fonderfully easy it was,
and that they could not figure it was so easy.
>
>
> > desktops to worry about. Desktops are an application, not part of Linux at all
> > It is becoming better for the administrator. As better desktops are developed,
> > it is becoming for "user friendly".
>
> Thanks for replying civilly to something you clearly don't agree with.
> Basically, your reply says to me that kernel hackers can't imagine unix as
> an end-user OS. Your points are all "that will suck as a server". Of
> course. A solid true multi-user open source operating system is a solid
> base for a variety of things.
I would say that users needs top feel the system to be fast.
That is true for desktop even more than for servers.
anyway, many of changes someone push to bring linux on the desktop will
make it slower, and that way users will never use it.
No desktop user will way 2 minutes to bring up an office suite.
Linux has a tradition it has to refer to, and inside of this tradition
Linux can find the way also for the desktop.
There is nothing wrong if you separe the OS from the desktop, and you say,
"desktops are on the application side". Then you, as OS can provide
the best performance as possible, disk speed, optimal memory usage, and so
on. Then the applications have to be able to use this optimal system at
best.

Luigi




