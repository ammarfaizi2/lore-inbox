Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWCROgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWCROgk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 09:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWCROgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 09:36:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26126 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750808AbWCROgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 09:36:40 -0500
Date: Sat, 18 Mar 2006 15:36:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marcus Hartig <m.f.h@web.de>
Cc: linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, perex@suse.cz,
       alsa-devel@lists.sourceforge.net
Subject: Re: 2.6.16-rcX - no more sound with ALSA snd-hda-intel / Sigmatel
Message-ID: <20060318143637.GB7471@stusta.de>
References: <441C13C1.7000902@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441C13C1.7000902@web.de>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2006 at 03:05:53PM +0100, Marcus Hartig wrote:

> Hello!

Hi Marcus!

> Since the 2.6.16.rcX kernel versions I have no more sound with the ALSA 
> snd-hda-intel driver. All modules load without errors, all  channels are 
> unmuted, no errors in any log, but sound is death! :(
> 
> With kernel 2.6.15.6 (ALSA 1.0.10rc3) the sound is working, only that 
> the headphones output is not doing any noise and then the internal 
> speakers are not muted. With mplayer and ALSA sound output the CPU load 
> goes very high and it stutters, with OSS output in mplayer OSS device 
> not more.
> 
> This is an new DELL Inspiron 9400 Dual Core notebook with Sigmatel STAC 
> 92XX C-Major HD Audio.
> 
> lspci:
> 00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High 
> Definition Audio Controller (rev 01) Subsystem: Dell Unknown device 01cd
> 
> Module options:
> snd_hda_intel position_fix=1 index=0
>...

Does the patch from [1] help?

> Greetings,
> Marcus

cu
Adrian

[1] http://lkml.org/lkml/2006/3/17/279

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

