Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265984AbUAQCPp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 21:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265988AbUAQCPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 21:15:45 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:22252 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265984AbUAQCPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 21:15:41 -0500
Date: Sat, 17 Jan 2004 03:15:32 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Richard B. Johnson" <root@chaos.analogic.com>, robert@schwebel.de
Cc: cliff white <cliffw@osdl.org>, piggin@cyberone.com.au, mpm@selenic.com,
       linux-kernel@vger.kernel.org
Subject: Re: [1/4] better i386 CPU selection
Message-ID: <20040117021532.GH12027@fs.tum.de>
References: <20040106054859.GA18208@waste.org> <3FFA56D6.6040808@cyberone.com.au> <20040106064607.GB18208@waste.org> <3FFA5ED3.6040000@cyberone.com.au> <20040110004625.GB25089@fs.tum.de> <20040110005232.GD25089@fs.tum.de> <20040116111501.70200cf3.cliffw@osdl.org> <Pine.LNX.4.53.0401161425110.31018@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0401161425110.31018@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 16, 2004 at 02:32:39PM -0500, Richard B. Johnson wrote:
> On Fri, 16 Jan 2004, cliff white wrote:
> 
> > On Sat, 10 Jan 2004 01:52:32 +0100
> > Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> >
> > > Changes:
> 
> > > - AMD Elan is a different subarch, you can't configure a kernel that
> > >   runs on both the AMD Elan and other i386 CPUs
> 
> NO! NO!  This prevents development of an AMD embeded system on an
> "ordinary" machine like this one (Pentium IV). The fact that the
> timer runs at a different speed means nothing, one just sets the
> workstation time every day. Please do NOT do this. It prevents
> important usage.

What problems exacly are you referring to?

Besides the AMD Elan cpufreq driver I see nothing where CONFIG_MELAN
gave you any real difference (except your highest goal is to avoid a
recompilation when switching from the Pentium 4 to the AMD Elan - but I
doubt the really "prevents development").

But I'm not religious about this issue. Let Robert decide, the Elan 
support is his child.

> > > - added optimizing CFLAGS for the AMD Elan
> 
> There are no such different "optimizations" for ELAN.

What's wrong wih the -march=i486 Robert suggested?

> Cheers,
> Dick Johnson

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

