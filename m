Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVB0A21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVB0A21 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVB0A21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:28:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:45061 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261314AbVB0A2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:28:22 -0500
Date: Sun, 27 Feb 2005 01:28:14 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] deprecate EXPORT_SYMBOL(do_settimeofday)
Message-ID: <20050227002814.GP3311@stusta.de>
References: <20050224233742.GR8651@stusta.de> <20050224212448.367af4be.akpm@osdl.org> <20050226133337.GK3311@stusta.de> <20050226144635.B7151@flint.arm.linux.org.uk> <20050226162341.GN3311@stusta.de> <20050226164613.E7151@flint.arm.linux.org.uk> <20050226171325.GO3311@stusta.de> <20050226172018.A15124@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050226172018.A15124@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2005 at 05:20:18PM +0000, Russell King wrote:
> On Sat, Feb 26, 2005 at 06:13:25PM +0100, Adrian Bunk wrote:
> > You call it "breakage" because you have a relatively dogmatic view 
> > regarding the selection of user visible symbols.
> > Other people care more about the usability of the kernel config system, 
> > and therefore a select of one of the I2C* options is quite common from 
> > both outside and inside the i2c subsystem.
> > 
> > There are two possbile situations:
> > - these RTC drivers are nice add-ons that could be shown if all
> >   required I2C* options are already enabled
> > - these RTC drivers are pretty essential and should really be enabled
> >   on the platforms they are for
> > 
> > Which of these two cases describes the situation of these RTC drivers?
> 
> Since RTCs aren't _actually_ essential for Linux kernel operation,
> the former clearly applies.
> 
> Other people may have differing opinions, but having worked with a
> large number of SoC platforms where the RTC is reset when the SoC
> is reset, or even platforms where there is no RTC at all, it brings
> a different perspective to this that people who have only ever
> experienced systems where the RTC is always true do not have.

No problem with this.

I'm hereby withdrawing my patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

