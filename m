Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277695AbRJLNkf>; Fri, 12 Oct 2001 09:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277692AbRJLNk0>; Fri, 12 Oct 2001 09:40:26 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:36612 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S277686AbRJLNkO>; Fri, 12 Oct 2001 09:40:14 -0400
Date: Fri, 12 Oct 2001 09:40:40 -0400 (EDT)
From: Ion Badulescu <ion@cs.columbia.edu>
X-X-Sender: <ion@guppy.limebrokerage.com>
To: Robbert Kouprie <robbert@radium.jvb.tudelft.nl>
cc: <poptix@techmonkeys.org>, <linux-kernel@vger.kernel.org>
Subject: Re: eepro100.c bug on 10Mbit half duplex (kernels 2.4.5 / 2.4.10 /
 2.4.11pre6 / 2.4.11 / 2.4.10ac11)
In-Reply-To: <Pine.LNX.4.21.0110121025001.26282-100000@radium.jvb.tudelft.nl>
Message-ID: <Pine.LNX.4.33.0110120923010.7250-100000@guppy.limebrokerage.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001, Robbert Kouprie wrote:

> Mine says rev 9 :)
> 
> radium:/# lspci -v -d 8086:1229
> 00:0d.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
> (rev 09)
>         Subsystem: Intel Corporation: Unknown device 0011
>         Flags: bus master, medium devsel, latency 32, IRQ 17
>         Memory at da020000 (32-bit, non-prefetchable) [size=4K]
>         I/O ports at c800 [size=64]
>         Memory at da000000 (32-bit, non-prefetchable) [size=128K]
>         Expansion ROM at <unassigned> [disabled] [size=1M]
>         Capabilities: [dc] Power Management version 2

That's an 82559ER step A.

> > eth0: OEM i82557/i82558 10/100 Ethernet, DE:AD:BA:BE:CA:FE, IRQ 10.
> >  Receiver lock-up bug exists -- enabling work-around.
> >  ^^^^^^^^^^^^^^^^^^^^
>
> My card DOES NOT have the receiver lock-up bug 

Your card's eeprom claims otherwise. The eeprom is most likely wrong, but 
again, the workaround for *this* bug is pretty harmless, whether the bug 
exists or not.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.




