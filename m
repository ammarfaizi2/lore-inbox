Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275794AbRI1CWB>; Thu, 27 Sep 2001 22:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275795AbRI1CVv>; Thu, 27 Sep 2001 22:21:51 -0400
Received: from c1123685-a.crvlls1.or.home.com ([65.12.164.15]:16910 "EHLO
	inbetween.blorf.net") by vger.kernel.org with ESMTP
	id <S275794AbRI1CVi>; Thu, 27 Sep 2001 22:21:38 -0400
Date: Thu, 27 Sep 2001 19:21:46 -0700 (PDT)
From: Jacob Luna Lundberg <kernel@gnifty.net>
Reply-To: jacob@chaos2.org
To: Dan Hollis <goemon@anime.net>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: AMD viper chipset and UDMA100
In-Reply-To: <Pine.LNX.4.30.0109271551400.20621-100000@anime.net>
Message-ID: <Pine.LNX.4.21.0109271904170.28015-100000@inbetween.blorf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Sep 2001, Dan Hollis wrote:
> And Andre's didnt make it into the kernel either it seems :-)

He hasn't even been updating his patch with taskfile and destroke support
in it for recent kernels, sadly (sadly because I need destroke).  However,
I've been trying to bring it forward myself; you can find it at:
http://chaos2.org/~jacob/code/linux/

I don't know if it's got anything useful to you in it, particularly given
that there are items like the two below which seem to be help chunks for
things that have recently made it into the kernel (without help, heh):


-AMD7409 chipset support
-CONFIG_BLK_DEV_AMD7409
-  This driver ensures (U)DMA support for the AMD756 Viper chipset.
+AMD Viper (7401/7409/7411) chipset support
+CONFIG_BLK_DEV_AMD74XX
+  This driver ensures (U)DMA support for the AMD756/760 Viper chipset.

[and]

-CONFIG_AMD7409_OVERRIDE
+CONFIG_AMD74XX_OVERRIDE


At any rate, I don't know if it's applicable for your problems at all
(it's not a small patch) but you're welcome to a copy of it if you want.

-Jacob

