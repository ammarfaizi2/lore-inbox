Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266260AbUBQQX7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUBQQX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:23:59 -0500
Received: from mail2.allneo.com ([216.185.99.212]:63453 "EHLO mail1.allneo.com")
	by vger.kernel.org with ESMTP id S266260AbUBQQXz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:23:55 -0500
From: "Brad Cramer" <bcramer@callahanfuneralhome.com>
To: "'Guennadi Liakhovetski'" <g.liakhovetski@gmx.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x
Date: Tue, 17 Feb 2004 11:23:41 -0500
Message-ID: <008401c3f572$6b72d330$6501a8c0@office>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <Pine.LNX.4.44.0402132334460.4537-100000@poirot.grange>
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here it is

Linux version 2.6.2 (root@bigdaddy) (gcc version 3.3.3 20040125 (prerelease)
(Debian)) #1 Thu Feb 12 08:33:42 EST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000004fff0000 (usable)
 BIOS-e820: 000000004fff0000 - 000000004fff3000 (ACPI NVS)
 BIOS-e820: 000000004fff3000 - 0000000050000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 327664
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 98288 pages, LIFO batch:16
DMI 2.2 present.
ACPI: RSDP (v000 761686                                    ) @ 0x000f6a70
ACPI: RSDT (v001 761686 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x4fff3000
ACPI: FADT (v001 761686 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x4fff3040
ACPI: DSDT (v001 761686 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux ro root=1601
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1402.432 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 1293316k/1310656k available (1941k kernel code, 16200k reserved,
831k data, 164k init, 393152k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2760.70 BogoMIPS
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1c7fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0183fbff c1c7fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) processor stepping 04
 
1,1           Top

-----Original Message-----
From: Guennadi Liakhovetski [mailto:g.liakhovetski@gmx.de] 
Sent: Friday, February 13, 2004 5:40 PM
To: Brad Cramer
Cc: linux-kernel@vger.kernel.org
Subject: Re: sym53c8xx_2 driver and tekram dc-390u2w kernel-2.6.x

On Fri, 13 Feb 2004, Brad Cramer wrote:

>  I can not get my scsi hd to work with my tekram dc-390u2w controller and
> the sym53c8xx_2 driver under kernel-2.6.2. Everything works great using
> kernel-2.4.28 and sym53c8xx driver so I know this is not a hardware issue
> with the disk. I have built the sym53c8xx_2 driver into the kernel and
have

Can you send your dmesg output when attempting to boot a 2.6.x kernel? You
might want to move (or, at least, CC) this discussion to the linux-scsi
(linux-scsi@vger.kernel.org) list.

Guennadi
---
Guennadi Liakhovetski




