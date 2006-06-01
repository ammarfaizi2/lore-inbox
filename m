Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWFAPzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWFAPzd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 11:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWFAPzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 11:55:33 -0400
Received: from smtp3.nextra.sk ([195.168.1.142]:56337 "EHLO mailhub3.nextra.sk")
	by vger.kernel.org with ESMTP id S1030212AbWFAPzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 11:55:32 -0400
Message-ID: <447F0DF0.9070009@rainbow-software.org>
Date: Thu, 01 Jun 2006 17:55:28 +0200
From: Ondrej Zary <linux@rainbow-software.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Grant Coady <gcoady.lk@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Query: No IDE DMA for IBM 365X with PIIX chipset?
References: <j9bi729h2u4dcn9da7na3t1d8ckk477d9b@4ax.com> <1149169812.12932.20.camel@localhost>
In-Reply-To: <1149169812.12932.20.camel@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sul, 2006-05-28 at 15:29 +1000, Grant Coady wrote:
>> PIIXa: chipset revision 2
>> PIIXa: not 100% native mode: will probe irqs later
>> PIIXa: neither IDE port enabled (BIOS)
> 
> It thinks the chip has not been activated, and then falls back to the
> legacy driver. Could be incorrect enable checks or other problems.
> 
>> 00:01.0 ISA bridge: Intel Corporation 82371FB PIIX ISA [Triton I] (rev 02)
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
>>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>>         Latency: 0
>> 00: 86 80 2e 12 07 00 80 02 02 00 01 06 00 00 00 00
>> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 82371FB, whee thats prehistoric 8)
> 
> I don't actually have any support for the 371FB PIIX in either driver as
> I've not been able to find a source for the data sheet to the chip. It
> may work if added to the drivers/scsi/pata_oldpiix identifiers in the
> 2.6.17rc5-mm kernel. Would be useful to know as I don't know anyone else
> with that chip any more 8)
> 

Isn't that this one? 
http://www.intel.com/design/chipsets/datashts/290550.htm
Used in i430FX chipset. I have some boards with that and they always 
worked fine. Haven't tried any recent kernels, though.

-- 
Ondrej Zary
