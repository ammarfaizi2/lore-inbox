Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUFETIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUFETIo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 15:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUFETIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 15:08:44 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:53517 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261914AbUFETIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 15:08:41 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Pods" <pods@dodo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: lotsa oops - 2.6.5 (preempt + unable handle virutal address + more?)
Date: Sat, 5 Jun 2004 22:00:37 +0300
User-Agent: KMail/1.5.4
References: <E1BWd4f-000893-00@mail.kbs.net.au>
In-Reply-To: <E1BWd4f-000893-00@mail.kbs.net.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406052200.37404.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 June 2004 18:27, Pods wrote:
> >> Run memtest86
> Tried once before, didnt boot... died :( memtest page says this happens on
> some hardware and they're not sure why.

Ho hum. Looks like good starting point to debug.
Remove RAM until you have <= 2 GB, then run memtest86
(or modified versions of it with debug prints)
until you know where it dies.

> >> Underclock your system
> its not over clocked :/

I mean, underclock below normal conditions.

> >> lower IDE DMA mode and see whether it stops oopsing.
>
> tried setting dma = off in hdparm, didnt work, still got crashes compiling
> firebird.. infact, it didnt even get passed the ./configure stage :(

Use hdparm to set, say, udma0.

> Each time (just about, didnt do it once out of 6ish times) i set the dma to
> off (either at boot or runtime) i got a "spurious 8259A interript: IRQ 7"..
> apparantly, iirc that debug message has been taken out of 2.6.6

I have 'em too. Not a real issue on lots of systems.

> Please guys, CC me your responces, otherwise i have to look at some
> archives, and reply via webmail... it took 2 firefox crashes (one of which
> brought down X) to just right this message... now im going to take a chance
> and hit the submit
> button
--
vda

