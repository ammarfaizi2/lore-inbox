Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130127AbRB1JKF>; Wed, 28 Feb 2001 04:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130130AbRB1JJ4>; Wed, 28 Feb 2001 04:09:56 -0500
Received: from fungus.teststation.com ([212.32.186.211]:11961 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S130126AbRB1JJq>; Wed, 28 Feb 2001 04:09:46 -0500
Date: Wed, 28 Feb 2001 10:09:27 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: Michal Jaegermann <michal@harddata.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Via-rhine is not finding its interrupts under 2.2.19pre14
In-Reply-To: <20010227164259.B23026@mail.harddata.com>
Message-ID: <Pine.LNX.4.30.0102280945580.8425-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2001, Michal Jaegermann wrote:

> 
> After I booted 2.2.19pre14 on a system with two via-rhine cards I see the
> following:
> 
> via-rhine.c:v1.08b-LK1.0.0 12/14/2000  Written by Donald Becker
>   http://www.scyld.com/network/via-rhine.html
> eth0: VIA VT3043 Rhine at 0x9400, 00:50:ba:c1:64:d9, IRQ 0.
> eth0: MII PHY found at address 8, status 0x7809 advertising 05e1 Link 0000.
> eth1: VIA VT3043 Rhine at 0x8800, 00:50:ba:ab:60:64, IRQ 0.
> eth1: MII PHY found at address 8, status 0x782d advertising 05e1 Link 0000.
> 
> and a network does not work due to these IRQ 0, I guess.

I assume this worked in 2.2.18 or some earlier 2.2.x?

Hmm, I'll have to test 2.2.19pre14 (16?) myself tonight. It did work for
me in earlier 2.2.19pre versions, and the code is "identical" to other
drivers here.

This page suggests possible bios problems.
http://www.scyld.com/expert/irq-conflict.html

You could also try Donalds original via-rhine module. The largest
difference between that and the one in the kernel is how it does pci
probing.
http://www.scyld.com/network/ethercard.html

/Urban

