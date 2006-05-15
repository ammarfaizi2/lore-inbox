Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWEORB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWEORB1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbWEORB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:01:27 -0400
Received: from smtpout06-01.prod.mesa1.secureserver.net ([64.202.165.224]:37602
	"HELO smtpout06-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S964884AbWEORB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:01:26 -0400
Message-ID: <4468B3E5.5090209@seclark.us>
Date: Mon, 15 May 2006 13:01:25 -0400
From: Stephen Clark <Stephen.Clark@seclark.us>
Reply-To: Stephen.Clark@seclark.us
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: how to set this in the future
References: <4466437C.1070306@seclark.us> <1147702848.26686.29.camel@localhost.localdomain>
In-Reply-To: <1147702848.26686.29.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Sad, 2006-05-13 at 16:37 -0400, Stephen Clark wrote:
>  
>
>>Hello List,
>>
>>I need to use ide0=ata66 but I get the following:
>>
>>ide_setup: ide0=ata66 -- OBSOLETE OPTION, WILL BE REMOVED SOON!
>>
>>what will replace this option?
>>    
>>
>
>drivers/scsi/libata .. if I have anything to do with it 8)
>
>Why do you need to use ide0=ata66. What is the hardware requirement that
>causes this ?
>
>Alan
>
>
>  
>
I have a hp pavilion laptop n5430 with an ali chipset. I have a hitachi 
drive that will do udma100 - the docs on my laptop say it will do udma4 
but linux by default is setting it to
udma2.



00:07.0 ISA bridge: ALi Corporation M1533/M1535 PCI to ISA Bridge 
[Aladdin IV/V/
V+]
        Subsystem: ALi Corporation ALi M1533 Aladdin IV/V ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [a0] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 IDE interface: ALi Corporation M5229 IDE (rev c3) (prog-if 8a 
[Master Se
cP PriP])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Step
ping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort
- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max)
        Interrupt: pin A routed to IRQ 255
        Region 4: I/O ports at 1000 [size=16]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot
-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Regards,
Steve

-- 

"They that give up essential liberty to obtain temporary safety, 
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty 
decreases."  (Thomas Jefferson)



