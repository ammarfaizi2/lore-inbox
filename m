Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbTADTUU>; Sat, 4 Jan 2003 14:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbTADTUU>; Sat, 4 Jan 2003 14:20:20 -0500
Received: from shell4.BAYAREA.NET ([209.128.82.1]:16389 "EHLO
	shell4.bayarea.net") by vger.kernel.org with ESMTP
	id <S261321AbTADTUT>; Sat, 4 Jan 2003 14:20:19 -0500
Message-ID: <3E173679.6050807@bayarea.net>
Date: Sat, 04 Jan 2003 11:31:05 -0800
From: Randy Broman <rbroman@bayarea.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: linux-kernel@vger.kernel.org, rbroman@bayarea.net
Subject: Re: RH73 Promise ATA/133 Install Problems
References: <200301041859.h04IxaGQ002334@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# lspci -v -v

00:0f.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 
01) (prog-if 85)
Subsystem: Giga-byte Technology: Unknown device b001
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

Latency: 32 (1000ns min, 4500ns max), cache line size 08
Interrupt: pin A routed to IRQ 10
Region 0: I/O ports at e800 [size=8]
Region 1: I/O ports at e400 [size=4]
Region 2: I/O ports at e000 [size=8]
Region 3: I/O ports at dc00 [size=4]
Region 4: I/O ports at d800 [size=16]
Region 5: Memory at dffc000 (32-bit, non-prefetchable) [size=16K]
Capabilities: [60] Power Management version 1
              Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
              Status: D0 PME-Enable- DSel=0 DScale=0 PME-


John Bradford wrote:

>>I have a  Gigabyte GA-7VRXP motherboard which has an on-board
>>Promise 20276 ATA133/RAID controller. I want to install RH73, on the
>>two ATA133 drives connected to the Promise controller. I've set up
>>the motherboard BIOS with the Promise 20276 interfaces as ATA (not
>>RAID), and I want to install on the two drives in a software RAID
>>configuration.
>>
>>If I start the standard RH73 install it does not identify the two drives 
>>connected to the Promise interfaces.
>>
>
>Support for the Promise 20276 went in to the kernel at 2.4.19-pre6.
>
>Can you get to a command prompt and post the output of lspci -v -v?
>Maybe it has a non standard PCI id and is not being recognised.
>
>John.
>


