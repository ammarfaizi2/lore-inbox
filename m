Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261969AbRFRV7e>; Mon, 18 Jun 2001 17:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261988AbRFRV7Y>; Mon, 18 Jun 2001 17:59:24 -0400
Received: from www.transvirtual.com ([206.14.214.140]:5394 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261969AbRFRV7N>; Mon, 18 Jun 2001 17:59:13 -0400
Date: Mon, 18 Jun 2001 14:58:17 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Paul Mundt <lethal@chaoticdreams.org>
cc: =?iso-8859-1?Q?Ren=E9?= Rebe <rene.rebe@gmx.net>,
        linux-kernel@vger.kernel.org, ademar@conectiva.com.br, rolf@sir-wum.de,
        linux-fbdev-devel@lists.sourceforge.net
Subject: Re: sis630 - help needed debugging in the kernel
In-Reply-To: <20010618122800.A10027@ChaoticDreams.ORG>
Message-ID: <Pine.LNX.4.10.10106181456590.3113-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Is there another way to tell the fb driver what mode to use??
> > 
> Yep, in fbmem.c the name entry is "sisfb" as opposed to just "sis". 

Agh!!! That needs to be fixed. 

> Also, the
> driver requires that the mode is passed video a "mode:" argument as is
> outlined in the sisfb_setup(). Take a look at drivers/video/sis/sis_main.h,
> specifically sisbios_mode[] for a list of supported modes.

Broken. It should be using modedb. When I get the time I will send a fix.

