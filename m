Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263144AbTC1U6Q>; Fri, 28 Mar 2003 15:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263145AbTC1U6Q>; Fri, 28 Mar 2003 15:58:16 -0500
Received: from ncc1701.cistron.net ([62.216.30.38]:52999 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S263144AbTC1U6P>; Fri, 28 Mar 2003 15:58:15 -0500
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: IDE DMA problems
Date: Fri, 28 Mar 2003 21:09:31 +0000 (UTC)
Organization: Cistron
Message-ID: <b62dmb$bad$1@news.cistron.nl>
References: <20030328192717.GA16621@pclab.ifg.uni-kiel.de>
X-Trace: ncc1701.cistron.net 1048885771 11597 62.216.30.38 (28 Mar 2003 21:09:31 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torsten Landschoff  <torsten@debian.org> wrote:
>Using hdparm -X 66 to set it to udma2 just kills off dma with these
>error messages:
>
>  hda: timeout waiting for DMA
>  ide_dmaproc: chipset supported ide_dma_timeout func only: 14
>  hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }
>  hda: drive not ready for command
>  blk: queue c0370084, I/O limit 4095Mb (mask 0xffffffff)
>  hda: lost interrupt
>

I've experienced similar "problems/events".

If i enable unix processor apic but NOT IO-APIC i don't have these
problems.

Could you recompile your kernel and see if this solves it ?
I have encountered these problems on several machines with different
hardware (p4 & amd athlon).

Regards,

Danny

-- 
Miguel   | "I can't tell if I have worked all my life or if
de Icaza |  I have never worked a single day of my life,"

