Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282245AbRKWVJ4>; Fri, 23 Nov 2001 16:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282244AbRKWVJi>; Fri, 23 Nov 2001 16:09:38 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:27603 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S282243AbRKWVJ2>;
	Fri, 23 Nov 2001 16:09:28 -0500
Date: Fri, 23 Nov 2001 22:09:02 +0100
From: David Weinehall <tao@acc.umu.se>
To: Andrew Morton <akpm@zip.com.au>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
        Daniel Phillips <phillips@bonn-fries.net>, war <war@starband.net>,
        Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: Which gcc version?
Message-ID: <20011123220902.B5770@khan.acc.umu.se>
In-Reply-To: <3BFEAE22.1CE8DE5B@zip.com.au>, <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk> <5.1.0.14.2.20011123185333.00afd920@pop.cus.cam.ac.uk> <5.1.0.14.2.20011123185333.00afd920@pop.cus.cam.ac.uk> <E167M0I-0002PD-00@starship.berlin> <5.1.0.14.2.20011123201824.05610ec0@pop.cus.cam.ac.uk> <3BFEB300.680A55A7@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BFEB300.680A55A7@zip.com.au>; from akpm@zip.com.au on Fri, Nov 23, 2001 at 12:35:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 12:35:12PM -0800, Andrew Morton wrote:
> Anton Altaparmakov wrote:
> > 
> > Hi Andrew,
> > 
> > At 20:14 23/11/01, Andrew Morton wrote:
> > >Daniel Phillips wrote:
> > > >
> > > > If there is a performance hit, it's not enough to worry about.
> > >
> > >except egcs-1.1.2 (2.91.6) compiles stuff at almost twice the speed
> > >of gcc3.  The person who breaks egcs-1.1.2 for kernel builds owes
> > >me a quad Xeon, thanks very much.
> > 
> > Have you read the current Documentation/Changes? It says "the 2.5 tree is
> > likely to drop egcs-1.1.2 workarounds". Whoever wrote that seems to be
> > wanting to break it in the near future...
> 
> Well that's great news.  To whom do I send my shipping address?
> 
> Actually, I have negligible interest in working on something which
> won't be useful to real people for three years, so that works out,
> doesn't it?

Dropping workarounds for egcs-1.1.2 doesn't mean that gcc-2.95.3+ or
gcc-2.96-x (x > whatever the infamed version nr was) will stop working.

Thus, there's a perfectly fine alternative to gcc3. gcc3 is too broken
to use on many platforms. Then again, it's the only alternative for
others... Sigh.

As long as gcc-2.95.3 is the recommended minimum version, I'm
happy.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
