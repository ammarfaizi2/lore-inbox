Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262428AbVAEO5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbVAEO5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 09:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbVAEO5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 09:57:42 -0500
Received: from math.ut.ee ([193.40.5.125]:26283 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262428AbVAEO53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 09:57:29 -0500
Date: Wed, 5 Jan 2005 16:57:26 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: __iounmap: bad address c00f0000
Message-ID: <Pine.SOC.4.61.0501051655140.8230@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is todays BK snapshot on an x86 (Celeron 900, i815 chipset, 512M 
RAM). Seems to work fine but emits the message about bad iounmap address 
on bootup:

Linux version 2.6.10-mr1 (mroos@rhn) (gcc version 3.3.5 (Debian 1:3.3.5-5)) #229 Wed Jan 5 15:37:16 EET 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001ffc0000 (usable)
  BIOS-e820: 000000001ffc0000 - 000000001fff8000 (ACPI data)
  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
  BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
  BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131008
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 126912 pages, LIFO batch:16
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
__iounmap: bad address c00f0000
ACPI: RSDP (v000 AMI                                   ) @ 0x000ff980
ACPI: RSDT (v001 D815EA D815EEA2 0x20021106 MSFT 0x00001011) @ 0x1fff0000
ACPI: FADT (v001 D815EA EA81510A 0x20021106 MSFT 0x00001011) @ 0x1fff1000
ACPI: DSDT (v001 D815E2 EA81520A 0x00000023 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
...

-- 
Meelis Roos (mroos@linux.ee)
