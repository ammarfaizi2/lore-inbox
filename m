Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263115AbVCESRg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263115AbVCESRg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 13:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbVCESRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 13:17:33 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2055 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263193AbVCESNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:13:36 -0500
Date: Sat, 5 Mar 2005 19:13:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Telemaque Ndizihiwe <telendiz@eircom.net>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removes unused variable from /sound/usb/usx2y/usbusx2yaudio.c
Message-ID: <20050305181335.GG6373@stusta.de>
References: <Pine.LNX.4.62.0503051720430.792@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0503051720430.792@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 06:02:27PM +0000, Telemaque Ndizihiwe wrote:
> 
> This Patch removes unused variable from /sound/usb/usx2y/usbusx2yaudio.c 
> in kernel 2.6.11
> 
> Signed-off-by: Telemaque Ndizihiwe <telendiz@eircom.net>
> 
> --- linux-2.6.11/sound/usb/usx2y/usbusx2yaudio.c.orig	2005-03-05 
> 17:05:20.165551616 +0000
> +++ linux-2.6.11/sound/usb/usx2y/usbusx2yaudio.c	2005-03-05 
> 17:09:43.072583672 +0000
> @@ -415,7 +415,6 @@ static int usX2Y_urbs_allocate(snd_usX2Y
>  	unsigned int pipe;
>  	int is_playback = subs == 
>  	subs->usX2Y->subs[SNDRV_PCM_STREAM_PLAYBACK];
>  	struct usb_device *dev = subs->usX2Y->chip.dev;
> -	struct usb_host_endpoint *ep;
>...

Already fixed in the ALSA tree and therefore in -mm.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

