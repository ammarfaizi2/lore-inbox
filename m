Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbTA2Wl2>; Wed, 29 Jan 2003 17:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265382AbTA2Wl2>; Wed, 29 Jan 2003 17:41:28 -0500
Received: from jstevenson.plus.com ([212.159.71.212]:29909 "EHLO
	alpha.stev.org") by vger.kernel.org with ESMTP id <S264818AbTA2Wl1>;
	Wed, 29 Jan 2003 17:41:27 -0500
Subject: Re: Linux 2.4.21pre3-ac5
From: James Stevenson <james@stev.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301291500.h0TF0xW31184@devserv.devel.redhat.com>
References: <200301291500.h0TF0xW31184@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Jan 2003 22:52:51 +0000
Message-Id: <1043880772.1925.3.camel@god.stev.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

i seem to keep getting really flaky / cracking sounds with the
Via 686a/8233/8235 audio driver 1.9.1-ac2

any ideas on how i can work out whats going wrong ?
Its an on board sound card from the AOpen MK77 board



Via 686a/8233/8235 audio driver 1.9.1-ac2
via82cxxx: Six channel audio available
PCI: Setting latency timer of device 00:11.5 to 64
ac97_codec: AC97 Audio codec, id: ADS96 (Analog Devices AD1885)
via82cxxx: board #1 at 0xE000, IRQ 12
via_audio: ignoring drain playback error -11

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97
Audio Controller (rev 30)
	Subsystem: AOPEN Inc.: Unknown device 006a
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 12
	Region 0: I/O ports at e000 [size=256]

thanks
	James




On Wed, 2003-01-29 at 15:00, Alan Cox wrote:
> This patch fixes the random oops some peopel saw on 2.4.21pre-ac* before.
> It should also fix highmem I/O and a pile of the minor glitches. I've left
> the more interesting changes out of this patch set so that the stability
> stuff can be dealt with first.
> 
> To minimise changes while verifying the fixes this is against pre3 still.



