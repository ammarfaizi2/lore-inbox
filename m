Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314613AbSEPJwz>; Thu, 16 May 2002 05:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314637AbSEPJwy>; Thu, 16 May 2002 05:52:54 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:35559 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S314613AbSEPJwx>; Thu, 16 May 2002 05:52:53 -0400
Date: Thu, 16 May 2002 11:52:43 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [patch] 2.4.19-pre8 and 2.5.15 remove duplicate CONFIG_SOUND_EMU10K1
In-Reply-To: <32491.1021541328@kao2.melbourne.sgi.com>
Message-ID: <Pine.GSO.4.05.10205161151570.10320-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, Keith Owens wrote:

> CONFIG_SOUND_EMU10K1 += ac97_codec.o occurs twice.
> To be sure, to be sure ....

same is true for 2.5.15

> Index: 19-pre8.1/drivers/sound/Makefile
> --- 19-pre8.1/drivers/sound/Makefile Fri, 01 Mar 2002 11:01:28 +1100 kaos (linux-2.4/P/b/4_Makefile 1.3.2.2.1.3.1.2 644)
> +++ 19-pre8.1(w)/drivers/sound/Makefile Thu, 16 May 2002 19:25:13 +1000 kaos (linux-2.4/P/b/4_Makefile 1.3.2.2.1.3.1.2 644)
> @@ -75,7 +75,6 @@ obj-$(CONFIG_SOUND_EMU10K1)	+= ac97_code
>  obj-$(CONFIG_SOUND_BCM_CS4297A)	+= swarm_cs4297a.o
>  obj-$(CONFIG_SOUND_RME96XX)     += rme96xx.o
>  obj-$(CONFIG_SOUND_BT878)	+= btaudio.o
> -obj-$(CONFIG_SOUND_EMU10K1)	+= ac97_codec.o
>  obj-$(CONFIG_SOUND_IT8172)	+= ite8172.o ac97_codec.o
>  
>  ifeq ($(CONFIG_MIDI_EMU10K1),y)

	tm

-- 
in some way i do, and in some way i don't.

