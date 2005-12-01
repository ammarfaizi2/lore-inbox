Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVLAUO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVLAUO6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVLAUO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:14:58 -0500
Received: from witte.sonytel.be ([80.88.33.193]:32240 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932432AbVLAUO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:14:57 -0500
Date: Thu, 1 Dec 2005 21:14:35 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Olaf Hering <olh@suse.de>, Roman Zippel <zippel@linux-m68k.org>
cc: Paul Mackeras <paulus@samba.org>,
       Linux/PPC Development <linuxppc-dev@ozlabs.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: correct the NR_CPUS description text
In-Reply-To: <20051201201010.GA2741@suse.de>
Message-ID: <Pine.LNX.4.62.0512012113190.17317@pademelon.sonytel.be>
References: <20051201201010.GA2741@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2005, Olaf Hering wrote:
> Update the help text to match the allowed range.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>
> 
>  arch/powerpc/Kconfig |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-2.6.15-rc4-olh/arch/powerpc/Kconfig
> ===================================================================
> --- linux-2.6.15-rc4-olh.orig/arch/powerpc/Kconfig
> +++ linux-2.6.15-rc4-olh/arch/powerpc/Kconfig
> @@ -227,7 +227,7 @@ config SMP
>  	  If you don't know what to do here, say N.
>  
>  config NR_CPUS
> -	int "Maximum number of CPUs (2-32)"
> +	int "Maximum number of CPUs (2-128)"
>  	range 2 128
>  	depends on SMP
>  	default "32" if PPC64

Shouldn't kconfig (be enhanced to) add the range to the help text
automatically, to avoid problems like this?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
