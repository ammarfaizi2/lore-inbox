Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757059AbWLCWMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757059AbWLCWMA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 17:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757265AbWLCWMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 17:12:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:58384 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1757059AbWLCWL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 17:11:59 -0500
Date: Sun, 3 Dec 2006 23:12:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kbuild: add 3 more header files to get properly "unifdef"ed
Message-ID: <20061203221203.GC3442@stusta.de>
References: <Pine.LNX.4.64.0611300459290.12927@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611300459290.12927@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 05:03:56AM -0500, Robert P. J. Day wrote:
> 
>   Add 3 more files to get "unifdef"ed when creating sanitized headers
> with "make headers_install".

Your patch should also remove them from header-y.

> Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>
> 
> ---
> 
> diff --git a/include/linux/Kbuild b/include/linux/Kbuild
> index a1155a2..b6bc50c 100644
> --- a/include/linux/Kbuild
> +++ b/include/linux/Kbuild
> @@ -225,6 +225,7 @@ unifdef-y += if_bridge.h
>  unifdef-y += if_ec.h
>  unifdef-y += if_eql.h
>  unifdef-y += if_ether.h
> +unifdef-y += if_fddi.h
>  unifdef-y += if_frad.h
>  unifdef-y += if_ltalk.h
>  unifdef-y += if_pppox.h
> @@ -286,6 +287,7 @@ unifdef-y += nvram.h
>  unifdef-y += parport.h
>  unifdef-y += patchkey.h
>  unifdef-y += pci.h
> +unifdef-y += personality.h
>  unifdef-y += pktcdvd.h
>  unifdef-y += pmu.h
>  unifdef-y += poll.h
> @@ -341,6 +343,7 @@ unifdef-y += videodev.h
>  unifdef-y += wait.h
>  unifdef-y += wanrouter.h
>  unifdef-y += watchdog.h
> +unifdef-y += wireless.h
>  unifdef-y += xfrm.h
>  unifdef-y += zftape.h

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

