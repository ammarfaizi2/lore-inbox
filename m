Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131620AbRAQJ7s>; Wed, 17 Jan 2001 04:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132006AbRAQJ7k>; Wed, 17 Jan 2001 04:59:40 -0500
Received: from cm04667.telecable.es ([212.89.26.97]:29195 "EHLO
	bandit.dnsq.org") by vger.kernel.org with ESMTP id <S131620AbRAQJ71>;
	Wed, 17 Jan 2001 04:59:27 -0500
Date: Wed, 17 Jan 2001 11:03:54 +0100 (CET)
From: <bandit2@iname.com>
To: linux-kernel@vger.kernel.org
Subject: Overriding BIOS settings with kernel 2.4.0
In-Reply-To: <Pine.LNX.4.10.10101152031110.12667-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0101171057580.2640-100000@bandit.dnsq.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

	I'm runing Linux kernel 2.4.0 on a AMD Thunderbird 700, AOPEN AK33
(KT133 chipset). I have a SB Live, PCI NE2000 Network adapter, Adaptec
AHA-2940UW, a TV Capture card and an AGP Geforce 256.

	I'm telling you all this because my BIOS keeps assigning shared
interrupts between the Geforce-TVCapture and NE2000-USB Hubs. I get
several messages at boot time complaining about shared IRQ's. The funny
thing is that I have at least 2 free IRQ's, but my BIOS won't assign them
to any device... :-?

	Is there any way to get Linux override BIOS settings and reassign
IRQ's so they aren't shared by more than one device?

	Thanks
		Julian J. M.

	


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
