Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbQLMALl>; Tue, 12 Dec 2000 19:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129590AbQLMALb>; Tue, 12 Dec 2000 19:11:31 -0500
Received: from mailout1-1.nyroc.rr.com ([24.92.226.146]:49405 "EHLO
	mailout1-1.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S129255AbQLMALN>; Tue, 12 Dec 2000 19:11:13 -0500
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: "Gnea" <gnea@rochester.rr.com>
To: Juan <piernas@ditec.um.es>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Still "eth0: trigger_send() called with the transmitter busy"
    in 2.4.0-test12
X-Mailer: Pronto v2.2.2
Date: 12 Dec 2000 18:22:29 EST
Reply-To: "Gnea" <gnea@rochester.rr.com>
In-Reply-To: <3A366482.7930EC43@ditec.um.es>
In-Reply-To: <3A366482.7930EC43@ditec.um.es>
Message-ID: <20001212231820.AAA6560@mail2.nyroc.rr.com@celery>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 12 Dec 2000 18:46:42 +0100, Juan blurted forth:

> Hi!
>  
>  This error exists since 2.4.0-test10preX or so. It occurs when the
>  network interface is activated.
>  
>  I'm using RedHat 7.0 and my ethernet card is a "Kingston EtheRx KNE20
>  Plug and Play ISA Adapter". I'm unable to access the Internet because
>  the ethernet card doesn't work :-(. Besides, the card uses two
>  interrupts (?) and there are two interfaces (eth0 y eth1) when I have
>  only one (?).
>  
[snip]
>   --- Next Part --- 
>  
>  Card 1 'KTC2000:Kingston EtheRx KNE20 Plug and Play ISA Adapter' PnP version 1.0 Product version 1.0
>    Logical device 0 'RTL8019:Unknown'
>      Supported registers 0x2
>      Compatible device PNP80d6
>      Device is active
>      Active port 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
>      Active IRQ 255 [0xff],255 [0xff]
>      Active DMA 255,255
>      Active memory 0xffffffff,0xffffffff,0xffffffff,0xffffffff
>      Resources 0
>        Priority preferred
>        Port 0x240-0x380, align 0x1f, size 0x20, 10-bit address decoding
>        IRQ 3,4,5,2/9,10,11,12,15 High-Edge

try loading the rtl81*.o module(s) until it works right... you should
see a message for eth1 in dmesg about it

-- 
	.oO gnea at rochester dot rr dot com Oo.
	    .oO url: http://garson.org/~gnea Oo.

"You can tune a filesystem, but you can't tuna fish" -unknown

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
