Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSINObG>; Sat, 14 Sep 2002 10:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316856AbSINObG>; Sat, 14 Sep 2002 10:31:06 -0400
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:6826 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S316845AbSINObF> convert rfc822-to-8bit; Sat, 14 Sep 2002 10:31:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jan-Hinnerk Reichert <jan-hinnerk_reichert@hamburg.de>
To: linux-kernel@vger.kernel.org
Subject: Re: DMA problems w/ PIIX3 IDE, 2.4.20-pre4-ac2
Date: Sat, 14 Sep 2002 16:35:33 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209141525.22349.jan-hinnerk_reichert@hamburg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Hinzmann wrote:

> Hi!
> 
> I have problems with DMA mode at one of my boxes ( more technical
> details at the end of this mail ).
[...] 
> But I do issue a "hdparm -d0" for each of them at bootup currently and
> they are running fine then. Enabling DMA with "hdparm -d1" (or not using
> hdparm at all) leads to errors like the following quite fast and
> reproducable:
> 
> kernel: hdb: dma_timer_expiry: dma status == 0x60
> kernel: hdb: timeout waiting for DMA
> kernel: hdb: timeout waiting for DMA
> kernel: hdb: (__ide_dma_test_irq) called while not waiting
> kernel: hdb: status error: status=0x58 { DriveReady SeekComplete
> DataRequest } kernel:
> kernel: hdb: drive not ready for command
> 
> Turning DMA off again stops these.
> 
> 
> I'd love to hear any experience other people have with this mainboard
> or even some statement if DMA is supposed to work with my setup.

I had some problems like this using 2.4.17 on a PIIX3 board (don't know the 
board type). The problems disappeared after switching to 2.4.19. 
Unforunately I had to change the processor and processor fan about the same 
time.

I tend to believe that this problem was related to CPU temperature not to 
kernel bugs. I don't have any means of measuring CPU temperature on this 
board. But the old CPU certainly burnt out, because the fan was not 
working too well ;-(((

