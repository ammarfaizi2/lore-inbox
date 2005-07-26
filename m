Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVGZSQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVGZSQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 14:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVGZSO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 14:14:27 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13576 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261998AbVGZSNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 14:13:35 -0400
Date: Tue, 26 Jul 2005 20:13:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20050726181326.GY3160@stusta.de>
References: <20050726150837.GT3160@stusta.de> <42E65B34.9080700@pobox.com> <200507261303.40052.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507261303.40052.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 01:03:39PM -0400, Gene Heskett wrote:
> On Tuesday 26 July 2005 11:48, Jeff Garzik wrote:
> >Adrian Bunk wrote:
> >> This patch schedules obsolete OSS drivers (with ALSA drivers that
> >> support the same hardware) for removal.
> >>
> >>
> >> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >>
> >> ---
> >>
> >> I've Cc'ed the people listed in MAINTAINERS as being responsible
> >> for one or more of these drivers, and I've also Cc'ed the ALSA
> >> people.
> >>
> >> Please tell if any my driver selections is wrong.
> >>
> >>  Documentation/feature-removal-schedule.txt |    7 +
> >>  sound/oss/Kconfig                          |   79
> >> ++++++++++++--------- 2 files changed, 54 insertions(+), 32
> >> deletions(-)
> >
> >Please CHECK before doing this.
> >
> >ACK for via82cxxx.
> 
> I'm still running a box that needs this one.  The darned thing refuses 
> to die. :)
>...


Why doesn't the ALSA driver work for you?


> Cheers, Gene


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

