Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267112AbSLKKz1>; Wed, 11 Dec 2002 05:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267114AbSLKKz1>; Wed, 11 Dec 2002 05:55:27 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:5768 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267112AbSLKKz0>; Wed, 11 Dec 2002 05:55:26 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: CD Writing in 2.5.51
References: <1039598049.480.7.camel@nirvana> <87fzt43nm4.fsf@web.de>
	<1039599708.711.9.camel@nirvana> <87adjc3n30.fsf@web.de>
	<1039603261.531.6.camel@nirvana>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Wed, 11 Dec 2002 12:02:40 +0100
In-Reply-To: <1039603261.531.6.camel@nirvana> (mdew's message of "11 Dec
 2002 23:40:58 +1300")
Message-ID: <8765u03jjj.fsf@web.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* mdew  writes:
>awesome, i got it to work, thanks.. tho I'm now trying to enable the
>DMA on the drives... (unsuccessfully)
 
>/dev/hda == CDRW (24/12/40)
>/dev/hdb == DVDROM (8/40)

>/dev/hda:
> setting using_dma to 1 (on)
> HDIO_SET_DMA failed: Operation not permitted
> using_dma    =  0 (off)
>nirvana:~# hdparm -d1 /dev/hdb

>/dev/hdb:
> setting using_dma to 1 (on)
> HDIO_SET_DMA failed: Operation not permitted
> using_dma    =  0 (off)

Perhaps CONFIG_IDEDMA_ONLYDISK is set? Or you don't have compiled in
the specific driver for your chipset?

regards
Markus

