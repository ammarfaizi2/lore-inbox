Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264888AbSKSKZ7>; Tue, 19 Nov 2002 05:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264889AbSKSKZ7>; Tue, 19 Nov 2002 05:25:59 -0500
Received: from rrzs2.rz.uni-regensburg.de ([132.199.1.2]:9167 "EHLO
	rrzs2.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S264888AbSKSKZ6>; Tue, 19 Nov 2002 05:25:58 -0500
Date: Tue, 19 Nov 2002 11:33:00 +0100
From: Christian Guggenberger 
	<Christian.Guggenberger@physik.uni-regensburg.de>
To: "Karsten 'soohrt' Desler" <linux-kernel@ml.soohrt.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-rc1-ac4 HPT374 doesn't find connected ide drives
Message-ID: <20021119113300.C23008@pc9391.uni-regensburg.de>
References: <20021119105955.A23008@pc9391.uni-regensburg.de> <20021119102338.GA24510@sit0.ifup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021119102338.GA24510@sit0.ifup.net>; from linux-kernel@ml.soohrt.org on Tue, Nov 19, 2002 at 11:23:38 +0100
X-Mailer: Balsa 1.2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.11.2002   11:23 Karsten 'soohrt' Desler wrote:
> > I have the same board, and the controller works fine for me in 2.5.4*, as
> > 2.4-ac doesn't contain xfs suport. I only have one drive attached, but as I
> 
> > remember I first had to configure the (raid) controller' BIOS (Ctrl-H at
> boot
> > time) (even for just a bunch of disks) before using the drives. But I'm not
> 
> > 100%ly sure.
> 
> I've "been in" the controller BIOS a few times, but never configured
> anything because I'm using the linux md driver.

Maybe U would try 2.5.48, just to see if it works then.
When I'm back home in about 7 hours, I'll check my bios settings, maybe this 
could help you.
  
> > ANother QUestion: Did you ever get the onboard via-rhine NIC working with
> > IO-APIC (both BIOS and kernel) enabled?
> 
> No I didn't.
> via-rhine.c:v1.10-LK1.1.14  May-3-2002  Written by Donald Becker
>   http://www.scyld.com/network/via-rhine.html
> eth1: VIA VT6102 Rhine-II at 0xcc00, 00:04:61:43:88:d9, IRQ 16.
> eth1: MII PHY found at address 1, status 0x7849 advertising 05e1 Link 0000.
> eth1: Setting full-duplex based on MII #1 link partner capability of 45e1.
> ...
> eth1: Transmit timed out, status 0003, PHY status 786d, resetting...
> eth1: reset did not complete in 10 ms.
> NETDEV WATCHDOG: eth1: transmit timed out
> 

thats just too bad, last I managed to get it working with IO-APICs for the 
first time, but i simply was too tired to remember what things I did. I can't 
reproduce it anymore:( this NIC's driving me crazy.

Christian

