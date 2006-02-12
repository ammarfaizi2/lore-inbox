Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWBLRU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWBLRU0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 12:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWBLRU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 12:20:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40197 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750818AbWBLRUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 12:20:25 -0500
Date: Sun, 12 Feb 2006 18:20:24 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] update OBSOLETE_OSS_DRIVER schedule and dependencies
Message-ID: <20060212172024.GI30922@stusta.de>
References: <20060211145050.GA30922@stusta.de> <1139709891.23823.4.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139709891.23823.4.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2006 at 02:04:50AM +0000, Alan Cox wrote:
> On Sad, 2006-02-11 at 15:50 +0100, Adrian Bunk wrote:
> > This patch updates the schedule for the removal of drivers depending on 
> > OBSOLETE_OSS_DRIVER as follows:
> > - adjust OBSOLETE_OSS_DRIVER dependencie
> > - from the release of 2.6.16 till the release of 2.6.17:
> >   approx. two months for users to report problems with the ALSA
> >   drivers for the same hardware
> 
> Why are you obsessed with doing everything on what are (to end users)
> stupidly short time scales. It doesn't matter if OSS takes another year
> to finally go away so stop setting silly deadlines.

In my experience, scheduling things for removal at a far away date has 
nearly no effect - people still don't start complaining until it's being 
made clear that the code will really be removed, and that it will be 
removed soon.

It wouldn't be the first time that after a longer deprecation periodthe 
first person is complaining not before I'm sending the patch to remove 
the deprecated code.

In this case, we are talking about the OSS drivers with ALSA drivers for 
the same hardware. And a driver will not be removed if one person 
notifies me about one regression in the ALSA driver compared to the OSS 
driver.

And the positive effect of forcing people to report the regressions in 
ALSA drivers is already visible as improvements in the ALSA drivers.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

