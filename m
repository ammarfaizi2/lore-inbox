Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261271AbTCJK12>; Mon, 10 Mar 2003 05:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbTCJK12>; Mon, 10 Mar 2003 05:27:28 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:46248 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261271AbTCJK11>;
	Mon, 10 Mar 2003 05:27:27 -0500
Date: Mon, 10 Mar 2003 11:36:29 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: akpm@digeo.com, Tom Rini <trini@kernel.crashing.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] move CONFIG_SWAP around
In-Reply-To: <200303090406.h2946Tj06060@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0303101133380.8949-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Mar 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1148, 2003/03/08 19:25:21-08:00, akpm@digeo.com
> 
> 	[PATCH] move CONFIG_SWAP around
> 	
> 	Patch from Tom Rini <trini@kernel.crashing.org>
> 	
> 	Take CONFIG_SWAP out of the top-level menu into the general setup menu.  Make
> 	it dependent on CONFIG_MMU and common to all architectures.
> 
> 
> --- a/init/Kconfig	Sat Mar  8 20:06:31 2003
> +++ b/init/Kconfig	Sat Mar  8 20:06:31 2003
> @@ -37,6 +37,16 @@
>  
>  menu "General setup"
>  
> +config SWAP
> +	bool "Support for paging of anonymous memory"
> +	depends on MMU
> +	default y
> +	help
> +	  This option allows you to choose whether you want to have support
> +	  for socalled swap devices or swap files in your kernel that are
> +	  used to provide more virtual memory than the actual RAM present
> +	  in your computer.  If unusre say Y.
                                ^^^^^^
unsure

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

