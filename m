Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTEMMlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 08:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbTEMMlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 08:41:42 -0400
Received: from main.gmane.org ([80.91.224.249]:14812 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261161AbTEMMlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 08:41:40 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andreas Happe <andreashappe@gmx.net>
Subject: [ACPI-1121] Method execution failed
Date: Tue, 13 May 2003 14:50:41 +0200
Message-ID: <slrnbc1qh1.11d.andreashappe@flatline.ath.cx>
X-Complaints-To: usenet@main.gmane.org
User-Agent: slrn/0.9.7.4 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel version: 2.5.69-bk7,
hardware: hp omnibook 6100, i830m

the kernel boots (which is a huge improvement compared to older
releases, thanks), but i get the attached error.

After the system is booted there's a interessting situation, some parts
of acpi seem to be loaded (i have /proc/thermal_zone et al (shoudn't it
be /proc/acpi/* ?)), but they don't work.

The interessting bootup lines (apic is disabled):

| ACPI: RSDP (v000 PTLTD                      ) @ 0x000f6610
| ACPI: RSDT (v001 PTLTD  EBRSDT   00576.00000) @ 0x0ff682e4
| ACPI: FADT (v001 QUANTA EBmador  00576.00000) @ 0x0ff73b64
| ACPI: BOOT (v001 PTLTD  EBBFTBL$ 00576.00000) @ 0x0ff73bd8
| ACPI: DSDT (v001 HP-MCD EB DSDT  00576.00000) @ 0x00000000
| ACPI: BIOS passes blacklist
...
| ACPI: Subsystem revision 20030418
| ACPI-1121: *** Error: Method execution failed [\_SB_.PCI0.HUB_.FDS_.
|               FCB1.CSID] (Node c12c55c0), AE_NOT_EXIST
| ACPI-1121: *** Error: Method execution failed
|	       [\_SB_.PCI0.HUB_.FDS_._REG] (Node c12c5940), AE_NOT_EXIST
| ACPI: Unable to start the ACPI Interpreter
...
| ACPI: ACPI tables contain no PCI IRQ routing entries

thx,
andreas

