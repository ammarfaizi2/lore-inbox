Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSHRSAn>; Sun, 18 Aug 2002 14:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315455AbSHRSAm>; Sun, 18 Aug 2002 14:00:42 -0400
Received: from mail14.speakeasy.net ([216.254.0.214]:1936 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S315454AbSHRSAm>; Sun, 18 Aug 2002 14:00:42 -0400
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
From: Ed Sweetman <safemode@speakeasy.net>
To: Jonathan Lundell <linux@lundell-bros.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <p05111a2bb9858e64756e@[207.213.214.37]>
References: <1029653085.674.53.camel@psuedomode>
	<1029655603.2970.6.camel@psuedomode> 
	<p05111a2bb9858e64756e@[207.213.214.37]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 14:04:42 -0400
Message-Id: <1029693883.516.2.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




the dmesg i included shows my chipsets
 VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
PDC20262: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.





On Sun, 2002-08-18 at 13:50, Jonathan Lundell wrote:
> At 3:26 AM -0400 8/18/02, Ed Sweetman wrote:
> >It appears then that there are some DMA issues with the promise 
> >controller i have with the driver.  My swap used to be on the drive 
> >on the promise controller before which would explain fs corruption 
> >on both drives (swap cached and such).
> 
> FWIW, this is a semi-well-known phenomenon with the IDE controller in 
> the ServerWorks OSB4 south bridge. As I recall from our testing, a 
> word appears to be dropped in the DMA transfer to the disk. We found 
> that both PIO and multi-word DMA worked OK.
> 
> What's your chipset?
> -- 
> /Jonathan Lundell.
> 


