Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVKSUFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVKSUFL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 15:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbVKSUFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 15:05:11 -0500
Received: from styx.suse.cz ([82.119.242.94]:4812 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1750785AbVKSUFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 15:05:10 -0500
Date: Sat, 19 Nov 2005 21:05:03 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Larry.Finger@lwfinger.net" <Larry.Finger@att.net>
Cc: kernel <linux-kernel@vger.kernel.org>
Subject: Re: DMA mode locked off when via82cxxx ide driver built as module in 2.6.14
Message-ID: <20051119200503.GA19921@midnight.ucw.cz>
References: <111920051952.4178.437F8296000E123B0000105221603763169D0A09020700D2979D9D0E04@att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <111920051952.4178.437F8296000E123B0000105221603763169D0A09020700D2979D9D0E04@att.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2005 at 07:52:55PM +0000, Larry.Finger@lwfinger.net wrote:

> Sorry, here is the whole lspci -vv listing. Incidentally, the fix
> suggested by Bartlomiej Zolnierkiewicz that I needed to disable
> generic IDE support (CONFIG_IDE_GENERIC=y) is correct. Once I disabled
> that parameter, all is well. Thanks for your help.

Indeed, vt8231 is well supported.
 
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8231 [PCI-to-ISA Bridge] (rev 10)
>         Subsystem: Hewlett-Packard Company: Unknown device 0022
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 0
>         Capabilities: [c0] Power Management version 2
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
