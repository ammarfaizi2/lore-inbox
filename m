Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSA0NWv>; Sun, 27 Jan 2002 08:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287141AbSA0NWc>; Sun, 27 Jan 2002 08:22:32 -0500
Received: from rhenium.btinternet.com ([194.73.73.93]:31182 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S287134AbSA0NWa>;
	Sun, 27 Jan 2002 08:22:30 -0500
From: "Daniel J Blueman" <daniel.blueman@btinternet.com>
To: "'Stevie O'" <stevie@qrpff.net>,
        "'Jeff Garzik'" <jgarzik@mandrakesoft.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: 2.2.20: pci-scan+natsemi & Device or resource busy
Date: Sun, 27 Jan 2002 13:22:27 -0000
Message-ID: <000001c1a735$ab27c4a0$0100a8c0@stratus>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <5.1.0.14.2.20020126211133.01ce7ff0@whisper.qrpff.net>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel NatSemi driver works perfectly for me with a Netgear FA-311
network card. Kernel is 2.4.17. I haven't tried it modular though...

Dmesg output:

[snip]
natsemi.c:v1.07 1/9/2001  Written by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  (unofficial 2.4.x kernel port, version 1.07+LK1.0.13, Oct 19, 2001
Jeff Garzi
k, Tjeerd Mulder)
PCI: Found IRQ 11 for device 00:0a.0
eth0: NatSemi DP8381[56] at 0xc8009000, 00:02:e3:0a:98:5a, IRQ 11.
eth0: Transceiver status 0x7849 advertising 05e1.
[snip]

Dan
____________________
Daniel J Blueman 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Stevie O
> Sent: 27 January 2002 02:13
> To: Jeff Garzik
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.2.20: pci-scan+natsemi & Device or resource busy
> 
> 
> At 09:06 PM 1/26/2002 -0500, Stevie O wrote:
> >At 07:07 PM 1/26/2002 -0500, Jeff Garzik wrote:
> >>Stevie O wrote:
> >> > My friend is trying Linux for the first time. I'm having him use 
> >> > the pci-scan and natsemi modules for his Netgear FA-311 
> card. With 
> >> > the initial
> >>
> >>These aren't Linux drivers, they are scyld.com drivers...  See 
> >>http://scyld.com/ for support and more info...
> >
> >Ahah! Thank you :P
> >
> >/me smacks himself for not verifying that he'd found the 
> right drivers
> >
> >Any idea what drivers I *do* need?
> >
> 
> Erm, wait...
> 
> A google for "linux fa-311 driver" yields this as the first result:
> 
http://www.scyld.com/network/ethercard.html

The title of this page is "Linux Drivers for PCI Ethernet Chips"...

Netgear isn't exactly a small company, I'm finding it hard to believe
that 
NOBODY has ever tried to create a module for one of their cards...


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

