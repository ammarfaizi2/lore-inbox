Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVGZQJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVGZQJK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261908AbVGZQGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 12:06:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:30470 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261940AbVGZQEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 12:04:31 -0400
Date: Tue, 26 Jul 2005 18:04:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20050726160420.GV3160@stusta.de>
References: <20050726150837.GT3160@stusta.de> <42E65B34.9080700@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E65B34.9080700@pobox.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2005 at 11:48:04AM -0400, Jeff Garzik wrote:
> Adrian Bunk wrote:
> >This patch schedules obsolete OSS drivers (with ALSA drivers that 
> >support the same hardware) for removal.
> >
> >
> >Signed-off-by: Adrian Bunk <bunk@stusta.de>
> >
> >---
> >
> >I've Cc'ed the people listed in MAINTAINERS as being responsible for one 
> >or more of these drivers, and I've also Cc'ed the ALSA people.
> >
> >Please tell if any my driver selections is wrong.
> >
> > Documentation/feature-removal-schedule.txt |    7 +
> > sound/oss/Kconfig                          |   79 ++++++++++++---------
> > 2 files changed, 54 insertions(+), 32 deletions(-)
> 
> Please CHECK before doing this.

I did (but I don't claim that I didn't miss anything).

> ACK for via82cxxx.

Thanks.

> NAK for i810_audio:  ALSA doesn't have all the PCI IDs (which must be 
> verified -- you cannot just add the PCI IDs for some hardware)

I though I found every single PCI ID from this driver in ALSA.
Which PCI IDs did I miss?

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

