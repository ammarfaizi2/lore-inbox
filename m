Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264780AbRF2JZw>; Fri, 29 Jun 2001 05:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265802AbRF2JZm>; Fri, 29 Jun 2001 05:25:42 -0400
Received: from [194.128.63.73] ([194.128.63.73]:1873 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S265801AbRF2JZh>; Fri, 29 Jun 2001 05:25:37 -0400
Message-ID: <3B3C4976.9DFE000D@ukaea.org.uk>
Date: Fri, 29 Jun 2001 10:25:10 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
Organization: UKAEA Fusion
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mythos <papadako@csd.uoc.gr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with Via VT82C686A
In-Reply-To: <Pine.GSO.4.33.0106290600290.28793-100000@iridanos.csd.uch.gr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

mythos wrote:
> 
> I have installed a second hard drive in my system in the second
> channel of my controller.But when I try to enable DMA I get:
> hdc: DMA disabled
> hdc: timeout waiting for DMA
> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
> [snip]
> I thought that there were problems only with Via VT82C686B.
> Can anyone please help me?
> My motherbord is an ASUS K7V with KX133 chipset.

Well, I posted a message about three weeks ago "IDE corruption, 2.2, VIA
chipset in PIO mode" in which I described problems with a VIA 686A + IBM
75GXP, which occurred in both UDMA and PIO modes.

I thought Alan Cox's suggestion of cable problems seemed believable at
the time (and duly performed the brown paper bag).

But, I've since removed disk+cable and transferred them to a Dell system
(810 chipset) and really hammered the disk.  I deliberately didn't
install the (newly arrived) 80-core cables because I wanted to try and
exonerate the VIA mobo by reproducing the errors on the Dell.

>From the buildup, you've probably guessed that I have failed to
reproduce the error...  Despite a serious workover, no errors
whatsoever.  (Of course, it might still not be the VIA chipset's fault.)

Due to limited time and the fact that the VIA machines are more or less
24-hour production boxes, I may not be able to retry the disk+cable on
the 686A chipset, but the whole experience has soured me on VIA.  Web
searches with "linux via ide corruption" show scary hit rates.

Also, the VIA web site has what it laughably bills as fixes for the
"alleged" 686b problems, but (to paraphrase) it basically says "try
this, and it should work, but if not then try this, this, this, this,
and then some unsupported stuff contributed by users...".  Call me a
pedant if you like, but that isn't language to convince me that they (A)
understand the problem, (B) have fixed the problem.

Add to that (see Alan's remarks over an extended period) the fact that
they really don't appear Linux-friendly with regard to providing
information...  I won't be allowing any more VIA boards on-site.

Neil
