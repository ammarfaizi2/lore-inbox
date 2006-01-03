Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWACThk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWACThk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWACThk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:37:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:11280 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932499AbWACThi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:37:38 -0500
Date: Tue, 3 Jan 2006 20:37:36 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Tomasz Torcz <zdzichu@irc.pl>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Andi Kleen <ak@suse.de>, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060103193736.GG3831@stusta.de>
References: <20050726150837.GT3160@stusta.de> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <200601031716.13409.s0348365@sms.ed.ac.uk> <20060103192449.GA26030@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060103192449.GA26030@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2006 at 08:24:49PM +0100, Olivier Galibert wrote:
> On Tue, Jan 03, 2006 at 05:16:13PM +0000, Alistair John Strachan wrote:
> > This argument is basically watered down with devfs, udev, sysfs, etc. which 
> > all have exactly the same issues. Should a crippled OSS API be the way 
> > forward for Linux? I think not.
> 
> And they're getting some real backlash because of that now.  Hell,
> Linus' message was about udev in the first place.

The udev breakages might not have been nice, but OSS/ALSA is a 
completely different issue:

OSS has been deprecated since ALSA was merged into the Linux kernel 
_four years ago_.

And I'm only talking about removing drivers _with ALSA drivers for the 
same hardware available_.

> As for the OSS API being crippled, I'd take the 3 ioctl calls you need
> to setup a simple stereo 16bits output with OSS than the 13 ALSA
> library calls anyday.  Especially with the impressive lack of
> documentation you get about what the hell is a period, or what you can
> do except aborting when you get an error.
>...

For a general OSS<->ALSA discussion, you are five years too late.

>   OG.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

