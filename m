Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbUKOAeL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbUKOAeL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 19:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbUKOAeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 19:34:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29962 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261386AbUKOAeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 19:34:07 -0500
Date: Mon, 15 Nov 2004 01:12:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] OSS via82cxxx_audio.c: enable procfs code
Message-ID: <20041115001203.GX2249@stusta.de>
References: <20041114022446.GK2249@stusta.de> <1100468548.25615.2.camel@localhost.localdomain> <4197F2D9.8050409@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4197F2D9.8050409@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 14, 2004 at 07:05:45PM -0500, Jeff Garzik wrote:
> Alan Cox wrote:
> >On Sul, 2004-11-14 at 02:24, Adrian Bunk wrote:
> >
> >>The patch below enables the procfs code in sound/oss/via82cxxx_audio.c 
> >>if CONFIG_PROC_FS=y.
> >
> >
> >I don't see what needs fixing here. Generally the /proc file shouldnt
> >exist
> 
> Existing procfs code in via82cxxx_audio is never enabled, due to removal 
> of CONFIG_SOUND_VIA82CXXX_PROCFS:
> 
> #if defined(CONFIG_PROC_FS) && \
>     defined(CONFIG_SOUND_VIA82CXXX_PROCFS)
> #define VIA_PROC_FS 1
> #endif
> 
> However, I don't mind if someone removes the procfs code completely.

How else is this information available?

> 	Jeff

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

