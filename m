Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262099AbSJJWqV>; Thu, 10 Oct 2002 18:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262152AbSJJWqT>; Thu, 10 Oct 2002 18:46:19 -0400
Received: from grue.ucsd.edu ([132.239.66.103]:37248 "EHLO grue.ucsd.edu")
	by vger.kernel.org with ESMTP id <S262099AbSJJWpk>;
	Thu, 10 Oct 2002 18:45:40 -0400
Date: Thu, 10 Oct 2002 15:51:30 -0700 (PDT)
Message-Id: <20021010.155130.23003855.wlandry@ucsd.edu>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: A simple request
From: Walter Landry <wlandry@ucsd.edu>
In-Reply-To: <3DA58B60.1010101@pobox.com>
References: <20021009.163920.85414652.wlandry@ucsd.edu>
	<3DA58B60.1010101@pobox.com>
X-Mailer: Mew version 2.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
> Walter Landry wrote:
> > Jeff Garzik wrote:
> > 
> >>If you can't fit a whole tree including metadata into RAM, though,
> >>BK crawls... Going from "bk citool" at the command line to actually
> >>seeing the citool window approaches five minutes of runtime, on this
> >>200MB laptop... [my dual athlon with 512MB RAM corroborates your
> >>numbers, though] "bk -r co -Sq" takes a similar amount of time...
> >>
> >>I also find that BK brings out the worst in the 2.4 kernel
> >>elevator/VM... mouse clicks in Mozilla take upwards of 10 seconds to
> >>respond, when "bk -r co -Sq" is running on this laptop [any other
> >>read-from-disk process behaves similarly]. And running any two BK
> >>jobs at the same time is a huge mistake. Two "bk -r co -Sq" runs
> >>easily take four or more times longer than a single run. Ditto for
> >>consistency checks, or any other disk-intensive activity BK indulges
> >>in.
> > 
> > 
> > Hello,
> > 
> > What kind of CPU and hard drive do your two machines above have?  I'm
> > a developer for arch[1], and I'm wondering how fast things can get.
> 
> The laptop has 200MB RAM, and mozilla and a ton of xterms loaded.  IDE 
> drives w/ Intel PIIX4 controller.  The Dual Athlon has 512MB RAM, and I 
> forget what kind of IDE controller -- I think AMD.  IDE drives as well.

Sorry, I wasn't specific enough.  What is the clock speed (MHz) of the
CPU and the RPM and/or results of hparm -t of the hard drive?

> BitKeeper must scan the entire tree when doing a checkin or checkout, so 
> that is impossible to optimize at the SCM level without compromising 
> features...  if your source tree takes up ~190MB on disk, you have 200MB 
> of RAM total, and you need to sequentially scan the entire thing, there 
> is nothing that can be done at either the OS or app level... You're just 
> screwed.  Things are extremely fast on the Dual Athlon because the 
> entire tree is in RAM.

How fast?  If you have, for example, the 2.4.18 tree and apply the
2.4.19 patches, approximately how long does it take for citool to show
up, showing all modified files (less than a second? 10 seconds? a
minute?)

> > Note: If you answer, you'll certainly be aiding arch development.  It
> >       might be interpreted as "develop[ing] ... a product which
> >       contains substantially similar capabilities of the BitKeeper
> >       Software, or, in the reasonable opinion of BitMover, competes
> >       with the BitKeeper Software".  So you might lose the ability to
> >       use the free license.  But I'll let you decide if you want to
> >       help us.
> 
> 
> Don't be silly:  I am more than willing to help, via answering 
> questions.

Thanks,
Walter Landry
wlandry@ucsd.edu

