Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287189AbSBCN7Q>; Sun, 3 Feb 2002 08:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287208AbSBCN7H>; Sun, 3 Feb 2002 08:59:07 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46858 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287189AbSBCN6v>; Sun, 3 Feb 2002 08:58:51 -0500
Subject: Re: 2.4.17 filesystem corruption
To: Luis.A.Montes.1@worldnet.att.net (Luis A. Montes)
Date: Sun, 3 Feb 2002 13:44:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200202030538.g135chu00602@penguin.montes2.org> from "Luis A. Montes" at Feb 02, 2002 09:38:43 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16XMwN-0004UB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> this list to handle my SiS 735 chipset. It did seem more stable for a
> while, until I decided to try and enable ultra dma 66 on my primary
> drive. The two partitions that I had mounted got completely corrupted

How did you switch on UDMA66 ?

> hda: Western Digital Caviar WDC AC313000R (it is *not* in the udma
> black list, should it be?)

There is certainly no evidence it should be

> hdb: Western Digital Caviar WDC AC23200L (this one is in the black
> list, but is not being mounted, so it shouldn't matter, right?)

Unknown. But you can test that

> - Was there some change between 2.4.5 and 2.4.17 that could have
>   introduced problems in the IDE layer? I really tried to test 2.4.5

For the SiS possibly. 
