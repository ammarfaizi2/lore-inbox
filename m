Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271691AbRHQQud>; Fri, 17 Aug 2001 12:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271692AbRHQQuW>; Fri, 17 Aug 2001 12:50:22 -0400
Received: from chaos.analogic.com ([204.178.40.224]:9600 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S271691AbRHQQuD>; Fri, 17 Aug 2001 12:50:03 -0400
Date: Fri, 17 Aug 2001 12:50:06 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Holger Lubitz <h.lubitz@internet-factory.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <3B7D3EF9.4CEABF2C@internet-factory.de>
Message-ID: <Pine.LNX.3.95.1010817124622.1883A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, Holger Lubitz wrote:

> "Richard B. Johnson" proclaimed:
> 
> > Errrm no. All BIOS that anybody would use write all memory found when
> > initializing the SDRAM controller. They need to because nothing,
> > refresh, precharge, (or if you've got it, parity/crc) will work
> > until every cell is exercised. A "warm-boot" is different. However,
> > if you hit the reset or the power switch, nothing in RAM survives.
> 
> Then this may have changed with SDRAM. However, back in my Amiga days it
> was pretty common to just reset the machine and rip whatever was left in
> the memory (DRAM). If memory serves me right, some people put in reset
> protection (by pointing the reset vector to some code that cleared the
> memory), which could be fooled by hardware reset or power cycling.
> 
> Holger

Yes, even in the early PC-XT and PC/AT, where the DMA controller was
used for refresh, it was quite possible to reset the machine and
have RAM contents (except for the first 1 megabyte) remain untouched.
The first 1 megabyte was cleared, actually the first 640k, because
the boot code depended upon this. It didn't clear RAM used for
temporary variables.

But, now-days, you can't reset the machine without killing whatever
is in RAM.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


