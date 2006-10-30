Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030539AbWJ3Pfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030539AbWJ3Pfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030538AbWJ3Pfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:35:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38927 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030536AbWJ3Pfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:35:44 -0500
Date: Mon, 30 Oct 2006 16:35:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Giacomo Catenazzi <cate@cateee.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: compiling error: WARNING: "mii_nway_restart" [drivers/usb/net/usbnet.ko] undefined!
Message-ID: <20061030153543.GK27968@stusta.de>
References: <4545A55F.2090807@cateee.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4545A55F.2090807@cateee.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2006 at 08:10:23AM +0100, Giacomo Catenazzi wrote:

> Since the git of yesterday (2.6.19-rc3-g7a20655b, but with changed
> config), I have this error:
> 
> Kernel: arch/i386/boot/bzImage is ready  (#114)
>   Building modules, stage 2.
>   MODPOST 98 modules
> WARNING: "mii_nway_restart" [drivers/usb/net/usbnet.ko] undefined!
> WARNING: "mii_link_ok" [drivers/usb/net/usbnet.ko] undefined!
> WARNING: "mii_ethtool_sset" [drivers/usb/net/usbnet.ko] undefined!
> WARNING: "mii_ethtool_gset" [drivers/usb/net/usbnet.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2

Thanks for your report.

That's a known bug that will be fixed soon.

As a workaround, please enable CONFIG_MII.

> ciao
> 	cate

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

