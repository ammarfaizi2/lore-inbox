Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbVH3OuZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbVH3OuZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 10:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVH3OuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 10:50:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58378 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932163AbVH3OuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 10:50:24 -0400
Date: Tue, 30 Aug 2005 16:50:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: David Hollis <dhollis@davehollis.com>
Cc: Diego Calleja <diegocg@gmail.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       stephane.wirtel@belgacom.net, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.6.13 : __check_region is deprecated
Message-ID: <20050830145022.GA3708@stusta.de>
References: <20050829231417.GB2736@localhost.localdomain> <20050830012813.7737f6f6.diegocg@gmail.com> <9a8748490508291634416a18bc@mail.gmail.com> <20050830015513.62ee2c0c.diegocg@gmail.com> <1125412117.4801.18.camel@dhollis-lnx.sunera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1125412117.4801.18.camel@dhollis-lnx.sunera.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 10:28:37AM -0400, David Hollis wrote:
> On Tue, 2005-08-30 at 01:55 +0200, Diego Calleja wrote:
> > El Tue, 30 Aug 2005 01:34:25 +0200,
> > Jesper Juhl <jesper.juhl@gmail.com> escribió:
> > 
> > > I don't see why we should break a bunch of drivers by doing that.
> > > Much better, in my oppinion, to fix the few remaining drivers still
> > > using check_region and *then* kill it. Even unmaintained drivers may
> > 
> > I'd usually agree with you, but check_region has been deprecated for so many
> > time; I was just wondering myself if people will bother to fix the remaining
> > drivers without some "incentive" 
> 
> Shouldn't it be (or have been) added to the
> Documentation/feature-removal-schedule.txt then so it could be
> deprecated and removed through the proper mechanisms.

Why?

Although there is a possible (but not very likely) race condition the 
drivers usually work fine (they shouldn't work worse than at the time 
when they were added).

> David Hollis <dhollis@davehollis.com>

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

