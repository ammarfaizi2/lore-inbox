Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130484AbQLEPDk>; Tue, 5 Dec 2000 10:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131216AbQLEPDb>; Tue, 5 Dec 2000 10:03:31 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:50109 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S130484AbQLEPDV>; Tue, 5 Dec 2000 10:03:21 -0500
Date: Tue, 5 Dec 2000 14:30:56 +0000 (GMT)
From: Guennadi Liakhovetski <gvlyakh@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: DMA !NOT ONLY! for triton again...
In-Reply-To: <3A2BF6A2.1BD792BA@windsormachine.com>
Message-ID: <Pine.GSO.4.21.0012051113250.6865-100000@acms23>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody

Tried turning PIO and/or PCI burst in BIOS off - no use:-( The former one
only slows the disk a lot.

Andre, I've sent you an email with the entire story, forgot to mention
there - a few people did draw my attention to 'PIIX: neither IDE port
enabled (BIOS)' and neighbouring messages in dmesg, but nobody was able to
explain what particularly is going on (BIOS does recognise HD and CD-ROM
fine) and how to fix it.

Re: PCI clock... Something somewhere (can't find now) made me think that
my MB is setting the PCI clock synchronously with the CPU clock, i.e. it
is 25MHz in my case... Any ideas where I could see it?:-) In BIOS 'Latency
Timer (PCI Clocks)' is shown as 66MHz, does it mean that my PCI bus clock
IS @ 66/2=33MHz?

> Guennadi: I don't suppose you can get your hands on a different size/brand drive
> long enough to plug it in, and see if it allows DMA?

I'll try... Not sure though...

Thanks
Guennadi
___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
