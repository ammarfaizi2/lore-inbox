Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317845AbSHFHRc>; Tue, 6 Aug 2002 03:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318175AbSHFHRc>; Tue, 6 Aug 2002 03:17:32 -0400
Received: from 217-13-24-22.dd.nextgentel.com ([217.13.24.22]:40630 "EHLO
	mail.ihatent.com") by vger.kernel.org with ESMTP id <S317845AbSHFHRb>;
	Tue, 6 Aug 2002 03:17:31 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: venom@sns.it, Thomas Munck Steenholdt <tmus@get2net.dk>,
       linux-kernel@vger.kernel.org
Subject: Re: i810 sound broken...
References: <Pine.LNX.4.43.0208051546120.8463-100000@cibs9.sns.it>
	<1028561325.18478.55.camel@irongate.swansea.linux.org.uk>
From: Alexander Hoogerhuis <alexh@ihatent.com>
Date: 05 Aug 2002 23:38:10 +0200
In-Reply-To: <1028561325.18478.55.camel@irongate.swansea.linux.org.uk>
Message-ID: <m31y9dt29p.fsf@lapper.ihatent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Different thing about 810, brand spanking new Compaq
Game^H^H^H^Hlaptop and it gives good sound, but shows this on boot:

i810: Intel ICH3 found at IO 0x4400 and 0x4000, IRQ 5
i810_audio: Audio Controller supports 6 channels.
ac97_codec: AC97 Audio codec, id: 0x4144:0x5363 (Unknown)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's \
not present), total channels = 2

lspci -vvv shows this:

00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio (rev 02)
	Subsystem: Compaq Computer Corporation: Unknown device 004a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 5
	Region 0: I/O ports at 4000 [size=256]
	Region 1: I/O ports at 4400 [size=64]

Under Windows XP it likes to call itself a SoundMAX device.

Hope its of help?

ttfn,
A

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Mon, 2002-08-05 at 14:47, venom@sns.it wrote:
> > Still OSS modules for i810 does not work with 2.5 kernels, actually 2.4
> > is fine. No time to switch to alsa (and not interested for now too).
> 
> OSS for 2.5 is someone elses problem. I have no plan to do any work on
> the old OSS drivers for the 2.5 tree or even to submit 2.4 updates into
> 2.5 for it. 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Alexander Hoogerhuis                               | alexh@ihatent.com
CCNP - CCDP - MCNE - CCSE                          | +47 908 21 485
"You have zero privacy anyway. Get over it."  --Scott McNealy
