Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVACAO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVACAO5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 19:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVACAO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 19:14:57 -0500
Received: from pop.gmx.de ([213.165.64.20]:28810 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261349AbVACAOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 19:14:54 -0500
X-Authenticated: #438326
From: Michael Geithe <warpy@gmx.de>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: 2.6.10-bk5
Date: Mon, 3 Jan 2005 01:14:55 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501030114.55399.warpy@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
when booting 2.6.10-bk5, my box generate the following:


 BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d4000 - 00000000000de014 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fc0f0
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
__iounmap: bad address c00f0000
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa380
ACPI: RSDT (v001 AMIINT INTEL875 0x00000010 MSFT 0x00000097) @ 0x3fff0000
ACPI: FADT (v001 AMIINT INTEL875 0x00000011 MSFT 0x00000097) @ 0x3fff0030
ACPI: MADT (v001 AMIINT INTEL875 0x00000009 MSFT 0x00000097) @ 0x3fff00c0
ACPI: DSDT (v001  INTEL     I875 0x00001000 MSFT 0x0100000d) @ 0x00000000

These warnings/errors are new since 2.6.10-bk2
__iounmap: bad address c00f0000


Mainboard MSI 875P NEO-LSR
Linux 2.6.10-bk5 #1 SMP Sun Jan 2 15:29:57 CET 2005 i686 Intel(R) Pentium(R) 4 
CPU 2.80GHz GenuineIntel GNU/Linux

-- 
Michael Geithe









