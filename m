Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVADRrd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVADRrd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 12:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbVADRrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 12:47:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:41488 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261798AbVADRrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 12:47:15 -0500
Date: Tue, 4 Jan 2005 18:47:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Rik van Riel <riel@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050104174712.GI3097@stusta.de>
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl> <Pine.LNX.4.61.0501031011410.25392@chimarrao.boston.redhat.com> <20050103153438.GF2980@stusta.de> <1104767943.4192.17.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104767943.4192.17.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 04:59:02PM +0100, Arjan van de Ven wrote:
> On Mon, 2005-01-03 at 16:34 +0100, Adrian Bunk wrote:
> > On Mon, Jan 03, 2005 at 10:18:47AM -0500, Rik van Riel wrote:
> > > On Sun, 2 Jan 2005, Andries Brouwer wrote:
> > > 
> > > >You change some stuff. The bad mistakes are discovered very soon.
> > > >Some subtler things or some things that occur only in special
> > > >configurations or under special conditions or just with
> > > >very low probability may not be noticed until much later.
> > > 
> > > Some of these subtle bugs are only discovered a year
> > > after the distribution with some particular kernel has
> > > been deployed - at which point the kernel has moved on
> > > so far that the fix the distro does might no longer
> > > apply (even in concept) to the upstream kernel...
> > > 
> > > This is especially true when you are talking about really
> > > big database servers and bugs that take weeks or months
> > > to trigger.
> > 
> > If at this time 2.8 was already released, the 2.8 kernel available at 
> > this time will be roughly what 2.6 would have been under the current 
> > development model, and 2.6 will be a rock stable kernel.
> 
> as long as more things get fixed than new bugs introduced (and that
> still seems to be the case) things only improve in 2.6. 
>...

My main point is not the number of bugs, but the number of regressions.

If you do install a new machine or do a major upgrade (e.g. 2.4 -> 2.6) 
you do some testing whether everything works as expected and if 
something doesn't work, you try to get it working or work around the 
problem.

Inside a stable kernel series (e.g. 2.6.x -> 2.6.y) you hope that an 
upgrade doesn't contain regressions and goes smoothly.

Even the introduction of CONFIG_BLK_DEV_UB in 2.6.9 [1] has bitten 
several people I know.

cu
Adrian

[1] this is not technically a bug, but e.g. similar common problems
    for users in the input code were already fixed during 2.5 long
    before 2.6.0

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

