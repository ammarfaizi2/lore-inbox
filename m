Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbRFJTII>; Sun, 10 Jun 2001 15:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261547AbRFJTH6>; Sun, 10 Jun 2001 15:07:58 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:14351 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261535AbRFJTH4>; Sun, 10 Jun 2001 15:07:56 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH 2.4.5-ac12] New Sony Vaio Motion Eye camera driver
Date: 10 Jun 2001 12:07:31 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9g0ghj$1mb$1@penguin.transmeta.com>
In-Reply-To: <20010610175730.B15945@ontario.alcove-fr> <E1597bu-0006lf-00@the-village.bc.nu> <20010610184611.A16660@ontario.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010610184611.A16660@ontario.alcove-fr>,
Stelian Pop  <stelian.pop@fr.alcove.com> wrote:
>
>> 2.	Using the YUV overlay/expand hardware in the ATI card 
>> 	(see www.gatos.org for X stuff for ATI for this)
>
>:s/www.gatos.org/www.linuxvideo.org/gatos/
>
>I took a quick look on their site but it seems that the
>Rage Mobility P/M card which this laptop has isn't yet supported.

It definitely is - at least if you use the XFree86 CVS tree with just
the ATI video extensions imported from Gatos.  I've used the YUV
hardware for half-accelerated DVD playing ("half-accelerated" only
because the chip can really do MC too, but ATI doesn't document how to
do it, so it only does the YUV conversion). 

I've not figured out why the ATI Xv stuff from gatos seems to not have
made it into the XFree86 CVS tree - it works better than much of the Xv
stuff for some other chipsets that _are_ in the CVS tree. 

I imported it into the XFree86 CVS some months ago, it was trivial.  I
don't have the patches lying around any more, though. I can try to
re-create them if anybody needs help.

		Linus
