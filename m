Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317590AbSINWiP>; Sat, 14 Sep 2002 18:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317592AbSINWiP>; Sat, 14 Sep 2002 18:38:15 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:18705
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317590AbSINWiO>; Sat, 14 Sep 2002 18:38:14 -0400
Date: Sat, 14 Sep 2002 15:40:52 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: DMA problems w/ PIIX3 IDE, 2.4.20-pre4-ac2
In-Reply-To: <200209141525.22349.jan-hinnerk_reichert@hamburg.de>
Message-ID: <Pine.LNX.4.10.10209141539550.6925-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep I had that problem too and fixed it.
Please try a newer pre5-acX


On Sat, 14 Sep 2002, Jan-Hinnerk Reichert wrote:

> Florian Hinzmann wrote:
> 
> > Hi!
> > 
> > I have problems with DMA mode at one of my boxes ( more technical
> > details at the end of this mail ).
> [...] 
> > But I do issue a "hdparm -d0" for each of them at bootup currently and
> > they are running fine then. Enabling DMA with "hdparm -d1" (or not using
> > hdparm at all) leads to errors like the following quite fast and
> > reproducable:
> > 
> > kernel: hdb: dma_timer_expiry: dma status == 0x60
> > kernel: hdb: timeout waiting for DMA
> > kernel: hdb: timeout waiting for DMA
> > kernel: hdb: (__ide_dma_test_irq) called while not waiting
> > kernel: hdb: status error: status=0x58 { DriveReady SeekComplete
> > DataRequest } kernel:
> > kernel: hdb: drive not ready for command
> > 
> > Turning DMA off again stops these.
> > 
> > 
> > I'd love to hear any experience other people have with this mainboard
> > or even some statement if DMA is supposed to work with my setup.
> 
> I had some problems like this using 2.4.17 on a PIIX3 board (don't know the 
> board type). The problems disappeared after switching to 2.4.19. 
> Unforunately I had to change the processor and processor fan about the same 
> time.
> 
> I tend to believe that this problem was related to CPU temperature not to 
> kernel bugs. I don't have any means of measuring CPU temperature on this 
> board. But the old CPU certainly burnt out, because the fan was not 
> working too well ;-(((
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

