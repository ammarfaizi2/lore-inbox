Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271621AbTGRKOo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 06:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271819AbTGRKII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 06:08:08 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:31931 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S271815AbTGRKHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 06:07:42 -0400
Date: Fri, 18 Jul 2003 12:22:37 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: typo bits
In-Reply-To: <200307171807.h6HI7j2F016507@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0307181221390.22944-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1003.1.91, 2003/07/17 14:20:22-03:00, alan@lxorguk.ukuu.org.uk
> 
> 	[PATCH] PATCH: typo bits
> 	
> 
> 
> # This patch includes the following deltas:
> #	           ChangeSet	1.1003.1.90 -> 1.1003.1.91
> #	drivers/usb/host/sl811.c	1.2     -> 1.3    
> #	drivers/usb/host/Config.in	1.6     -> 1.7    
> #
> 
>  Config.in |    2 +-
>  sl811.c   |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff -Nru a/drivers/usb/host/Config.in b/drivers/usb/host/Config.in
> --- a/drivers/usb/host/Config.in	Thu Jul 17 11:07:46 2003
> +++ b/drivers/usb/host/Config.in	Thu Jul 17 11:07:46 2003
> @@ -13,5 +13,5 @@
>  fi
>  dep_tristate '  OHCI (Compaq, iMacs, OPTi, SiS, ALi, ...) support' CONFIG_USB_OHCI $CONFIG_USB
>  if [ "$CONFIG_ARM" = "y" ]; then
> -  dep_tristate '  SL811HS Alternate (support isochornous mode)' CONFIG_USB_SL811HS_ALT $CONFIG_USB
> +   dep_tristate '  SL811HS Alternate (support isosynchronous mode)' CONFIG_USB_SL811HS_ALT $CONFIG_USB
>  fi
> diff -Nru a/drivers/usb/host/sl811.c b/drivers/usb/host/sl811.c
> --- a/drivers/usb/host/sl811.c	Thu Jul 17 11:07:46 2003
> +++ b/drivers/usb/host/sl811.c	Thu Jul 17 11:07:46 2003
> @@ -9,7 +9,7 @@
>   * 	  Adam Richter, Gregory P. Smith;
>    	2.Original SL811 driver (hc_sl811.o) by Pei Liu <pbl@cypress.com>
>   *
> - * It's now support isochronous mode and more effective than hc_sl811.o
> + * It's now support isosynchronous mode and more effective than hc_sl811.o

I thought the correct term was `isochronous'...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

