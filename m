Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131135AbRALRkY>; Fri, 12 Jan 2001 12:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131444AbRALRkP>; Fri, 12 Jan 2001 12:40:15 -0500
Received: from relais.videotron.ca ([24.201.245.36]:35505 "EHLO
	VL-MS-MR002.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S131135AbRALRkH>; Fri, 12 Jan 2001 12:40:07 -0500
Message-ID: <3A5F3D89.5DED9C80@videotron.ca>
Date: Fri, 12 Jan 2001 12:23:21 -0500
From: Martin Laberge <mlsoft@videotron.ca>
Organization: MLSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19pre7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Tobias Ringstrom <tori@tellus.mine.nu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 ate my filesystem on rw-mount
In-Reply-To: <E14H1Ls-00047Z-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > This is on a 450 MHz AMD-K6 with the following IDE controller:
> > 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
>
> There are several people who have reported that the 2.4.0 VIA IDE driver
> trashes hard disks like that. The 2.2 one also did this sometimes but only
> with specific chipset versions and if you have dma autotune on (thats why
> currently 2.2 refuses to do tuning on VP3)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

I had exactly the same problem with my K6-350 and IDE VT82C586a
on a kernet 2.2.16    ..... i just made a hdparm to enable DMA and pooffff....
lost all data .... reinstall necessary from scratch

Martin Laberge
mlsoft@videotron.ca


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
