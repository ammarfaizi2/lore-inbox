Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130572AbQLEX47>; Tue, 5 Dec 2000 18:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130454AbQLEX4y>; Tue, 5 Dec 2000 18:56:54 -0500
Received: from d-dialin-2392.addcom.de ([62.96.168.240]:59118 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S131014AbQLEX4j>; Tue, 5 Dec 2000 18:56:39 -0500
Date: Wed, 6 Dec 2000 00:25:43 +0100 (CET)
From: Kai Germaschewski <kai@thphy.uni-duesseldorf.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>, Martin Mares <mj@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PCI irq routing..
In-Reply-To: <Pine.LNX.4.10.10012051442100.7318-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0012060021090.1015-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2000, Linus Torvalds wrote:

> WHY this happens is unclear, but it could be several reasons:
>  - undocumented "Plug'n'Play OS true behaviour"
>  - BIOS bugs. 'nuff said.
>  - warm-booting from an OS that _does_ set the interrupt routing,
>    and also sets the PCI config space thing

It's not the last reason here, i.e. it happens when cold booting into
Linux (and when warm booting from Linux into Linux). I could try warm
booting from Win98, however, if anybody cares. BTW: Win98 crashes while
booting when PnP OS is set to no (Linux works flawlessly, though).

> Adam, Kai, can you verify that it fixes the issues on your systems?

It works fine here - thanks again.

--Kai


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
