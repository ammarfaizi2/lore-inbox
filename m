Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264671AbRFPWiM>; Sat, 16 Jun 2001 18:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264672AbRFPWiC>; Sat, 16 Jun 2001 18:38:02 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:36258 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S264671AbRFPWhy>; Sat, 16 Jun 2001 18:37:54 -0400
Date: Sat, 16 Jun 2001 16:37:49 -0600
Message-Id: <200106162237.f5GMbnR16846@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Daniel Dickman <ddickman@nyc.rr.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] to init/main.c
In-Reply-To: <3B2B845F.50300@nyc.rr.com>
In-Reply-To: <3B2B845F.50300@nyc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Dickman writes:
> Here is a small patch to main.c.
> 
> It does the following:
> - makes sure that asm/mtrr.h actually gets included, and

What the hell is this? It is already included!

> - changes formatting in one place as per Documentation/CodingStyle
> 
> --- linux-2.4.5/init/main.c     Tue May 22 12:35:42 2001
> +++ linux/init/main.c   Sat Jun 16 11:48:42 2001
> @@ -50,7 +50,7 @@
>  #endif
>  
>  #ifdef CONFIG_MTRR
> -#  include <asm/mtrr.h>
> +#include <asm/mtrr.h>
>  #endif
>  
>  #ifdef CONFIG_NUBUS

I don't want this change. It's not fixing anything and removes the
intentional indentation.

And was there a reason not to Cc: me?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
