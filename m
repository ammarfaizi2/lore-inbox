Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbVLDL46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbVLDL46 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 06:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVLDL46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 06:56:58 -0500
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:27826 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S932160AbVLDL46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 06:56:58 -0500
Date: Sun, 4 Dec 2005 12:56:50 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204115650.GA15577@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com> <9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490512031948m26b04d3ds9fbc652893ead40@mail.gmail.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Dec 2005, Jesper Juhl wrote:

> On 12/3/05, Greg KH <greg@kroah.com> wrote:
> > On Sat, Dec 03, 2005 at 03:29:54PM +0100, Jesper Juhl wrote:
> > >
> > > Why can't this be done by distributors/vendors?
> >
> > It already is done by these people, look at the "enterprise" Linux
> > distributions and their 5 years of maintance (or whatever the number
> > is.)
> >
> > If people/customers want stability, they already have this option.
> >
> 
> Yes, I know this is what's done with the "enterprise" distro kernels.
> Perhaps I should have phrased it "Why can't this job just stay with
> vendors".

Because this is just shifting the blame for and work to make up for the
upstream not providing a stable tree on somebody else and prescinds from
the fact that many people are apparently unhappy with 2.6.X policies.

I cannot see a project issuing "stable releases" if every other
developer bleats "let the distro snapshot and backport fixes on their
own". This is exactly the point that turns away half of those who hadn't
been scared away by the "Linux has no uniform userland" problem yet.

2.6.0 is now nearly two years old, perhaps the current discussions mean
that 2.7/2.8 are long overdue - some people feel the need for more
radical code changes, which are 2.7 stuff.

The problem is the upstream breaking backwards compatibility for no good
reason. This can sometimes be a genuine unintended regression (aka.
bug), but quite often this is deliberate breakage because someone wants
to get rid of cruft. While the motivation is sound, breaking between
2.6.N and 2.6.M must stop.

One of the ideas of the new development style and versioning scheme was
to have 2.6 progress faster than 2.3 or 2.5, and to have shorter release
cycles.  It was found to introduce way too much breakage. Linus's
relatively new policy "merge new stuff only during the fortnight after
release, then fix up" is a concession to these observations that too
many things break if there is a constant influx of feature changes.

-- 
Matthias Andree
