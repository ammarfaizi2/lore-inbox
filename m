Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKQI11>; Fri, 17 Nov 2000 03:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQKQI1S>; Fri, 17 Nov 2000 03:27:18 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:8716 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129150AbQKQI06>; Fri, 17 Nov 2000 03:26:58 -0500
Date: Fri, 17 Nov 2000 01:53:05 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Erik Andersen <andersen@codepoet.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: jmerkey@timpanogas.org
Subject: Re: test11-pre6
Message-ID: <20001117015305.A17593@vger.timpanogas.org>
In-Reply-To: <Pine.LNX.4.10.10011161832460.803-100000@penguin.transmeta.com> <20001116204510.B15356@vger.timpanogas.org> <20001117003046.A16984@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001117003046.A16984@codepoet.org>; from andersen@codepoet.org on Fri, Nov 17, 2000 at 12:30:46AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 12:30:46AM -0700, Erik Andersen wrote:
> On Thu Nov 16, 2000 at 08:45:10PM -0700, Jeff V. Merkey wrote:
> > > 
> > >  - pre6:
> > >     - Intel: start to add Pentium IV specific stuff (128-byte cacheline
> > >       etc)
> > >     - David Miller: search-and-destroy places that forget to mark us
> > >       running after removing us from a wait-queue.
> > Level I
> > >     - me: NFS client write-back ref-counting SMP instability.
> > >     - me: fix up non-exclusive waiters
> > >     - Trond Myklebust: Be more careful about SMP in NFS and RPC code
> > >     - Trond Myklebust: inode attribute update race fix
> > >     - Charles White: don't do unaligned accesses in cpqarray driver.
> > >     - Jeff Garzik: continued driver cleanup and fixes
> > >     - Peter Anvin: integrate more of the Intel patches.
> > >     - Robert Love: add i815 signature to the intel AGP support
> > >     - Rik Faith: DRM update to make it easier to sync up 2.2.x
> > >     - David Woodhouse: make old 16-bit pcmcia controllers work
> > >       again (ie i82365 and TCIC)
> > Level I
> > 
> > The list is getting shorter.  
> 
> WTF is "Level I" supposed to mean and why have you inserted it seemingly
> randomly into the changelog and why are you telling the world about it?  I've
> seen you do this several times and I am completely baffled.  Surely you have
> some reason for wanting to share?

NetWare was delineated into five levels of bugs to determine commercial 
ship worthiness.  NT is somewhat sloppier than what Novell does because
they are not running a ring 0 OS.  Kernel development is Ring 0 
development, so a lot of the same concepts apply:

Level I - Abends and Severe Kernel or Memory Corruption bugs, or 
functionality bugs. (Oops level stuff, or Deadlock types of
bugs).

Level II - Critical Bugs in peripheral subsystems, like broken
drivers that would abend (Oops), but that would not halt shipment
of core components.

Level III - boundry condition bugs, like app or subsystem problems
in low memory, intermittent LAN or obscure hardware related bugs.

Level IV - Missing Functionality, like the speaker volume not working
with pcmcia-cs-3.1.22 on an IBM thinkpad -- non-critical, but annoying.

Level V - Feature/Documentation out of sync, docs need updating, etc.

Where I came from, when you ht 0 Level I bugs, time to ship.  When Linus 
can post a 2.4 status that has no new Level I issues, I will put my 
	2.4 RPM out.  To date, i just keeps dragging on, with a whole
new slew of new Level I bugs every week, but it is having fewer and
fewer of them.  

He obviously posts these updates for public comment.  We ship Linux,
so there's our 2 cents.

Jeff


> 
>  -Erik
> 
> --
> Erik B. Andersen   email:  andersee@debian.org
> --This message was written using 73% post-consumer electrons--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
