Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288604AbSADLb7>; Fri, 4 Jan 2002 06:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288603AbSADLbt>; Fri, 4 Jan 2002 06:31:49 -0500
Received: from abaddon02.airbus.dasa.de ([193.96.150.5]:47612 "EHLO
	abaddon02.airbus.dasa.de") by vger.kernel.org with ESMTP
	id <S287632AbSADLbb>; Fri, 4 Jan 2002 06:31:31 -0500
Message-ID: <ADC649D6283BD511B2A90008C71E93BF33A432@s02mks8.ham.airbus.dasa.de>
From: "Bartels, Christian" <Christian.Bartels@airbus.dasa.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 53c810 SCSI controller not accessible on type-2 config PCI [K
	ernel 2.4.17]
Date: Fri, 4 Jan 2002 12:30:49 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>     Non-VGA device: NCR 53c810 (rev 1).
>>       Medium devsel.  IRQ 10.  Master Capable.  Latency=80.  
>>       I/O at 0xd000 [0xd001].

>What does this device look like in 2.2.18 ?

The above was the output of 'cat /proc/pci' under 2.2.18. The
corresponding output for 2.4.17 is:

   Bus  0, device   5, function  0:
     Class 0000: PCI device 1000:0001 (rev 1)
       IRQ 10
       Master Capable.  Latency=80.
       I/O at 0xd000 [0xd0ff]
       Non-prefetchable 32 bit memory at 0x0 [0xff]

I had ordered my mail to include first all output from 2.2.18,
followed by output of 2.4.17.

Christian
