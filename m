Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVABRF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVABRF6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 12:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVABRF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 12:05:58 -0500
Received: from banana.active-ns.com ([213.230.202.60]:37764 "EHLO
	banana.catalyst2.com") by vger.kernel.org with ESMTP
	id S261277AbVABRFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 12:05:50 -0500
Message-ID: <41D82A01.4040308@linuxmod.co.uk>
Date: Sun, 02 Jan 2005 17:06:09 +0000
From: Joel Cant <lkml@linuxmod.co.uk>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Promise 20269 (Rev 02) IDE controller
References: <41D73EBE.1040808@linuxmod.co.uk> <41D74432.5030706@sbcglobal.net>
In-Reply-To: <41D74432.5030706@sbcglobal.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - banana.catalyst2.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxmod.co.uk
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert W. Fuller wrote:

> I probably have the same card.  This works perfectly in my box and I 
> do raw video capture with it (sustained 20+ MB/second.)  Thus, I 
> suspect the problem is specific to your system.  Here's my lspci -vv:
>
> 0000:00:0f.0 Unknown mass storage controller: Promise Technology, Inc. 
> 20269 (re
> v 02) (prog-if 85)
>         Subsystem: Promise Technology, Inc. Ultra133TX2
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
> ParErr- Step
> ping- SERR- FastB2B-
>         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
> <TAbort-
> <MAbort- >SERR- <PERR-
>         Latency: 32 (1000ns min, 4500ns max), cache line size 08
>         Interrupt: pin A routed to IRQ 19
>         Region 0: I/O ports at a800
>         Region 1: I/O ports at ac00 [size=4]
>         Region 2: I/O ports at b000 [size=8]
>         Region 3: I/O ports at b400 [size=4]
>         Region 4: I/O ports at b800 [size=16]
>         Region 5: Memory at e3000000 (32-bit, non-prefetchable) 
> [size=16K]
>         Capabilities: [60] Power Management version 1
>                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
> PME(D0-,D1-,D2-,D3hot
> -,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
>

Hi,

Seems our cards are very similar, out of interest what kernel are you 
running, and whats your kernel .config, Would it be anything to do with 
running it in a pci-x slot, although that shouldent be an issue. What is 
the possiblity of a hardware fault, dont want to organise an RMA then 
them tell me its fine under winblows, is there anyway to spew out a bit 
more info on the error, or run a test on it?

Thanks

Joel

