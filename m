Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315191AbSFXTeF>; Mon, 24 Jun 2002 15:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSFXTeE>; Mon, 24 Jun 2002 15:34:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4883 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315191AbSFXTeE>;
	Mon, 24 Jun 2002 15:34:04 -0400
Message-ID: <3D17743E.8060905@mandrakesoft.com>
Date: Mon, 24 Jun 2002 15:34:22 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/00200205
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@cogenit.fr>
CC: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org,
       Jes Sorensen <jes@trained-monkey.org>, davej@suse.de
Subject: Re: [PATCH] 2.5.24 : drivers/net/tlan.c; drivers/net/rrunner.c
References: <Pine.LNX.4.44.0206232229570.922-100000@localhost.localdomain> <20020624084325.B22534@fafner.intra.cogenit.fr> <20020624211407.A23939@fafner.intra.cogenit.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Greetings,
> 
> [remaining DMA-mapping conversion in drivers/net]
> 
> - tlan plays isa/pci and does as well some interesting things with copy
>   buffers. The patch is attached but I'll feel safer if somebody with 
>   the adequate hardware at hand appears.

I've got some tlan cards

> - Imho rrunner wouldn't suffer from compat code removal + pci driver init 
>   style + DMA mapping conversion. I'd like to know what the maintainer
>   thinks before resurrecting the patch. Jes ?

Just make sure you split it up... one of the reasons why I have stalled 
applying davej's 2.4.x->2.5.x rrunner patch is that it's pretty darn 
huge, even though the changes are fairly minor.  (nothing against davej, 
of course)

	Jeff


