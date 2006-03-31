Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbWCaQtV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWCaQtV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWCaQtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:49:20 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:45969
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1750763AbWCaQtU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:49:20 -0500
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: snd_hda_intel on 2.6.16
Date: Fri, 31 Mar 2006 10:49:19 -0600
Message-Id: <20060331164310.M92123@linuxwireless.org>
In-Reply-To: <1143823259.24736.24.camel@mindpipe>
References: <20060331162023.M25456@linuxwireless.org> <1143823259.24736.24.camel@mindpipe>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 15.235.153.101 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2006 11:40:58 -0500, Lee Revell wrote
> On Fri, 2006-03-31 at 10:29 -0600, Alejandro Bonilla wrote:
> > Hi,
> > 
> > I read about a problem with snd_hda_intel latelly on 2.6.16. I was not having
> > this on 2.6.15-19 but looks like it is "chip-monking"
> >
> 
> Too cryptic.  What exactly is the problem?

The sound is like at 1.2x. Just a little bit faster but noticeable.

> 
> > I use linux2.6 git and it is still present. Just wanted to let you'll know
> > about it.
> > 
> > Should anyone need any info, please let me know.
> >
> 
> Well, for starters, your hardware info ("hda-intel" describes 1000s 
> of slightly different devices).

0000:00:1b.0 0403: Intel Corporation 82801G (ICH7 Family) High Definition
Audio Controller (rev 02)
        Subsystem: Hewlett-Packard Company: Unknown device 30a0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 50
        Region 0: Memory at d8240000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] #10 [0091]

Pretty much, I almost only know it is Conexant.

> 
> Does it work with the latest ALSA CVS or 1.0.11-rc4?

I don't know. It was working with 2.6.15-X

.Alejandro

> 
> Lee


