Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130562AbQLDIgf>; Mon, 4 Dec 2000 03:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbQLDIgZ>; Mon, 4 Dec 2000 03:36:25 -0500
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:28971 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S130530AbQLDIgN>; Mon, 4 Dec 2000 03:36:13 -0500
Date: Mon, 4 Dec 2000 02:05:38 -0600 (CST)
From: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
To: "Mohammad A. Haque" <mhaque@haque.net>
cc: "Garst R. Reese" <reese@isn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: test12-pre4 drivers/net/dummy
In-Reply-To: <3A2B376F.2C44FB18@haque.net>
Message-ID: <Pine.LNX.3.96.1001204020417.19309C-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the fix is in module.h which needs extra parens in the def of
set_module_owner...

	Jeff



On Mon, 4 Dec 2000, Mohammad A. Haque wrote:

> Patch posted here...
> http://marc.theaimsgroup.com/?l=linux-kernel&m=97590235825341&w=2
> 
> "Garst R. Reese" wrote:
> > 
> > Fails to compile module at line 103,
> > invalid type argument of ->
> > Sorry if this well known.
> > Garst
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > Please read the FAQ at http://www.tux.org/lkml/
> 
> -- 
> 
> =====================================================================
> Mohammad A. Haque                              http://www.haque.net/ 
>                                                mhaque@haque.net
> 
>   "Alcohol and calculus don't mix.             Project Lead
>    Don't drink and derive." --Unknown          http://wm.themes.org/
>                                                batmanppc@themes.org
> =====================================================================
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
