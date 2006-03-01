Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWCAR6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWCAR6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 12:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWCAR6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 12:58:55 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:60164 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030222AbWCAR6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 12:58:54 -0500
Date: Wed, 1 Mar 2006 18:58:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: "James C. Georgas" <jgeorgas@rogers.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] make UNIX a bool
Message-ID: <20060301175852.GA4708@stusta.de>
References: <20060225160150.GX3674@stusta.de> <1141078686.28136.20.camel@Rainsong.home> <20060227222926.GX3674@stusta.de> <200602282209.52638.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602282209.52638.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2006 at 10:09:52PM -0500, Dmitry Torokhov wrote:
> On Monday 27 February 2006 17:29, Adrian Bunk wrote:
> > On Mon, Feb 27, 2006 at 05:18:06PM -0500, James C. Georgas wrote:
> > > On Sat, 2006-25-02 at 17:01 +0100, Adrian Bunk wrote:
> > > > CONFIG_UNIX=m doesn't make much sense.
> > > 
> > > I've been building it as a module forever. I often load kernels from
> > > floppy disk, and building CONFIG_UNIX as a module often makes the
> > > difference between the kernel fitting or not fitting on the disk. Could
> > > we please keep this functionality?
> > 
> > If size is important for you, you should consider completely disabling 
> > module support in your kernels:
> > 
> > In my testing, disabling module support brings you a space gain in the 
> > range of 10%.
> >
> 
> This only matters when you tight on memory - in the scenario above memory
> may not be a great concern but kernel image size is because modules could
> go on other medium.

It does also matter in the kernel image size case, since you have to put 
enough modules to the other medium for having a effect bigger than the
kernel image size increase from setting CONFIG_MODULES=y.

> Dmitry

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

