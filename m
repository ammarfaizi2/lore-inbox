Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268275AbUJPJbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268275AbUJPJbr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 05:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268279AbUJPJbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 05:31:46 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30988 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268275AbUJPJbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 05:31:44 -0400
Date: Sat, 16 Oct 2004 11:31:12 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4-bk3 - make[3]: *** [drivers/char/drm/gamma_drv.o] Error 1
Message-ID: <20041016093112.GA5307@stusta.de>
References: <4170C664.9000703@vgertech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4170C664.9000703@vgertech.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2004 at 07:57:40AM +0100, Nuno Silva wrote:
> 
>   LD      drivers/char/drm/built-in.o
>   CC [M]  drivers/char/drm/gamma_drv.o
> In file included from drivers/char/drm/gamma_drv.c:42:
> drivers/char/drm/gamma_context.h: In function 
> `gamma_context_switch_complete':
> drivers/char/drm/gamma_context.h:193: error: structure has no member 
> named `next_buffer'
>...
> make[3]: *** [drivers/char/drm/gamma_drv.o] Error 1
>...
> .config is attached
> 
> Thanks,
> Nuno Silva
>...
> CONFIG_EXPERIMENTAL=y
> # CONFIG_CLEAN_COMPILE is not set
> CONFIG_BROKEN=y
>...
> CONFIG_DRM_GAMMA=m
>...


If you answer "yes" to

  "Prompt for development and/or incomplete code/drivers"

and "no" to

  "Select only drivers expected to compile cleanly"

it souldn't be a big surprise if a driver doesn't compile.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

