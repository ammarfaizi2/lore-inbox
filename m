Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316910AbSE1Up6>; Tue, 28 May 2002 16:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316939AbSE1UoE>; Tue, 28 May 2002 16:44:04 -0400
Received: from [195.39.17.254] ([195.39.17.254]:65180 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316915AbSE1UnT>;
	Tue, 28 May 2002 16:43:19 -0400
Date: Mon, 27 May 2002 15:04:04 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
        Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Copyright Violation (Re: [patch] New driver for Artop [Acard] controllers.)
Message-ID: <20020527150403.K35@toy.ucw.cz>
In-Reply-To: <1022460150.11859.187.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.10.10205261916570.3010-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> -struct chipset_bus_clock_list_entry aec62xx_base [] = {
> -#ifdef CONFIG_BLK_DEV_IDEDMA
> -       {       XFER_UDMA_6,    0x41,   0x06,   0x31,   0x07    },
> -       {       XFER_UDMA_5,    0x41,   0x05,   0x31,   0x06    },
> -       {       XFER_UDMA_4,    0x41,   0x04,   0x31,   0x05    },
> -       {       XFER_UDMA_3,    0x41,   0x03,   0x31,   0x04    },
> -       {       XFER_UDMA_2,    0x41,   0x02,   0x31,   0x03    },
> -       {       XFER_UDMA_1,    0x41,   0x01,   0x31,   0x02    },
> -       {       XFER_UDMA_0,    0x41,   0x01,   0x31,   0x01    },
> -
> -       {       XFER_MW_DMA_2,  0x41,   0x00,   0x31,   0x00    },
> -       {       XFER_MW_DMA_1,  0x42,   0x00,   0x31,   0x00    },
> -       {       XFER_MW_DMA_0,  0x7a,   0x00,   0x0a,   0x00    },
> -#endif /* CONFIG_BLK_DEV_IDEDMA */
> -       {       XFER_PIO_4,     0x41,   0x00,   0x31,   0x00    },
> -       {       XFER_PIO_3,     0x43,   0x00,   0x33,   0x00    },
> -       {       XFER_PIO_2,     0x78,   0x00,   0x08,   0x00    },
> -       {       XFER_PIO_1,     0x7a,   0x00,   0x0a,   0x00    },
> -       {       XFER_PIO_0,     0x70,   0x00,   0x00,   0x00    },
> -       {       0,              0x00,   0x00,   0x00,   0x00    }
> -};
> 
> <comment>
> New table is purely derived from the previous table.
> It is clever to hide the push/pull in the index based on the card.
> This will generate the associated pairs identically from the static table.
> </comment>

Tables like this are not copyrightable...
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

