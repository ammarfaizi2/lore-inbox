Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbRE3Ry0>; Wed, 30 May 2001 13:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261386AbRE3RyQ>; Wed, 30 May 2001 13:54:16 -0400
Received: from fungus.teststation.com ([212.32.186.211]:10881 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S261639AbRE3RyD>; Wed, 30 May 2001 13:54:03 -0400
Date: Wed, 30 May 2001 19:53:40 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
To: "Rose, Daniel" <daniel.rose@datalinesolutions.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine DFE-530TX rev A1
In-Reply-To: <000e01c0e917$60fbacc0$0a01a8c0@w98>
Message-ID: <Pine.LNX.4.30.0105301945510.5784-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Rose, Daniel wrote:

> It seems as though my card will not reset anymore after running windows 98,
> even after a cold boot, and recompiling the kernel. Below is the output of
> dmesg, lspci -n and ifconfig. Does anyone have any ideas? (please cc
> replies)

Have you tried cutting power to the machine? (ie physically unplugging it)

Someone has claimed that the chip may not reset otherwise. As it is
Wake-On-Lan capable, that sort of makes sense - it needs to be not
entirely dead.

> via-rhine.c:v1.08b-LK1.1.8  4/17/2000  Written by Donald Becker
>   http://www.scyld.com/network/via-rhine.html
> PCI: Found IRQ 10 for device 00:11.0
> PCI: The same IRQ used for device 00:07.2
> eth0: VIA VT6102 Rhine-II at 0xd000, 00:00:00:00:00:00, IRQ 10.
[snip]
> 00:11.0 Class 0200: 1106:3065 (rev 42)

Are you sure the card is marked rev-A1 and not rev-B1? I was hoping
DFE-530TXs with vt6102 were all rev-B1.

Can you check what's printed on the card and send me the markings on the
main chips?
(one is probably marked DL10030, DL10030A or possibly vt6102 with a big
VIA logo)

/Urban

