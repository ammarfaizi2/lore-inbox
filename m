Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279264AbRKFNoO>; Tue, 6 Nov 2001 08:44:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279305AbRKFNoE>; Tue, 6 Nov 2001 08:44:04 -0500
Received: from unthought.net ([212.97.129.24]:59867 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S279264AbRKFNnz>;
	Tue, 6 Nov 2001 08:43:55 -0500
Date: Tue, 6 Nov 2001 14:43:53 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Petr Baudis <pasky@pasky.ji.cz>, linux-kernel@vger.kernel.org,
        Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
        Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011106144353.B3058@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Alexander Viro <viro@math.psu.edu>, Petr Baudis <pasky@pasky.ji.cz>,
	linux-kernel@vger.kernel.org,
	Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>,
	Tim Jansen <tim@tjansen.de>
In-Reply-To: <20011106092133.X11619@pasky.ji.cz> <Pine.GSO.4.21.0111060326100.27713-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0111060326100.27713-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Tue, Nov 06, 2001 at 03:34:40AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2001 at 03:34:40AM -0500, Alexander Viro wrote:
> 
> 
> On Tue, 6 Nov 2001, Petr Baudis wrote:
> 
> > > As far as I can see, I cannot read /proc/[pid]/* info using sysctl.
> > That can be added. We just have existing interface, and I don't propose to
> > stick on its actual state as it isn't convenient, but to extend it to cope our
> > needs.
> 
> No, that cannot.  Guys, you've been told: it won't happen.  I think that
> was loud and clear enough.

Al, sure no half-assed ad-hoc /proc substitute should go in, but there *are*
*real* problems, and just because you don't see them in your daily life doesn't
mean they don't exist.

These real problems could use a real solution.   And *some* of us are at least
going to *discuss* what such a solution could be.

If, or when, we arrive at something where at least some of us agree, then we
will see if it will be your decision to include it at all.  At this stage in
the discussion the final (draft) solution may not have anything to do with
filessytems at all.  We don't know - or at least I don't know.

> 
> Can it.  Get a dictionary and look up the meaning of "veto".

Just because data is in a filesystem doesn't mean it doesn't need structure
*in* the data too.

Get over it Al.

> 
> Oh, and as for "let's extend existing interfaces just because we had flunked
> 'strings in C'" - if you need Hurd, you know where to find it.

My approach would be more like making another interface that could eventually
gradually obsolete an older and inadequate one.   I see nothing in /proc that's
worth extending on, as it stands today.

Clearly you have no comprehension of the problems that people are working on
solving with the new proc changes (or, rather, ideas for changes).

That's too bad.  It would have been great to have constructive critisism from
someone with your experience.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
