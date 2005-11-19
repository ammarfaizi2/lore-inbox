Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbVKSTnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbVKSTnn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 14:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVKSTnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 14:43:43 -0500
Received: from styx.suse.cz ([82.119.242.94]:46027 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750731AbVKSTnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 14:43:42 -0500
Date: Sat, 19 Nov 2005 20:43:35 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Larry.Finger@lwfinger.net" <Larry.Finger@att.net>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: DMA mode locked off when via82cxxx ide driver built as module in 2.6.14
Message-ID: <20051119194335.GA19589@midnight.ucw.cz>
References: <111920051923.4214.437F7BBF00022AD50000107621603763169D0A09020700D2979D9D0E04@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <111920051923.4214.437F7BBF00022AD50000107621603763169D0A09020700D2979D9D0E04@att.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 07:23:43PM +0000, Larry.Finger@lwfinger.net wrote:
> 
>  -------------- Original message ----------------------
> From: Vojtech Pavlik <vojtech@suse.cz>
> > On Sat, Nov 19, 2005 at 06:59:37PM +0000, Larry.Finger@lwfinger.net wrote:
> > > My HP ze1115 notebook uses the via82cxxx ide driver. If I configure the kernel 
> > build to make that driver as a module, the driver is correctly added to initrd 
> > and is loaded at boot time; however, DMA mode is turned off. It cannot be turned 
> > on even if I use an 'hdparm -d1 /dev/hda' command.
> > > 
> > > Is this a bug, or do I need some kind of IDE=XXX boot command? As expected, 
> > system performance in this mode is horrible.
> >  
> > What chipset does your notebook use? 'lspci -vv' should give a good
> > answer.
> 
> Portion of output of lspci -vv:
>  
> 00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
>         Subsystem: Hewlett-Packard Company: Unknown device 0022
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 64
>         Region 4: I/O ports at 1100 [size=16]
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
I need the portion for the ISA bridge, surprisingly, to know.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
