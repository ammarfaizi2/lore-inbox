Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129877AbQKNBnZ>; Mon, 13 Nov 2000 20:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130031AbQKNBnQ>; Mon, 13 Nov 2000 20:43:16 -0500
Received: from [194.73.73.138] ([194.73.73.138]:40929 "EHLO ruthenium")
	by vger.kernel.org with ESMTP id <S129877AbQKNBmc>;
	Mon, 13 Nov 2000 20:42:32 -0500
From: davej@suse.de
Date: Tue, 14 Nov 2000 01:12:26 +0000 (GMT)
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: mharris@opensourceadvocate.org
Subject: Re: UDMA66/100 errors...
Message-ID: <Pine.LNX.4.21.0011140109500.1199-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Harris wrote...

> I'm getting the following error when I try and enable UDMA on my
> new IBM Deskstar UDMA100 drive:
> ...
> DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5

Ok, drive supports UDMA Mode 5 (ATA100)

> 00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)

This chipset only supports up to UDMA2.

regards,

davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
