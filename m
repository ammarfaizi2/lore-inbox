Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261951AbREPNnm>; Wed, 16 May 2001 09:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261954AbREPNnc>; Wed, 16 May 2001 09:43:32 -0400
Received: from aeon.tvd.be ([195.162.196.20]:19094 "EHLO aeon.tvd.be")
	by vger.kernel.org with ESMTP id <S261951AbREPNnX>;
	Wed, 16 May 2001 09:43:23 -0400
Date: Wed, 16 May 2001 15:41:40 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "H . J . Lu" <hjl@lucon.org>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: export linux_logo_bw for hgafb.c
In-Reply-To: <20010515160232.A19573@lucon.org>
Message-ID: <Pine.LNX.4.05.10105161541210.23225-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, H . J . Lu wrote:
> Here is a patch for 2.4.4. linux_logo_bw is used in hgafb.c, which
> can be compiled as a module. But linux_logo_bw is not exported.
> 
> 
> H.J.
> ---
> --- linux-2.4.4-ac9/drivers/video/fbcon.c.mod	Tue May 15 15:39:17 2001
> +++ linux-2.4.4-ac9/drivers/video/fbcon.c	Tue May 15 15:40:18 2001
> @@ -2495,3 +2495,4 @@ EXPORT_SYMBOL(fbcon_redraw_bmove);
>  EXPORT_SYMBOL(fbcon_redraw_clear);
>  EXPORT_SYMBOL(fbcon_dummy);
>  EXPORT_SYMBOL(fb_con);
> +EXPORT_SYMBOL(linux_logo_bw);

linux_logo_bw is __initdata.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

