Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVCOTZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVCOTZu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbVCOTZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:25:48 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:16316 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261799AbVCOTWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:22:51 -0500
Date: Tue, 15 Mar 2005 19:22:36 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Jon Smirl <jonsmirl@gmail.com>
cc: linux-fbdev-devel@lists.sourceforge.net,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       James Simmons <jsimmons@pentafluge.infradead.org>,
       Michal Januszewski <spock@gentoo.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] [announce 0/7] fbsplash - The Framebuffer
 Splash
In-Reply-To: <9e4733910503151103b8a9c8f@mail.gmail.com>
Message-ID: <Pine.LNX.4.56.0503151920080.5506@pentafluge.infradead.org>
References: <20050308015731.GA26249@spock.one.pl> 
 <Pine.LNX.4.62.0503091033400.22598@numbat.sonytel.be> 
 <1110392212.3116.215.camel@localhost.localdomain> 
 <Pine.LNX.4.56.0503092043380.7510@pentafluge.infradead.org> 
 <1110408049.9942.275.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0503101009240.9227@numbat.sonytel.be>  <20050310145419.GD632@openzaurus.ucw.cz>
  <Pine.LNX.4.56.0503111801550.10827@pentafluge.infradead.org> 
 <9e473391050311101356536667@mail.gmail.com> 
 <Pine.LNX.4.56.0503151855430.5506@pentafluge.infradead.org>
 <9e4733910503151103b8a9c8f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> DRM doesn't know a thing about 3D. All it does is DMA, memory
> management and queue things up for the GPU to work on. You don't even
> have to have a GPU processor you could use the CPU to execute the
> commands.
> 
> It's the code up in mesa that knows about 3D and builds the commands
> to be sent to DRM.

Not all devices are DMA. Personally since it is generic DMA engine then 
why not move it to the device api so everyone could use it. We already 
have DMA pools. Actually I have started some work for some generic DMA 
handling for the device api core but I have other fish to fry first.

