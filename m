Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269144AbRHFXLo>; Mon, 6 Aug 2001 19:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269145AbRHFXLe>; Mon, 6 Aug 2001 19:11:34 -0400
Received: from imladris.infradead.org ([194.205.184.45]:64272 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S269144AbRHFXL3>;
	Mon, 6 Aug 2001 19:11:29 -0400
Date: Tue, 7 Aug 2001 00:11:18 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 3c509: broken(verified)
In-Reply-To: <20010806230051Z269127-28344+2074@vger.kernel.org>
Message-ID: <Pine.LNX.4.33.0108070003540.4091-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dieter.

 >> You mention the problem is being unable to change the media, I
 >> was unaware this was even possible with the current 3c509
 >> driver, and most people do it on 3c509's and other PNP cards of
 >> this sort (such as NE2000 clones)  by using a DOS boot diskette
 >> and the DOS utilities provided by the manufacturer.

 > That's what I did. I've set it to "auto mode" and it works with
 > RJ45 cable. But I can't verify if "full duplex" worked right.

What transfer speed do you get doing an FTP transfer across the link?
10base is theoretically capable of one meg per second, and experience
indicates that a 10baseT link normally shows just under 500k per
second flat out, presumably due to the half duplex nature of the
10baseT protocol. I'd expect 10base2 half duplex to be similar, and
10base2 full duplex to be somewhat faster.

 > So I changed it under Win to "10baseT" for which the 3Com
 > utilities say "full duplex" enabled.

One slight problem - 10baseT uses CoAxial cable, not RJ45 - and, as
far as I'm aware, 10baseT is strictly half duplex whereas 10base2
(which uses RJ45 twisted pair cable) is capable of either half or full
duplex.

 > Now I get this for my ADSL NIC.
 > My first NIC (Ethernet Pro 100+) is for the LAN.

 > eth1: 3c5x9 at 0x220, 10baseT port, address  00 a0 24 87 4a a6, IRQ 5.
 > 3c509.c:1.18 12Mar2001 becker@scyld.com
 > http://www.scyld.com/network/3c509.html
 > eth1: Setting Rx mode to 1 addresses.
 > eth1: Setting Rx mode to 2 addresses.
 > eth1: Setting Rx mode to 3 addresses.

 > But I am not smarter 'cause there is no full duplex mode
 > mentioned in the logs.

I have to admit that doesn't surprise me.

 > BTW Is DMA (channel 6 for example) possible with this hardware/driver?

I can't help there, sorry.

Best wishes from Riley.

