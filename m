Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130689AbQKNTS4>; Tue, 14 Nov 2000 14:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130878AbQKNTSr>; Tue, 14 Nov 2000 14:18:47 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:1287
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130689AbQKNTSk>; Tue, 14 Nov 2000 14:18:40 -0500
Date: Tue, 14 Nov 2000 10:48:22 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: davej@suse.de
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mharris@opensourceadvocate.org
Subject: Re: UDMA66/100 errors...
In-Reply-To: <Pine.LNX.4.21.0011140106040.1173-100000@neo.local>
Message-ID: <Pine.LNX.4.10.10011141031270.11879-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Because he has not set the ignore valid bits and the 66 ribbon is not
detected.

Cheers,

On Tue, 14 Nov 2000 davej@suse.de wrote:

> 
> Mike Harris wrote..
> 
> >I'm getting the following error when I try and enable UDMA on my
> >new IBM Deskstar UDMA100 drive:
> >...
> > DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5
> 
> Ok, the drive supports UDMA5 (ATA100)
> 
> > setting xfermode to 67 (UltraDMA mode3)
> >ide0: Speed warnings UDMA 3/4/5 is not functional.
> 
> Why can this be?
> 
> >00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 10)
> 
> This chipset only does up to UDMA2.
> 
> regards,
> 
> Davej.
> 
> -- 
> | Dave Jones <davej@suse.de>  http://www.suse.de/~davej
> | SuSE Labs
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
