Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbWGCTmq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWGCTmq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 15:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWGCTmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 15:42:46 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42244 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751257AbWGCTmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 15:42:45 -0400
Date: Mon, 3 Jul 2006 21:42:44 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz,
       Olaf Hering <olh@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: OSS driver removal, 2nd round
Message-ID: <20060703194244.GA26941@stusta.de>
References: <20060629192128.GE19712@stusta.de> <1151927579.13828.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151927579.13828.6.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2006 at 09:52:59PM +1000, Benjamin Herrenschmidt wrote:
> 
> > DMASOUND_PMAC
> > - Olaf Hering regarding regressions in SND_POWERMAC:
> >   Some tumbler models work only after one plug/unplug cycle of
> >   the headphone. early powerbooks report/handle the mute settings
> >   incorrectly. there are likely more bugs.
> 
> dmasound_pmac is crippled with bugs too... We should look at reported
> bug reports on snd-powermac (and snd-aoa which replaces the later for
> recent machines) and kill dmasound-pmac. I'm ok with that. snd-aoa is
> the only one to be properly maintained anyway, we'll add support for
> older machines to it over time and hopefully, it's a much saner codebase
> in the first place so handling weird machines regressions will be
> easier.

Thanks for this information.

I'll include DMASOUND_PMAC in the list of OSS drivers that might be 
removed in this round (if people report regressions in the ALSA drivers, 
this can still be undone (if someone observes such a regression, he 
should send me the bug number in the ALSA BTS (this is also what 
will be written in the help text of the OSS_OBSOLETE_DRIVER option))).

> Ben.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

