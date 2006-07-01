Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751810AbWGAQB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbWGAQB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 12:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbWGAQB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 12:01:26 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:29970 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751810AbWGAQBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 12:01:25 -0400
Date: Sat, 1 Jul 2006 18:01:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Olivier Galibert <galibert@pobox.com>,
       James Courtier-Dutton <James@superbug.co.uk>,
       linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, perex@suse.cz,
       Olaf Hering <olh@suse.de>
Subject: Re: [Alsa-devel] OSS driver removal, 2nd round
Message-ID: <20060701160123.GB17588@stusta.de>
References: <20060629192128.GE19712@stusta.de> <44A54D8E.3000002@superbug.co.uk> <20060630163114.GA12874@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630163114.GA12874@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 06:31:14PM +0200, Olivier Galibert wrote:
> On Fri, Jun 30, 2006 at 05:13:02PM +0100, James Courtier-Dutton wrote:
> > Adrian Bunk wrote:
> > >- ALSA #1735 (OSS emulation 4-channel mode rear channels not working)
> > 
> > As the MAINTAINER of EMU10K1, I am happy for EMU10K1 driver to be 
> > removed from the kernel.
> > 
> > ALSA #1735 is now closed. All the apps the user was trying also support 
> > ALSA natively now, so OSS is not needed.
> 
> Are you joking ?

Besides what was already mentioned in this thread, let me add some 
points:
- most Linux applications already support ALSA
- kernel 2.6.0 with ALSA as default sound system was released in 2003
- the ALSA developers provide an in-kernel OSS emulation
- the ALSA developers provide an alternative user space OSS emulation
- there are many new soundcards without any OSS driver at all [1]

Compatibility is important, and it's nearly always working
(e.g. "aoss audacity" works for me perfectly).

There are only few exotic cornercases like ALSA #1735 where a subset of 
the OSS functionality is not working in the OSS emulation - and I doubt 
it would be worth putting much effort into fixing such cornercases.

>   OG.

cu
Adrian

[1] we are talking about the in-kernel OSS drivers, not the
    commercial OSS

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

