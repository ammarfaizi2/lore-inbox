Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269137AbRHFXBF>; Mon, 6 Aug 2001 19:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269133AbRHFXAy>; Mon, 6 Aug 2001 19:00:54 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.159.219.12]:507 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S269127AbRHFXAm>; Mon, 6 Aug 2001 19:00:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3c509: broken(verified)
Date: Tue, 7 Aug 2001 01:00:40 +0200
X-Mailer: KMail [version 1.2.3]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010806230051Z269127-28344+2074@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 August 2001 22:30:12, Nicholas Knight wrote:
> You mention the problem is being unable to change the media, I was 
> unaware this was even possible with the current 3c509 driver, and most 
> people do it on 3c509's and other PNP cards of this sort (such as NE2000 
> clones)  by using a DOS boot diskette and the DOS utilities provided by 
> the manufacturer.

That's what I did. I've set it to "auto mode" and it works with RJ45 cable.
But I can't verify if "full duplex" worked right. So I changed it under Win 
to "10baseT" for which the 3Com utilities say "full duplex" enabled.

Now I get this for my ADSL NIC.
My first NIC (Ethernet Pro 100+) is for the LAN.

eth1: 3c5x9 at 0x220, 10baseT port, address  00 a0 24 87 4a a6, IRQ 5.
3c509.c:1.18 12Mar2001 becker@scyld.com
http://www.scyld.com/network/3c509.html
eth1: Setting Rx mode to 1 addresses.
eth1: Setting Rx mode to 2 addresses.
eth1: Setting Rx mode to 3 addresses.

But I am not smarter 'cause there is no full duplex mode mentioned in the 
logs.

Thanks,
	Dieter

BTW Is DMA (channel 6 for example) possible with this hardware/driver?
