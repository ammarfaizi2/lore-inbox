Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265699AbSJXWZO>; Thu, 24 Oct 2002 18:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265696AbSJXWZO>; Thu, 24 Oct 2002 18:25:14 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:45190 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265694AbSJXWZM>; Thu, 24 Oct 2002 18:25:12 -0400
Date: Thu, 24 Oct 2002 15:25:19 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
cc: Hanna Linder <hannal@us.ibm.com>, tmolina@cox.net, haveblue@us.ibm.com
Subject: more aic7xxx boot failure
Message-ID: <8800000.1035498319@w-hlinder>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>                                2.5 Kernel Problem Reports as of 22 Oct
>    Status                 Discussion  Problem Title
> 
>    open                   04 Oct 2002 AIC7XXX boot failure
>    1. http://marc.theaimsgroup.com/?l=linux-kernel&m=103356254615324&w=2
> 


This may be a different problem but it is related to the aic7xxx
driver. My system is a 2-way PIII 500MHz 2.5GB RAM box. It boots
if I remove the aic7xxx driver. This is on 2.5.44 btw. Works fine
on 2.4.x.

Here is the output from lspci -v -v:


00:06.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 04)
	Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD AIC-7895B
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2000ns min, 2000ns max)
	Interrupt: pin A routed to IRQ 15
	Region 0: I/O ports at 2200 [disabled] [size=256]
	Region 1: Memory at febfe000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 04)
	Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD AIC-7895B
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 80 (2000ns min, 2000ns max)
	Interrupt: pin B routed to IRQ 10
	Region 0: I/O ports at 2300 [disabled] [size=256]
	Region 1: Memory at febfd000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-



