Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbRFYHxK>; Mon, 25 Jun 2001 03:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261425AbRFYHxB>; Mon, 25 Jun 2001 03:53:01 -0400
Received: from smarty.smart.net ([207.176.80.102]:1294 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S261289AbRFYHwt>;
	Mon, 25 Jun 2001 03:52:49 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200106250803.EAA20874@smarty.smart.net>
Subject: Re: The Joy of Forking
To: jesse@cats-chateau.net
Date: Mon, 25 Jun 2001 04:03:54 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01062422482200.18805@tabby> from "Jesse Pollard" at Jun 24, 2001 10:34:42 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sun, 24 Jun 2001, Rick Hohensee wrote:
> >2.4.5 is 26 meg now. It's time to consider forking the kernel. Alan has
> >already stuck his tippy-toe is that pool, and his toe is fine.
> >
> >	forget POSIX
> >		The standards that matter are de-facto standards. Linux is the
> >		standard. Congratulations. Take your seat in the chair for 
> >		First Violin. 
> 
> NO. I port too many programs both ways. I need POSIX compliancy as much as
> is possible. That way the programs will compile and go among Linux, UNICOS,
> IRIX, Solaris, AIX, and sometimes HP-UX.

That's fine for things unix does well. Realtime is one counterexample. 

> 
> >	rtlinux by default
> >	no SMP
> >		SMP doesn't scale. If this fork comes, the smart maintainer
> >		will take the non-SMP fork.
> 
> Depends on platform and bus. From reports, it seems to scale just fine on
> non-intel systems.

Big expensive systems. Non-desktop systems. Non-end-user systems. And
clustering will eat its lunch eventually anyway.

> 
> >	x86 only (and similar, e.g. Crusoe)
> 
> Again, Linux is the only system that CAN run on anything from PDA thorough
> supercomputer clusters.
> 

NetBSD claims 24 platforms. Forths run on everything you've never heard of
below a PDA. 


> >	mimimal VM cacheing
> >		So you can red-switch the box without journalling with
> >		reasonable damage, which for an end-user is a file or two.
> >		Having done a lot of very wrong things with Linux, I'm 
> >		impressed that ext2 doesn't self-destruct under abuse.
> 
> Not if you want some speed out of it.

Again, throughput is a server thing. 

> 
> >	in-kernel interpreter
> >		I have one working. It's fun.
> 
> VIRUSES, VIRUSES, and MORE VIRUS entry points. Assuming you mean both
> translator and execution at the same time.

And assembler. This is called get your hands greasy. Fun. Your box. Not
the admin's box. 

> 
> >	EOL is CR&LF
> >		The one thing Dos got right and unix got wrong. Also, in my
> >		2-month experience in a cube on a LAN, the most annoying thing
> >		about trying to be a Linux end-user in a Dos shop. Printers
> >		are CRLF, fer crissakes.
> >		This is not a difficult mod, but it's a lot of little changes
> >		throughout a box. Things that look for EOLs are the part that
> >		has to be fixed by hand, and can be inclusive of CRLF and LF.
> 
> I've used both. They are equivalent. Live with it.
> 

We disagree, but I wont rant about the phone company breaking a perfectly
good telegraphy protocol called ASCII.

> >	Plan 9-style header files structure
> >		Plan 9's most amazing stuff to me is the subtle refinements,
> >		like sane header files. Sane C header files, _oh_ _my_ _God_. 
> 
> As long as source code portability is maintained.

Dennis Ritchie, who signs the checks for the people that wrote Plan 9,
said an interesting thing about portability. He said "good code is
portable code." I infer from that, and from the Plan 9 sources, and from
the design of unix and the two-character commands in /bin/, that he
relates good very strongly with simple. Not slavish adherance to
standards. Plan 9 C isn't ANSI, for example. The unix portability suite is
called "ape".

> 
> >	excellent localizability
> >		e.g. kernel error strings mapped to a file, or an #include
> >		that can be language-specific. My DSFH stuff also. 
> 
> This is quite reasonable. Actually, unless you are referring to Kernel internal
> error codes, it's already done with perror.
> 
> >
> >What about GUI's, and "desktops" and such? They're nice. They are
> >secondary, however. The free unix world doesn't often enough make the
> >point that GUI's are much more important when the underlying OS sucks,
> >which it doesn't in Linux. 
> 
> If you only use a compute/disk server. Otherwise you are saying "no desktop
> publishing, word processing, or image analysis".
> 
> Are you still using DOS only?
> 

I haven't started X in about a year. I read pdf's as jpegs, I have Xaos
running in SVGA, and so on. Not-unix != Dos . I don't dislike X
particularly, but I live in what I ship, and for maintenance I can't keep
up with console, considering that I'm doing a bit more than just bundling
things up.

> >In short, an open source OS for end-users should be very serious about
> >simplicity, and not just pay lip-service to it. There is evidence of the
> >value of this in the marketplace. What doesn't exist is an OS where
> >simplicity is systemic. This is why end-user issues pertain to the kernel
> >at all. This is how open source should be. Simple, or at least clear,
> >through and through. Linux has lost a lot of simplicity since I got into
> >it in '96, and that is a loss.
> 
> For the most part, the base Linux appears simple to the user. There are no

Which distro appears simple to the user? 


> desktops to worry about. Desktops are an application, not part of Linux at all
> It is becoming better for the administrator. As better desktops are developed,
> it is becoming for "user friendly".

Thanks for replying civilly to something you clearly don't agree with.
Basically, your reply says to me that kernel hackers can't imagine unix as
an end-user OS. Your points are all "that will suck as a server". Of
course. A solid true multi-user open source operating system is a solid
base for a variety of things.

Rick Hohensee
www.clienux.com


> 
> -- 
> -------------------------------------------------------------------------
> Jesse I Pollard, II
> Email: jesse@cats-chateau.net
> 
> Any opinions expressed are solely my own.
> 

