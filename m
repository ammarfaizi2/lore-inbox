Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262734AbVAFF3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVAFF3y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 00:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbVAFF3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 00:29:53 -0500
Received: from dialup-4.246.108.239.Dial1.SanJose1.Level3.net ([4.246.108.239]:3969
	"EHLO nofear.bounceme.net") by vger.kernel.org with ESMTP
	id S262734AbVAFF2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 00:28:47 -0500
Message-ID: <41DCCCF6.1030505@syphir.sytes.net>
Date: Wed, 05 Jan 2005 21:30:30 -0800
From: "C.Y.M" <syphir@syphir.sytes.net>
Reply-To: syphir@syphir.sytes.net
Organization: CooLNeT
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ACPI-1138 Error starting with 2.6.10-bk3
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been getting the following ACPI errors since 2.6.10-bk3.  Is there some new configuration I 
need to enable?

Jan  5 09:00:14 nofear kernel: Linux version 2.6.10-bk8.010505.1 (root@nofear) (gcc version 3.3.5 
(Debian 1:3.3.5-5)) #1 Wed Jan 5 08:50:21 PST 2005
Jan  5 09:00:14 nofear kernel: BIOS-provided physical RAM map:
Jan  5 09:00:14 nofear kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jan  5 09:00:14 nofear kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jan  5 09:00:14 nofear kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jan  5 09:00:14 nofear kernel:  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
Jan  5 09:00:14 nofear kernel:  BIOS-e820: 000000001fff0000 - 000000001fff3000 (ACPI NVS)
Jan  5 09:00:14 nofear kernel:  BIOS-e820: 000000001fff3000 - 0000000020000000 (ACPI data)
Jan  5 09:00:14 nofear kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Jan  5 09:00:14 nofear kernel: 511MB LOWMEM available.
Jan  5 09:00:14 nofear kernel: On node 0 totalpages: 131056
Jan  5 09:00:14 nofear kernel:   DMA zone: 4096 pages, LIFO batch:1
Jan  5 09:00:14 nofear kernel:   Normal zone: 126960 pages, LIFO batch:16
Jan  5 09:00:14 nofear kernel:   HighMem zone: 0 pages, LIFO batch:1
Jan  5 09:00:14 nofear kernel: DMI 2.2 present.
Jan  5 09:00:14 nofear kernel: __iounmap: bad address c00f0000
Jan  5 09:00:14 nofear kernel: ACPI: RSDP (v000 VIA694                                ) @ 0x000f64a0
Jan  5 09:00:14 nofear kernel: ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3000
Jan  5 09:00:14 nofear kernel: ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1fff3040
Jan  5 09:00:14 nofear kernel: ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Jan  5 09:00:14 nofear kernel: ACPI: PM-Timer IO Port: 0x4008
Jan  5 09:00:14 nofear kernel:     ACPI-1138: *** Error: Method execution failed [\STRC] (Node 
c14d8e20), AE_AML_BUFFER_LIMIT
Jan  5 09:00:14 nofear kernel:     ACPI-1138: *** Error: Method execution failed [\_SB_.PCI0._INI] 
(Node c14d7b40), AE_AML_BUFFER_LIMIT
