Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSK3WHl>; Sat, 30 Nov 2002 17:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbSK3WHk>; Sat, 30 Nov 2002 17:07:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2052 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261173AbSK3WHk>;
	Sat, 30 Nov 2002 17:07:40 -0500
Message-ID: <3DE93849.3030703@pobox.com>
Date: Sat, 30 Nov 2002 17:14:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wrightws@paul.hn.org
CC: linux-kernel@vger.kernel.org, marcelo@freak.distro.conectiva
Subject: Re: [PATCH] drivers/net/Makefile fixes smc91c92 module linkage, kernel
 2.4.20
References: <20021130215119.30256.qmail@paul.hn.org>
In-Reply-To: <20021130215119.30256.qmail@paul.hn.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wrightws@paul.hn.org wrote:
> *** linux-2.4.20/drivers/net/Makefile	2002-11-28 18:53:13.000000000 -0500
> --- linux-2.4.20-ww1/drivers/net/Makefile	2002-11-30 16:26:32.000000000 -0500
> ***************
> *** 122,127 ****
> --- 122,128 ----
>   obj-$(CONFIG_MAC8390) += daynaport.o 8390.o
>   obj-$(CONFIG_APNE) += apne.o 8390.o
>   obj-$(CONFIG_PCMCIA_PCNET) += 8390.o
> + obj-$(CONFIG_PCMCIA_SMC91C92) += mii.o
>   obj-$(CONFIG_SHAPER) += shaper.o
>   obj-$(CONFIG_SK_G16) += sk_g16.o
>   obj-$(CONFIG_HP100) += hp100.o



marcelo appears to have applied some patch like this in his current BK 
repository.  I am sending an update which makes this fixed a little bit 
better, too.

