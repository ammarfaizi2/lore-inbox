Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262570AbTCITPu>; Sun, 9 Mar 2003 14:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262571AbTCITPu>; Sun, 9 Mar 2003 14:15:50 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33974
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262570AbTCITPt>; Sun, 9 Mar 2003 14:15:49 -0500
Subject: RE: [PATCH] Avoid PC(?) specific cascade dma reservation inkernel
	/dma.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Starvik <mikael.starvik@axis.com>
Cc: Johan Adolfsson <johan.adolfsson@axis.com>,
       "'Marcelo Tosatti'" <marcelo@conectiva.com.br>,
       "'Linus Torvalds'" <torvalds@transmeta.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
In-Reply-To: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE880@mailse01.axis.se>
References: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE880@mailse01.axis.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047241975.6396.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 09 Mar 2003 20:32:56 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-09 at 13:49, Mikael Starvik wrote:
> >I don't know of any PC cards that can support ISA DMA channel 4 so I
> >guess simply because of that it hasn't happened. Do you actually
> >know of any DMA 4 capable ISA devices or is it used for onboard
> >ISA devices ?
> 
> In this case it is used in a non ISA capable system where DMA channel
> numbers doesn't relate to ISA numbers in any way. 

So what happens if someone plugs a PCI/ISA bridge into an axis system.
Surely you should be reporting no ISA DMA and having a set of similar
axis specific DMA handlers - or does it really look so close to ISA think ?

