Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131266AbQK0Brv>; Sun, 26 Nov 2000 20:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135236AbQK0Brl>; Sun, 26 Nov 2000 20:47:41 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:45585
        "EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
        id <S131266AbQK0Br1>; Sun, 26 Nov 2000 20:47:27 -0500
Date: Sun, 26 Nov 2000 17:17:08 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Christian Roessner <chr.roessner@t-online.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: (U)DMA, dma_intr status=0x51, error=0x84
In-Reply-To: <1407NL-1qe1CqC@fwd01.sul.t-online.com>
Message-ID: <Pine.LNX.4.10.10011261712410.12346-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000, Christian Roessner wrote:

> hda: dma_intr status=0x51 {DriveReadySeekComplete Error}
> hda: dma_intr  error=0x84 {DriveStatusError BadCRC}

This is what it tells you directly.  You have dirty crosstalk on your
ribbon.  Basically nothing is wrong, except you can not safely support
that transfer rate.

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
