Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbUCNAc3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 19:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263230AbUCNAc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 19:32:29 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13523 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263229AbUCNAcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 19:32:23 -0500
Date: Sun, 14 Mar 2004 01:32:20 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Bloat report 2.6.3 -> 2.6.4
Message-ID: <20040314003220.GG14833@fs.tum.de>
References: <20040312204458.GJ20174@waste.org> <20040312152206.61604447.akpm@osdl.org> <20040312235349.GK20174@waste.org> <20040313170839.GV14833@fs.tum.de> <20040313173331.GO20174@waste.org> <20040313175712.GY14833@fs.tum.de> <20040313235940.GQ20174@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040313235940.GQ20174@waste.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2004 at 05:59:40PM -0600, Matt Mackall wrote:
> On Sat, Mar 13, 2004 at 06:57:13PM +0100, Adrian Bunk wrote:
>...
> > > But I think it's fair to say that new features that are on by default
> > > are in fact bloat in some sense.
> > 
> > Perhaps in some sense, but not in any interesting sense.
> > 
> > For the average computer you can buy at your supermarket today it isn't 
> > very interesting whether the kernel is bigger by 1 MB or not.
> >
> > People who need to care about the size of the kernel [1] use hand-tuned 
> > .config's that are far away from defconfig - and those people wouldn't 
> > enable unneeded features that are on by default.
> 
> And my coverage of creep in other _commonly used_ parts of the kernel
> would then be nil. Given that allyesconfig can't be expected to build
> a kernel on any given day, defconfig is the least arbitrary and most
> useful of arbitrary choices.
> 
> > You use a metric "size increase of a defconfig kernel [2]", and I simply 
> > claim that this metric doesn't measure anything useful for practical 
> > purposes.
> 
> defconfig is not an unreasonable approximation of features people use. 

What exactly is your goal?

As already said:
  *** For the average user, the size of the kernel doesn't matter *** [1]
  *** People that care about size don't use defconfig ***

> If something is added to defconfig, odds are that people will start
> using it. Not perfect, obviously, but I've yet to see anyone suggest
> anything else that actually provides some coverage.

Did you ever consider that your approach of an "automated scheme" might 
be an approach of very limited value?

cu
Adrian

[1] OK, 10 MB more would matter, but we are more in the ranges of 
    perhaps a few hundreds kB

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

