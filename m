Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbSLKL1W>; Wed, 11 Dec 2002 06:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267118AbSLKL1W>; Wed, 11 Dec 2002 06:27:22 -0500
Received: from mx1.visp.co.nz ([210.55.24.20]:56324 "EHLO mail.visp.co.nz")
	by vger.kernel.org with ESMTP id <S267117AbSLKL1W>;
	Wed, 11 Dec 2002 06:27:22 -0500
Subject: Re: CD Writing in 2.5.51
From: mdew <mdew@orcon.net.nz>
To: Markus Plail <linux-kernel@gitteundmarkus.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <8765u03jjj.fsf@web.de>
References: <1039598049.480.7.camel@nirvana> <87fzt43nm4.fsf@web.de>
	<1039599708.711.9.camel@nirvana> <87adjc3n30.fsf@web.de>
	<1039603261.531.6.camel@nirvana>  <8765u03jjj.fsf@web.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 12 Dec 2002 00:35:02 +1300
Message-Id: <1039606504.447.0.camel@nirvana>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-12 at 00:02, Markus Plail wrote:
> * mdew  writes:
> >awesome, i got it to work, thanks.. tho I'm now trying to enable the
> >DMA on the drives... (unsuccessfully)
>  
> >/dev/hda == CDRW (24/12/40)
> >/dev/hdb == DVDROM (8/40)
> 
> >/dev/hda:
> > setting using_dma to 1 (on)
> > HDIO_SET_DMA failed: Operation not permitted
> > using_dma    =  0 (off)
> >nirvana:~# hdparm -d1 /dev/hdb
> 
> >/dev/hdb:
> > setting using_dma to 1 (on)
> > HDIO_SET_DMA failed: Operation not permitted
> > using_dma    =  0 (off)
> 
> Perhaps CONFIG_IDEDMA_ONLYDISK is set? Or you don't have compiled in
> the specific driver for your chipset?

yeah my mistake, CONFIG_IDEDMA_ONLYDISK was selected, fixed..thanks for
help dude..much appreciated.

-mdew

