Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVBSUa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVBSUa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 15:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVBSUa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 15:30:29 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:45976 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261792AbVBSUaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 15:30:20 -0500
Subject: Re: intel8x0: no sound in 2.6.11 rc3 & 4 (fine with 2.6.10)
From: Lee Revell <rlrevell@joe-job.com>
To: uaca@alumni.uv.es
Cc: linux-kernel@vger.kernel.org, Tomas Szepe <szepe@pinerecords.com>,
       alsa-devel <alsa-devel@lists.sourceforge.net>
In-Reply-To: <20050219121157.GA14437@pusa.informat.uv.es>
References: <20050219121157.GA14437@pusa.informat.uv.es>
Content-Type: text/plain
Date: Sat, 19 Feb 2005 15:30:18 -0500
Message-Id: <1108845018.10705.19.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please cc: alsa-devel when reporting ALSA issues.

Lee


On Sat, 2005-02-19 at 13:11 +0100, uaca@alumni.uv.es wrote:
> Hello
> 
> I have read a post in lkml.org that states that the problem experienced in
> rc3 has gone (1). That is not the case for me.
> 
> My audio device is
> 
> 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
>         Subsystem: IBM: Unknown device 0554
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Interrupt: pin B routed to IRQ 11
>         Region 0: I/O ports at 1c00 [size=256]
>         Region 1: I/O ports at 18c0 [size=64]
>         Region 2: Memory at d0100c00 (32-bit, non-prefetchable) [size=512]
>         Region 3: Memory at d0100800 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [50] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 
> In 2.6.10 and in 2.6.11-rc3 & 4 the clock is set to 48khz.
> 
> eg:
> 
> intel8x0_measure_ac97_clock: measured 49502 usecs
> intel8x0: clocking to 48000
> 
> It uses an Analog Devices AD1981B
> 
> I have put a tar file of the /proc/asound directory of 2.6.10 and 2.6.11-rc4 in
> 
> 	http://pusa.uv.es/~ulisses/asound-intel8x0/
> 
> the tar files were done while playing pcm audio, (not being eard in rc4).
> 
> I have found that I had to Mute __both__ "Headphone Jack Sense" and
> "Line Jack Sense" in order to ear the audio in rc4.
> 
> Please let me know if you need further info or you want a tester
> 
> All this is on a IBM Thinkpad R51 - Type 2887 -AVG
> 
> (tot toc: IBM, we're buying your laptops too)
> 
> Thanks in advance
> 
> 	Ulisses			
> 
> (1) http://lkml.org/lkml/2005/2/18/93											

