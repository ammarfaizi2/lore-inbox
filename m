Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbTCCJrn>; Mon, 3 Mar 2003 04:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262469AbTCCJrn>; Mon, 3 Mar 2003 04:47:43 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:29358 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S262394AbTCCJrk>;
	Mon, 3 Mar 2003 04:47:40 -0500
Date: Mon, 3 Mar 2003 10:57:41 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@sgi.com>
cc: akpm@digeo.com, Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] allow CONFIG_SWAP=n for i386
In-Reply-To: <200303030506.h2356Z627107@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0303031056070.10724-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1050, 2003/03/02 20:37:34-08:00, akpm@digeo.com
> 
> 	[PATCH] allow CONFIG_SWAP=n for i386
> 	
> 	Patch from Christoph Hellwig <hch@sgi.com>

Since 2.5.x has entered the spell checking phase...

> diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
> --- a/arch/i386/Kconfig	Sun Mar  2 21:06:38 2003
> +++ b/arch/i386/Kconfig	Sun Mar  2 21:06:38 2003
> @@ -19,8 +19,13 @@
>  	default y
>  
>  config SWAP
> -	bool
> +	bool "Support for paging of anonymous memory"
>  	default y
> +	help
> +	  This option allows you to choose whether you want to have support
> +	  for socalled swap devices or swap files in your kernel that are
              ^^^^^^^^
	      so-called?

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

