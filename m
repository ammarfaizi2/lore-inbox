Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314068AbSEAWFk>; Wed, 1 May 2002 18:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314069AbSEAWFk>; Wed, 1 May 2002 18:05:40 -0400
Received: from gw.lowendale.com.au ([203.26.242.120]:15420 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S314068AbSEAWFj>; Wed, 1 May 2002 18:05:39 -0400
Date: Thu, 2 May 2002 08:45:38 +1000 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: Eugenij Butusov <dinorage@wp.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernels 2.2.19-2.4.x. Why why why?
In-Reply-To: <20020501201703.A990@matrix.awr.open.net.pl>
Message-ID: <Pine.LNX.4.05.10205020839030.8020-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2002, Eugenij Butusov wrote:

>  I'm writing to You because of my problem with kernels > 2.2.17.
> This kernel is the last that works on my machine. I've tried almost
> all, including 2.3.x and 2.5.x, but they simple don't work.

Have you tried 2.2.21-rc3?

[...]
> PROC: p200MMX
> MB: pc chips, SiS, tx-pro m570(v12), apg, 1MB L2 cache, onboard soundpro
> MEM: 64MB sdram
> GFX: diamond viper v330 agp (4mb)
> NIC: realtek8139 (D-Link NetEasy)
> HDD: 2x3.2GB (samsung & seagate, both udma33)

Assuming I have you right that 2.2.17 works reliably and 2.2.18 fails
reliably, then perhaps:

(a) have a look through the changelog at
http://www.kernel.org/pub/linux/kernel/v2.2/linux-2.2.18.log and see if
there's anything likely -OR-
(b) do a binary search of 2.2.18-pre* to find just where it breaks.

The point is to narrow down the patch which broke things for you.

HTH,
Neale.

