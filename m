Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280948AbRK0RYz>; Tue, 27 Nov 2001 12:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281738AbRK0RYn>; Tue, 27 Nov 2001 12:24:43 -0500
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:53657 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S280948AbRK0RYd>; Tue, 27 Nov 2001 12:24:33 -0500
Message-ID: <3C03CC6C.DD03CDDE@kegel.com>
Date: Tue, 27 Nov 2001 09:25:00 -0800
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Releases
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday 26 November 2001 16:45, Mike Galbraith wrote:
> > > The only way we can get good testing for new kernels is to stop using
> > > -preN prefix in development branch (2.5.x). Just increment that 'x'.
> >
> > That won't change anything except the number on the kernel.  The people
> > who you're trying to turn into bleeding edge testers (those who stay a
> > little behind [bignum]) will continue to ride the curve at the point of
> > their choosing.
> 
> Yes, but they can't tell which 2.5.x is more stable just from version number.
> This way Linus will get better test coverage in 2.5.x.
> 
> Those who need stability can read lkml and figure out which 2.5.x was 
> 'glitchless' :-) or stick with 2.4.x

Agreed.  2.5.x should not use -pre.  Just increment X.  

2.4.x should continue to use -preY.
There's no need for a -rcY as some have suggested.
All we need to do to avoid messes like the 2.4.15 debacle
is to insist that a 2.4.X-preY should not be
released as final 2.4.X until the pre's been out for a week,
and there should never be any changes introduced into a final
that didn't cook for a week as a pre.  Marcello, what say ye?

That should give enough time for everyone to
find bugs and yell.
- Dan
