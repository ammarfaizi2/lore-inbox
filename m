Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291406AbSBMGdC>; Wed, 13 Feb 2002 01:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291415AbSBMGcw>; Wed, 13 Feb 2002 01:32:52 -0500
Received: from 1Cust8.tnt15.sfo3.da.uu.net ([67.218.75.8]:30987 "EHLO
	morrowfield.home") by vger.kernel.org with ESMTP id <S291406AbSBMGco>;
	Wed, 13 Feb 2002 01:32:44 -0500
Date: Wed, 13 Feb 2002 01:41:25 -0800 (PST)
Message-Id: <200202130941.BAA06261@morrowfield.home>
From: Tom Lord <lord@regexps.com>
To: lm@bitmover.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20020212145412.E25559@work.bitmover.com> (message from Larry
	McVoy on Tue, 12 Feb 2002 14:54:12 -0800)
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org> <20020207165035.GA28384@ravel.coda.cs.cmu.edu> <200202072306.PAA08272@morrowfield.home> <20020207132558.D27932@work.bitmover.com> <20020211002057.A17539@helen.CS.Berkeley.EDU> <20020211070009.S28640@work.bitmover.com> <20020211141404.A21336@work.bitmover.com> <200202120517.VAA21821@morrowfield.home> <20020211225935.B5514@thunk.org> <200202122028.MAA24835@morrowfield.home> <20020212145412.E25559@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


       Larry writes:

       I think that the point is that when you put stuff on your laptop, you'd
       dearly love not realize that you forgot something you need when you are
       either not connected or are connected only via a modem.  If you can store
       the kernel history in 80-90MB and you have all the versions you'll ever
       want, that's a win compared to storing a few versions and then realizing
       the one you want isn't there.

The base cost of storing revisions in arch is the size of a compressed
tar file of the diffs, plus the size of the directory containing those
diffs plus the size of the log message.  It is therefore likely that
one can store many, many revisions of the kernel on one's laptop, if
that's what one wants to do.  If one has space left over, that can be
used for a revision library (complete trees of revisions, sharing
unmodified files).

   I also think that the term "huge revision library" doesn't make sense
   to all systems.  Some systems can fit that "huge library" in less space
   than the checked out files, so why limit yourself?

Arch *does* fit that "huge library" in less space than the checked out
files.  I thought I'd made that perfectly clear already.


       And it's not like this makes arch bad, this is one place where it isn't as
       good as some other choices.  

But you haven't described arch accurately, so I don't think your
comparative judgement is something anyone ought to dwell on.

	It's the uber patch library if you ask me

We agree.

	there is nothing simple about this problem space.

We agree again.  It isn't the most difficult branch of mathematic ever
discovered, but it isn't trivial, either.

While I'm not too sure about comparing anyone's genetalia to the state
of Texas, as an earlier poster suggested, I am sure that patch logic
and revision control are fascinating and deeply relevant to
distributed development. They are topics that kernel hackers ought to
think about carefully.

-t
