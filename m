Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262511AbTCINix>; Sun, 9 Mar 2003 08:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262512AbTCINix>; Sun, 9 Mar 2003 08:38:53 -0500
Received: from krynn.axis.se ([193.13.178.10]:44736 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S262511AbTCINiw>;
	Sun, 9 Mar 2003 08:38:52 -0500
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE880@mailse01.axis.se>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       Johan Adolfsson <johan.adolfsson@axis.com>
Cc: "'Marcelo Tosatti'" <marcelo@conectiva.com.br>,
       "'Linus Torvalds'" <torvalds@transmeta.com>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Avoid PC(?) specific cascade dma reservation inkernel
	/dma.c
Date: Sun, 9 Mar 2003 14:49:14 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I don't know of any PC cards that can support ISA DMA channel 4 so I
>guess simply because of that it hasn't happened. Do you actually
>know of any DMA 4 capable ISA devices or is it used for onboard
>ISA devices ?

In this case it is used in a non ISA capable system where DMA channel
numbers doesn't relate to ISA numbers in any way. 

/Mikael 
