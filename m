Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132640AbRDBJBy>; Mon, 2 Apr 2001 05:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132642AbRDBJBo>; Mon, 2 Apr 2001 05:01:44 -0400
Received: from [202.77.223.60] ([202.77.223.60]:6 "HELO server.achan.com")
	by vger.kernel.org with SMTP id <S132640AbRDBJBj>;
	Mon, 2 Apr 2001 05:01:39 -0400
Message-ID: <01ba01c0bb53$4e607d80$91b54dca@portal2.com>
From: "Andrew Chan" <achan@achan.com>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10104020024550.12531-100000@master.linux-ide.org>
Subject: Re: Promise 20267 "working" but no UDMA
Date: Mon, 2 Apr 2001 17:00:03 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick says:

>> FastTrack config: only 1 drive, configured as a SPAN volume consisting of
1 drive

> No RAIDing allowed in the FTTK Bios.

But my motherboard hangs at boot time (while Fasttrack tests for arrays) if
there is no array defined! There is a message from the Fasttrack bios that
says something like "no array found, press some key to continue". But I need
to remotely reboot these servers!

>> The following is from dmesg:
>>
>> PCI: Found IRQ 10 for device 00:03.0
>> PDC20267: chipset revision 2
>> PDC20267: not 100% native mode: will probe irqs later
>> PDC20267: ROM enabled at 0xfeae0000
>> PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.

> This is a RAID mode BIOS and that is specified to disable under linux
> unless a 0x55AA valid signature is present

>> PDC20267: neither IDE port enabled (BIOS)

> And it does!

Which means? Can the Linux IDE driver be made to not deal with the Fasttrack
"raid" code and just treat the interface as normal non-raid ATA100
interfaces?

It is a real pity that Promise (the company) somehow doesn't seem to work
well with the Linux community. It is fast hardware (and I have 25 of them)
that lies useless for me right now.

Many thanks....

Andrew Chan



