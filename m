Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261383AbVHBFxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261383AbVHBFxY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 01:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVHBFxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 01:53:24 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:41999 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261383AbVHBFxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 01:53:18 -0400
Date: Tue, 2 Aug 2005 07:37:39 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove support for gcc < 3.2
Message-ID: <20050802053739.GA20363@alpha.home.local>
References: <20050731222606.GL3608@stusta.de> <20050801030145.GE20899@kurtwerks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801030145.GE20899@kurtwerks.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 11:01:45PM -0400, Kurt Wall wrote:
> On Mon, Aug 01, 2005 at 12:26:07AM +0200, Adrian Bunk took 109 lines to write:
> > This patch removes support for gcc < 3.2 .
> > 
> > The advantages are:
> > - reducing the number of supported gcc versions from 8 to 4 [1]
> >   allows the removal of several #ifdef's and workarounds
> > - my impression is that the older compilers are only rarely
> >   used, so miscompilations of a driver with an old gcc might
> >   not be detected for a longer amount of time
> > 
> > My personal opinion about the time and space a compilation requires is 
> > that this is no longer that much of a problem for modern hardware, and 
> > in the worst case you can compile the kernels for older machines on more 
> > recent machines.
> 
> Environments that require kernel compilation, often multiple times, 
> testing, benefit from shorter compile times. It can be the difference
> between, say, completing a test suite overnight instead of having to
> wait until tomorrow afternoon. Keeping 2.95, at least, has some value
> in such environments.

I *do* still use 2.95 a lot, and I'm not alone, judging from people
around me. 2.95 has been the reference for a very long time, that's
why it's still so much present. 3.0 and 3.1 (even 3.2) have been
there for a very short time frame, but 2.95 and 3.3 really seem to
be references compilers.

So please keep support for 2.95.

Cheers,
Willy

