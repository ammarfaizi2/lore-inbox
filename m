Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbRBBN7y>; Fri, 2 Feb 2001 08:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129153AbRBBN7p>; Fri, 2 Feb 2001 08:59:45 -0500
Received: from www.topmail.de ([212.255.16.226]:4062 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S129595AbRBBN7a> convert rfc822-to-8bit;
	Fri, 2 Feb 2001 08:59:30 -0500
Message-ID: <024a01c08d20$5db6b9e0$0100a8c0@homeip.net>
From: "mirabilos" <eccesys@topmail.de>
To: "Linux-Kernel ML" <linux-kernel@vger.kernel.org>,
        "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
In-Reply-To: <20010201231652.A2684@grobbebol.xs4all.nl>
Subject: Re: hard crashes 2.4.0/1 with NE2K stuff
Date: Fri, 2 Feb 2001 13:59:13 -0000
Organization: eccesys.net Linux Distribution Development
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, February 01, 2001 11:16 PM
Subject: hard crashes 2.4.0/1 with NE2K stuff


> 2.4.1. rebuilt here and with a floodping towards my machine causes a
> hard crash where nothing works anymore.
> 
> just before it happens :
> 
> Feb  1 13:07:24 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Feb  1 13:07:24 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0x3, t=21.
> Feb  1 13:07:36 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Feb  1 13:07:36 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0xb7, t=38.
> Feb  1 13:07:41 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Feb  1 13:07:41 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0xb7, t=38.
> Feb  1 13:07:43 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Feb  1 13:07:43 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0x97, t=118.
> Feb  1 13:07:45 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Feb  1 13:07:45 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0x97, t=118.
> Feb  1 13:07:46 grobbebol kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Feb  1 13:07:46 grobbebol kernel: eth0: Tx timed out, lost interrupt?  TSR=0x3, ISR=0x97, t=38.
> 
> 
> note that it doesn't happen when 2.2.19pre* is used. Still some work
> there to do.
> 
> the used board BP6 (abit), apics enabled. non-overclocked. card is a
> 
> 00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8029(AS)
> 
> IRQ:
> 
>  19:       6851       7642   IO-APIC-level  eth0
> 
> I assume Franks suggestions didn't get into the kernel ?


I have UP P133/56MB, 2.4.1-vanilla, some config changes.
NE2K works fine for me though software watchdog enabled.
I didn't strain test it yet, but will do l8er.

-mirabilos

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12+(proprietary extensions) # Updated:20010129 nick=mirabilos
GO/S d@ s--: a--- C++ UL++++ P--- L++$(-^lang) E----(joe) W+(++) loc=.de
N? o K? w-(+$) O+>+++ M-- V- PS+++@ PE(--) Y+ PGP t+ 5? X+ R+ !tv(silly)
b++++* DI- D+ G(>++) e(^age) h! r(-) y--(!y+) /* lang=NASM;GW-BASIC;C */
------END GEEK CODE BLOCK------


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
