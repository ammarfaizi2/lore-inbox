Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269145AbRHFXMO>; Mon, 6 Aug 2001 19:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269148AbRHFXMF>; Mon, 6 Aug 2001 19:12:05 -0400
Received: from femail26.sdc1.sfba.home.com ([24.254.60.16]:38617 "EHLO
	femail26.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S269145AbRHFXMB>; Mon, 6 Aug 2001 19:12:01 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 3c509: broken(verified)
Date: Mon, 6 Aug 2001 16:15:00 -0700
X-Mailer: KMail [version 1.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20010806230051Z269127-28344+2074@vger.kernel.org>
In-Reply-To: <20010806230051Z269127-28344+2074@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01080616150000.03359@c779218-a>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 August 2001 04:00 pm, Dieter Nützel wrote:
> On Monday 06 August 2001 22:30:12, Nicholas Knight wrote:
> > You mention the problem is being unable to change the media, I was
> > unaware this was even possible with the current 3c509 driver, and
> > most people do it on 3c509's and other PNP cards of this sort (such
> > as NE2000 clones)  by using a DOS boot diskette and the DOS utilities
> > provided by the manufacturer.
>
> That's what I did. I've set it to "auto mode" and it works with RJ45
> cable. But I can't verify if "full duplex" worked right. So I changed
> it under Win to "10baseT" for which the 3Com utilities say "full
> duplex" enabled.

Why do you want full duplex on a DSL connection? I tend to set any NIC's 
I use for a consumer connection to the lower end of their settings to 
avoid possible problems in any OS.

>
> Now I get this for my ADSL NIC.
> My first NIC (Ethernet Pro 100+) is for the LAN.
>
> eth1: 3c5x9 at 0x220, 10baseT port, address  00 a0 24 87 4a a6, IRQ 5.
> 3c509.c:1.18 12Mar2001 becker@scyld.com
> http://www.scyld.com/network/3c509.html
> eth1: Setting Rx mode to 1 addresses.
> eth1: Setting Rx mode to 2 addresses.
> eth1: Setting Rx mode to 3 addresses.

sorry, did forget to mention that
this popped up when I compiled the driver in instead of using a module, 
but it doesn't appear to be a problem, I have no idea what's going on 
with it though.

>
> But I am not smarter 'cause there is no full duplex mode mentioned in
> the logs.

does it get mentioned in the logs for your other NIC?

>
> Thanks,
> 	Dieter
>
> BTW Is DMA (channel 6 for example) possible with this hardware/driver?

the hardware is capable of it I belive, I do not know about the driver.
