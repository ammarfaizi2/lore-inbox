Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131407AbRCUNgL>; Wed, 21 Mar 2001 08:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131408AbRCUNgB>; Wed, 21 Mar 2001 08:36:01 -0500
Received: from mail12.svr.pol.co.uk ([195.92.193.215]:55640 "EHLO
	mail12.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S131407AbRCUNfo>; Wed, 21 Mar 2001 08:35:44 -0500
Date: Wed, 21 Mar 2001 13:37:38 +0000 (GMT)
From: Will Newton <will@misconception.org.uk>
X-X-Sender: <will@dogfox.localdomain>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Tim Waugh <twaugh@redhat.com>, Mike Galbraith <mikeg@wen-online.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VIA audio and parport in 2.4.2
In-Reply-To: <3AB82C36.C807B787@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0103211333440.1541-100000@dogfox.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2001, Jeff Garzik wrote:

> What are your parallel port settings in BIOS?

AFAICR there is only an option for setting the I/O port. I'll check
for anything else later (the machine in question is busy right now :).

> Do you have Plug-n-Play OS enabled in BIOS?

Yes.

> I am not sure that I agree, however, that an "irq=none" on the kernel
> cmd line should affect the operation of the Via code.  I would much
> rather fix the Via code as I suggest above.

irq=none seems pretty unequivocal to me, I'm not sure how easy it is to
explain to a user that irq=none doesn't do what it says.

> Time to look for and drag out the old Via laptop...  Oh well, I needed
> to debug the Via audio code some more anyway. :)

I'm getting all sorts of troubles with a SB PCI 128 card (AC97 also).
If it works at all, it seems to eventually stop getting interrupts until
the module is removed and reloaded.

Which is why I suspect there may be a larger problem with the VIA
motherboards.


