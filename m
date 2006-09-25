Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750827AbWIYBUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750827AbWIYBUj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 21:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWIYBUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 21:20:39 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2825 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750827AbWIYBUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 21:20:38 -0400
Date: Mon, 25 Sep 2006 03:20:37 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16.30-pre1
Message-ID: <20060925012037.GD4547@stusta.de>
References: <20060922222300.GA5566@stusta.de> <20060922223859.GB21772@kroah.com> <20060922224735.GB5566@stusta.de> <20060924101255.GA4813@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924101255.GA4813@ucw.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 10:12:55AM +0000, Pavel Machek wrote:
> Hi!
> 
> > > > Andrew Burri:
> > > >       V4L/DVB: Add support for Kworld ATSC110
> > > > 
> > > > Curt Meyers:
> > > >       V4L/DVB: KWorld ATSC110: implement set_pll_input
> > > >       V4L/DVB: Kworld ATSC110: enable composite and svideo inputs
> > > >       V4L/DVB: Kworld ATSC110: initialize the tuner for analog mode on module load
> > > > 
> > > > Giampiero Giancipoli:
> > > >       V4L/DVB: Added support for the LifeView FlyDVB-T LR301 card
> > > > 
> > > > Hartmut Hackmann:
> > > >       V4L/DVB: Added support for the ADS Instant TV DUO Cardbus PTV331
> > > >       V4L/DVB: Added PCI IDs of 2 LifeView Cards
> > > >       V4L/DVB: Corrected CVBS input for the AVERMEDIA 777 DVB-T
> > > >       V4L/DVB: Added support for the new Lifeview hybrid cardbus modules
> > > >       V4L/DVB: TDA10046 Driver update
> > > >       V4L/DVB: TDA8290 update
> > > > 
> > > > Peter Hartshorn:
> > > >       V4L/DVB: Added support for the Tevion DVB-T 220RF card
> > > 
> > > Hm, all of these patches seems like these are new features being
> > > backported to the 2.6.16.y kernel, which is not really allowed under the
> > > current -stable rules.
> > > 
> > > Or are these patches just bugfixes that fix with the current -stable
> > > rules?
> > 
> > They add support for additional hardware to the saa7134 driver.
> > 
> > If you look at the actual diff there's not much that could cause any 
> > regression since nearly all of these change don't change anything for 
> > the already supported cards.
> > 
> > As long as there's not a serious risk of regressions, such additions are 
> > welcome in 2.6.16.
> 
> I believe you should not do that. Maybe risk of regression is small,
> but risk of adding non-working driver is not,

If it didn't work before and doesn't work after, nothing changed.

> and goal of -stable is
> to be stable, not to have feature-of-the-day.

No disagreement.

> 						Pavel

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

