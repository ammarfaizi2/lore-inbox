Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266841AbUAXAzi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 19:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266845AbUAXAzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 19:55:38 -0500
Received: from hell.org.pl ([212.244.218.42]:6410 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S266841AbUAXAz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 19:55:27 -0500
Date: Sat, 24 Jan 2004 01:55:34 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-mm2] PM timer still has problems
Message-ID: <20040124005534.GB30881@hell.org.pl>
References: <20031230204831.GA17344@hell.org.pl> <1073340716.15645.96.camel@cog.beaverton.ibm.com> <200401052332.24739.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <200401052332.24739.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dmitry Torokhov:
[...]
Another follow-up, this time the BogoMIPS value is completely
bogus.

#v+
Linux version 2.6.2-rc1-mm2 (sziwan@nadir) (gcc version 3.3.2) #11 Fri Jan 23 22:45:18 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff9000 (usable)
 BIOS-e820: 000000000fff9000 - 000000000ffff000 (ACPI data)
 BIOS-e820: 000000000ffff000 - 0000000010000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
zapping low mappings.
On node 0 totalpages: 65529
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61433 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ASUS L3C with broken BIOS detected. Refusing to enable the local APIC.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6890
ACPI: RSDT (v001 ASUS   P4_L3CS  0x42302e31 MSFT 0x31313031) @ 0x0fff9000
ACPI: FADT (v001 ASUS   P4_L3CS  0x42302e31 MSFT 0x31313031) @ 0x0fff9080
ACPI: BOOT (v001 ASUS   P4_L3CS  0x42302e31 MSFT 0x31313031) @ 0x0fff9040
ACPI: DSDT (v001   ASUS P4_L3CS  0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
Built 1 zonelists
current: c031ea60
current->thread_info: c0386000
Initializing CPU#0
Kernel command line: BOOT_IMAGE=2.6 ro root=305 resume=/dev/hda1 acpi_sleep=s3_bios clock=pmtmr
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1700.567 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Memory: 255896k/262116k available (1878k kernel code, 5512k reserved, 704k data, 132k init, 0k highmem)
Calibrating delay loop... 8.19 BogoMIPS
#v-

FYI, it was around 1700 BogoMIPS with 2.6.1-mm4 (using pmtmr).
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
