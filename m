Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271144AbTHLQ4R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 12:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271146AbTHLQ4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 12:56:17 -0400
Received: from proibm3.portoweb.com.br ([200.248.222.108]:62417 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S271144AbTHLQ4P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 12:56:15 -0400
Date: Tue, 12 Aug 2003 13:58:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: maney@pobox.com
cc: linux-kernel@vger.kernel.org, Stephan von Krawczynski <skraw@ithnet.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
In-Reply-To: <20030812151421.GB1074@furrr.two14.net>
Message-ID: <Pine.LNX.4.44.0308121358100.5995-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Aug 2003, Martin Maney wrote:

> On Tue, Aug 12, 2003 at 11:10:51AM -0300, Marcelo Tosatti wrote:
> > I'll try to reproduce around here. In the meantime can you try to isolate 
> > the corruption. You said it didnt happen with 2.4.21 -- which pre shows up 
> > the problem? 
> 
> Yes, that's on my list.  Unfortunately this has so far only been seen
> on my workstation, and I have to get a bit of work done before I can
> pursue this.  At least I can get some candidates built in the
> background.
> 
> I have tried a few things quickly with 22-rc2, and the short summary
> is:
> 
>  * noapic makes no difference (don't recall why I had UP APIC enabled)
> 
>  * disabling DMA w/hdparm stops the corruption (all normal operation
>    and previous testing has been with DMA enabled)

Okey so its probably the Promise driver. 

Alan, have you ever heard of corruption with the newer Promise driver?

