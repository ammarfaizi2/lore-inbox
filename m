Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129434AbRCABhu>; Wed, 28 Feb 2001 20:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129435AbRCABhi>; Wed, 28 Feb 2001 20:37:38 -0500
Received: from adsl-64-167-146-94.dsl.snfc21.pacbell.net ([64.167.146.94]:56840
	"EHLO eleanor.wdhq.scyld.com") by vger.kernel.org with ESMTP
	id <S129444AbRCABeY>; Wed, 28 Feb 2001 20:34:24 -0500
Date: Wed, 28 Feb 2001 20:35:09 -0500 (EST)
From: Daniel Ridge <newt@scyld.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: beowulf@beowulf.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Will Mosix go into the standard kernel?
In-Reply-To: <200102282358.f1SNw7b177652@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.21.0102281943030.6730-100000@eleanor.wdhq.scyld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 28 Feb 2001, Albert D. Cahalan wrote:

> > The Scyld system is based on BProc -- which requires only a 1K patch to
> > the kernel. This patch adds 339 net lines to the kernel, and changes 38
> > existing lines.
> 
> Well, that explains your viewpoint and your motivation. :-)

I would put this the other way around. I would say that Scyld reflects the
views of its core developers -- not the other way around. Those of us who
worked on the Beowulf project at NASA felt then exactly as we do today.

> ALSA: driver work gets done twice

It's an irrelevant detail if only one works. I've used the kernel's
brand of sound support and it mostly works. I'm usually too lazy
to get ALSA. I only use it when the kernel's support hasn't quite caught
up to ALSA's

> pcmcia-cs: this was so bad that Linus himself was unable to install
> Linux on his new laptop, so now PCMCIA support is in the kernel.

I often have exactly inverted problems with CardBus.

It's true that external packages often start to look like geologic rock
samples -- the sediment record of linux -- and that they become a record
of the things that have changed. Funniest, I think, is when these packages
record interfaces that merely churn without improving.

Naturally, it takes work to created a supportable piece of system software
that can be used on a number of platforms. I would also cite from your
text above: "driver work gets done twice".

> VMware: quite a pain I think

I think not! Installing VMware today is a breeze. SMP or UP? No problem!
Upgrade your kernel? No problem! Outstanding for a commercial third-party
application that happens to be available on two different platforms.

I would also add Myricom's GM package for Myrinet to the list of
reasonable components that are maintained outside of the kernel.
Vendors should be encouraged to provide the kind of commitment to linux
that Myri consistiently demonstrates.
 
> You are basically suggesting the often-rejected "split up the kernel"
> idea. I think the linux-kernel FAQ covers this.

No. I'm stipulating that I work with a really interesting piece of
software that works with the Linux kernel and is available under the GPL
and which we have never even bothered to 'submit' as a patch. I'm willing
to suggest further that any responsible development community is
suceptible to "race conditions" whereby the natural and studied
development and evaluation process is end-run by attempts to 'win' and
urinate on the kernel or ANSI or POSIX or whoever (with a facility or
mechanism) directly.

These types of 'hacks' or 'denials-of-service' play on the adage that
forgiveness is easier than permission. It's hard to dispute this point
in an age when SourceForge makes it possible for anyone to maintain
a driver or filesystem or whatever without needing to 'hitch a ride'
on an existing project (ala linux) that already has a distribution and
mirroring facility.

> So people should only get kernels from linux vendors? This is great
> for your business I'd imagine, but one of the nice things about Linux
> is that you can replace the kernel without too much trouble.

No. My point was that it is possible to do a reasonable job and that
building a kernel and subsytems so that the result is deliverable and
supportable is very hard -- harder than building a kernel and ALSA
for just yourself -- and that external components can be resonably done
even in the tough vendor environment.

>From my own perspective, I'm far to lazy to build kernels for
myself. I can hack on Beowulf clustering -- including new kernel modules
-- all day long and the build process usually lasts 5s of seconds.

Regards,
	Dan Ridge
	Scyld Computing Corporation

