Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280909AbRKYQGA>; Sun, 25 Nov 2001 11:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280907AbRKYQFw>; Sun, 25 Nov 2001 11:05:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18471 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S280909AbRKYQFk>; Sun, 25 Nov 2001 11:05:40 -0500
To: John Alvord <jalvo@mbay.net>
Cc: David Relson <relson@osagesoftware.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Releases
In-Reply-To: <Pine.LNX.4.20.0111242147500.26049-100000@otter.mbay.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 Nov 2001 08:46:29 -0700
In-Reply-To: <Pine.LNX.4.20.0111242147500.26049-100000@otter.mbay.net>
Message-ID: <m1d726zwdm.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Alvord <jalvo@mbay.net> writes:

> Development kernels are development kernels... nothing else. Look to
> distributors for high degrees of quality assurance testing. When you run a
> development kernel you have joined the development team, even if you don't
> know it. Finding  and reporting bugs is your job...

Bah.  Some of the worst kernels I have seen have been distributors kernels.
Distributors seem to give in to the desire for more features, and don't
address the deep bugs.  

Now stability and correctness are two different (but related) things in code.
I have seen stable programs and some even a few kernels that were rock solid
reliable and stable but were extremely incorrect in places.

Correctness means you can write a proof showing how it meats it's
specifications.  Stability means something passes the test of time.

If you are correct it is relatively easy to pass the test of time.  If
you are incorrect it is still possible but harder.

What the developers produce primarily are correct kernels, especially
Linus.  I have never seen a distribution make a kernel more correct.
Instead what I have seen is distributors testing on a wide variety of
hardware and for those things that don't work they throw in the
current best work around.

Also distributors during development don't have the same number of
people testing a kernel as the global linux kernel project has.  At
the current point in time it appears that Linus Torvalds is finally
satisfied with the basic correctness of 2.4.x.  Enough so that he
doesn't feel the need to keep fixing it.  So even if 2.4.15 is 
slightly damaged it makes a good base for future stability.

To date Alan Cox has done a great job in maintaining the stable 2.2
series.  Giving us all something we can use reliably without fear.
And while I haven't watched it religiously Alan Cox has done the whole
release candidate thing, which really does help to catch stupid
typos..  And hopefully in his one way Marcello Tosatti will as well.
I honestly expect future 2.4.x kernels to be much more stable.

I have the utmost respect for the work Linus, Alan, and now Marcello
are doing.  Taking on a position where you agree to be flooded with
email.  Being buried in so much management of patches that you hardly
have time to develop yourself.  Waiting in a pre patch, for someone
else to catch your typos.  Patience is a hard thing, as is believe
that somehow you goofed and you need a second pair of eyes to look
at it and fix it.

Now I agree that finding and reporting bugs is still the job of
everyone who runs a Linux kernel in the stable series, but that is
just the final stage of quality assurance.  But this is part of a
larger job that is really finding a way to get the best possible
kernel.  Giving up on that process and figuring it will always result
in a buggy and flaky product looks like the wrong attitude to take.

Linus has admitted he really doesn't have the temperament for
maintaining a long term stable release.  But as we have all seen he
does have the temperament to lead a development kernel.  And his
stepping down now from the stable branch now that the core of the
kernel is correct is the best sign for stability for 2.4.x that I have
seen.  I have yet to see Marcello's work in action but if is anywhere
near as good as Alan's 2.4.16+ should be more stable than anything the
distributors release.

Eric
