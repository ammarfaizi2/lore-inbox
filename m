Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292231AbSB0Ham>; Wed, 27 Feb 2002 02:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292233AbSB0HaW>; Wed, 27 Feb 2002 02:30:22 -0500
Received: from dsl-213-023-039-032.arcor-ip.net ([213.23.39.32]:56450 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S292231AbSB0HaU>;
	Wed, 27 Feb 2002 02:30:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Steve Lord <lord@sgi.com>
Subject: Re: Whither XFS? (was: Congrats Marcelo)
Date: Mon, 25 Feb 2002 09:22:35 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andreas Dilger <adilger@turbolabs.com>,
        Dennis Jim <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <E16fqZK-0002NE-00@the-village.bc.nu> <E16f90h-0002rt-00@starship.berlin> <1014766788.9994.231.camel@jen.americas.sgi.com>
In-Reply-To: <1014766788.9994.231.camel@jen.americas.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16fGP5-0000Rh-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 27, 2002 12:39 am, Steve Lord wrote:
> On Sun, 2002-02-24 at 18:28, Daniel Phillips wrote:
> > > 
> > >   o Posix ACL support
> > 
> > Are you able to leverage the new EA interface?...
> 
> Where do you think the interface originated? A lot of time was spent
> working on this and getting the ext2 and xfs code bases in sync.

Just checking.  So that's one place you're already syncing up with Linus.

> > 
> > >   o The ability to do online filesystem dumps which are coherent with
> > >     the system call interface
> > 
> > It would be nice if some other filesystems could share that mechanism, do
> > you think it's feasible?  If not, what's the stumbling block?  I haven't
> > looked at this for some time and there's was some furious work going on
> > exactly there just before 2.5.  It seems we've at least progressed a
> > little from the viewpoint that nobody would want that.
> 
> Not really, there are some hooks into XFS which are probably totally
> non-trivial for other filesystems.

So could you explain your approach here?  This pagebuf-land right?

> [...]
> > 
> > >   o DMAPI
> > 
> > It would be nice to have unsucky file events.  But there's been roughly zero
> > discussion of dmapi on lkml as far as I can see.
> 
> Yep, and its not my strong suite. The previous attempt at an implementation
> by someone else appears to have died a death.

I see Ben Lahaise aio proposal comes complete with a form of event queues,
would it be possible to share some of the machinery?

> > > As it is we did all of these, and we seem to have half the Linux NAS
> > > vendors in the world building xfs into their boxes.
> > 
> > True enough.
> 
> Now if only we could make some money out of them ;-)

Make money on XFS?  Not directly I'd say, but keeping customers happy when
they move to Linux - that has to count for something.  As far as making
heaps of $$$ goes, just keep shipping kickass boxes running real OS's and
don't get sucked in by billg again ;-)

-- 
Daniel
