Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132226AbQK3G46>; Thu, 30 Nov 2000 01:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132357AbQK3G4s>; Thu, 30 Nov 2000 01:56:48 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:24836
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S132226AbQK3G4g>; Thu, 30 Nov 2000 01:56:36 -0500
Date: Wed, 29 Nov 2000 22:25:45 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Damacus Porteng <kernel@bastion.yi.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: IDE-SCSI/HPT366 Problem
In-Reply-To: <20001129225210.A10380@bastion.sprileet.net>
Message-ID: <Pine.LNX.4.10.10011292210320.1035-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2000, Damacus Porteng wrote:

> Andre:
> 
> Is that to say that I'd experience this problem with any EIDE CDRW used on one
> of the HPT366 channels, or is it to say that only several CDRWs aren't
> supported under this chipset?

If you want to run it under PIO mode and not do DMAing then it will work.
Also it goes for any device that does ATAPI DMA and not ATA DMA.
There is a difference!

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
