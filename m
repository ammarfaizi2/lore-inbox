Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290458AbSAQUxI>; Thu, 17 Jan 2002 15:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290460AbSAQUw7>; Thu, 17 Jan 2002 15:52:59 -0500
Received: from smtp-out-4.wanadoo.fr ([193.252.19.23]:45755 "EHLO
	mel-rto4.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S290458AbSAQUws>; Thu, 17 Jan 2002 15:52:48 -0500
Subject: Re: CM8338 hissing sound with linux kernel 2.4.6 to 2.4.17
From: Thomas Cataldo <thomas.cataldo@laposte.net>
To: vernie@skyinet.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020117054825Z288185-13996+7371@vger.kernel.org>
In-Reply-To: <20020116.170852.91311984.davem@redhat.com>
	<Pine.GSO.4.40.0201161827510.28457-100000@apogee.whack.org>
	<20020116.211251.35505694.davem@redhat.com> 
	<20020117054825Z288185-13996+7371@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 17 Jan 2002 21:54:35 +0100
Message-Id: <1011300875.670.18.camel@buffy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-17 at 06:48, vernie@skyinet.net wrote:
> 
> 
> Good day!
> 
> I have the same problems with C-Media 8338A soundchip and the problem still exists with 
> linux kerner 2.4.17 and even with 2.4.18-pre3.  Only wav files can be played with 
> no noise, mp3 and ogg files produce noisy hissing sound covering a somewhat 
> delayed music. I believe this is a kernel related problem.


Same problem here, the sound driver is completely unusable as the music
(mp3) seems to play ten times slower than what it should.

My workaround is to use the alsa driver. 

I think the driver broke near the beginning of the 2.4 stable series.



00:0c.0 Multimedia audio controller: C-Media Electronics Inc CM8338A
(rev 10)
	Subsystem: C-Media Electronics Inc CMI8338/C3DX PCI Audio Device
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at dc00 [size=256]
	Capabilities: [c0] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



