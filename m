Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbTFTSut (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 14:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTFTSut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 14:50:49 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:29967 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264396AbTFTSuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 14:50:40 -0400
Date: Fri, 20 Jun 2003 21:04:39 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@suse.de>,
       clemens-dated-1056963973.bf26@endorphin.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Initial Vector Fix for loop.c.
Message-ID: <20030620210439.A3282@pclin040.win.tue.nl>
References: <20030620090612.GA1322@ghanima.endorphin.org.suse.lists.linux.kernel> <p73u1al3xlw.fsf@oldwotan.suse.de> <20030620105640.10ab68a4.akpm@digeo.com> <1056132854.29696.1.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1056132854.29696.1.camel@rth.ninka.net>; from davem@redhat.com on Fri, Jun 20, 2003 at 11:14:14AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 20, 2003 at 11:14:14AM -0700, David S. Miller wrote:
> On Fri, 2003-06-20 at 10:56, Andrew Morton wrote:
> > Andi Kleen <ak@suse.de> wrote:
> > >
> > > > So go for it. Fix it before 2.6.x is out and we're stuck with this crap
> > >  > again. 
> > > 
> > >  This will break existing crypto loop installations, making
> > >  the existing encrypted image unreadable.
> > 
> > I think we should just live with that breakage Andi.  You're suggesting
> > that we retain compatibility with something which was never merged into the
> > kernel.  That is asking too much.
> 
> There was effectively no cryptoloop support in the vanilla
> kernel.  Andi is totally right here.  We should be compatible
> with what people actually used, which were the external cryptoloop
> patches.
> 
> Nobody, and I mean nobody, has a cryptoloop based upon the IV
> selection done in vanilla kernels.

Ha David - you repeat what Clemens was saying and Andi disputed.

Andries


[I watch what is happening with interest - have delayed util-linux 2.12
in the hope of being able to come with something that works out of the
box together with a sufficiently recent kernel. A handful of loop
patches are needed. I hope they will be applied and documented one
by one.]


