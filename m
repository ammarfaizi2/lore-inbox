Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbUAGRmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbUAGRmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:42:35 -0500
Received: from fatbastard.bmind.it ([195.120.246.30]:30849 "EHLO
	fatbastard.bmind.it") by vger.kernel.org with ESMTP id S261733AbUAGRmA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:42:00 -0500
Message-ID: <3FFC442D.1030501@bmind.it>
Date: Wed, 07 Jan 2004 18:38:53 +0100
From: Paolo Dovera <pdovera@bmind.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031230
X-Accept-Language: it, en-us, en
MIME-Version: 1.0
To: sumit_uconn@lycos.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Ethernet Card Intel Pro100
References: <BEAEEFBEGJLPJJAA@mailcity.com>
In-Reply-To: <BEAEEFBEGJLPJJAA@mailcity.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm using kernel 2.6.0 and works fine. If could be useful my 
configuration is:

hardware configuration:
02:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet 
Controller (rev 03)
        Subsystem: COMPAL Electronics Inc: Unknown device 0012
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e8100000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 4000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

software configuration
modutils-2.4.25-1
initscripts-7.14-1
vanilla kernel 2.6.0
RH 9.0A

just a point: I load the e100 module AFTER i810_audio (to avoid sampling 
frequency problem)

Regards,
Paolo




Sumit Narayan wrote:

>Hi...
>
>I have loaded the new kernel 2.6.0, but my Ethernet card is not working on it. Its Intel Ether Pro 100B. Could someone help me out with it. Its working perfectly fine with 2.4.21. Is there any special setting to be made for the new kernel? I have used module-init-tools-0.9.14 to install the modules.
>
>Regrads,
>Sumit
>
>
>____________________________________________________________
>Get advanced SPAM filtering on Webmail or POP Mail ... Get Lycos Mail!
>http://login.mail.lycos.com/r/referral?aid=27005
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

