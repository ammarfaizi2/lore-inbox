Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316941AbSEWRkF>; Thu, 23 May 2002 13:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316970AbSEWRkE>; Thu, 23 May 2002 13:40:04 -0400
Received: from pier.botik.ru ([193.232.174.1]:47083 "EHLO pier.botik.ru")
	by vger.kernel.org with ESMTP id <S316941AbSEWRkD>;
	Thu, 23 May 2002 13:40:03 -0400
Message-ID: <3CED2B73.ABA3C95F@namesys.botik.ru>
Date: Thu, 23 May 2002 21:48:35 +0400
From: "Gryaznova E." <grev@namesys.botik.ru>
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.19-pre6-testing i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: IDE problem: linux-2.5.17
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFA15.8040707@evision-ventures.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have 40 wires cable. When ide=nodma is passed to 2.5.17 kernel - kernel boots.
Am I correct that it is not possible to have DMA on with such cable?
Is there any reason for doing that?

Note that bus speed is 33 MHz when kernel fails to boot. I mean - how do I specify slower bus speed: 22 MHz?

Thanks.
Lena.

Martin Dalecki wrote:

> Uz.ytkownik Gryaznova E. napisa?:
> > Hello.
> >
> > Kernel starting from 2.5.8 can not boot my Suse 6.4. Booting on those
> > kernels (tested 2.5.8, 2.5.9 and 2.5.17) I am always getting
> >
> > { dma_intr }
> > hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
> > hda: recalibrating!
> >
> > and system either hangs or falls into endless loop.
> >
> > Kernel 2.5.7 boots and works just fine.
> > The boot log containing information about hardware is attached.
> >
> > Badblock does not see any bad blocks.
> >
> > Thanks for any clue on the problem.
> > Lena.
>

[skipped]

> >
> > ------------------------------------------------------------------------
> You just have cabling problems which where previously hidden by
> the driver resorting to slower operation modes.
>
> So please first have a look at the cabling inside your system.
> (First of all plase make sure of course that you are using
> a 80 wirde cable.) Or have a look in to the host chip driver
> and penalize the transfer mode supported to lower speeds.
> You can achieve basically a similar effect by setting
> the busspeed kernel parameter to some artificially high value
> as well.



