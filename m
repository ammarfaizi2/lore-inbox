Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750958AbWHKN0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750958AbWHKN0Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 09:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWHKN0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 09:26:25 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:12765 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750838AbWHKN0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 09:26:24 -0400
Message-Id: <200608111326.k7BDQ7fp004102@laptop13.inf.utfsm.cl>
To: "John Stoffel" <john@stoffel.org>
Cc: "Molle Bestefich" <molle.bestefich@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext3 corruption 
In-Reply-To: Your message of "Thu, 10 Aug 2006 12:10:31 -0400."
             <17627.23159.236724.190546@stoffel.org> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Fri, 11 Aug 2006 09:26:07 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Fri, 11 Aug 2006 09:26:09 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Stoffel <john@stoffel.org> wrote:
> >>>>> "Molle" == Molle Bestefich <molle.bestefich@gmail.com> writes:
> 
> Molle> I guess the problem is that I don't know a single Linux
> Molle> packaging system that actually works well enough to keep a
> Molle> system up to date at all times, and I don't have any free time
> Molle> to spend on reinstalling systems all the time.
> 
> Debian works the best in my experience.  Yum sucks rocks, it's a pain
> to configured and when it does pull in stuff, it pulls in *everything*
> that you don't want.  

Right. Its called "dependencies", and if you don't get those, chances are
it won't work. No Debian magic around that, I'm afraid. Sure, if all that
ever changes is minor tweaks...

> Not that apt-get is perfect, but it works well.  My main machine at
> home is an old Debian Stable install upgraded pretty much daily.
> Rarely do things break.  And rarely do you want packages updated
> without you thinking about it.  

My machine here runs Fedora rawhide (can't get more bleeding edge). Rarely
things break due to updating. The machines in the Lab here are Fedora,
almost never anything breaks. Servers are CentOS, I can't remember anything
ever breaking due to updates.

[...]

> I tried gentoo a bunch of years ago and didn't like it, and it
> certainly didn't give me the speedup it claimed it would have.

Gentoo folks deceive themselves into "at least twice as fast because I
compiled it myself"...

>                                                                 I've
> been happy with Debian.  Thinking about Ubuntu more...

[...]

> Molle> And voila, that difficult task of assessing in which order to
> Molle> do things is out of the hands of distros like Red Hat, and into
> Molle> the hands of those people who actually make the binaries.
> 
> *bwah hah hah!*  And you think they'll get it right?  So what happens
> when two packages, call them A and B, have a circular dependency on
> each other?  Who wins then?

The kernel people are certainly not infallible either. And there are cases
where the right order is A B C, and others in which it is C B A, and still
others where it doesn't matter. No way to get it right always.

> It's not as simple an issue as you think.  

Shoving it into the kernel certainly won't simplify it, quite the contrary
by making it less amenable to hand-tweaking.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
