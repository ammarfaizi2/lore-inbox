Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131400AbRCUNal>; Wed, 21 Mar 2001 08:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131402AbRCUNab>; Wed, 21 Mar 2001 08:30:31 -0500
Received: from c3po.klbg.n.redcross.or.at ([195.202.144.145]:23812 "EHLO
	c3po.klbg.n.redcross.or.at") by vger.kernel.org with ESMTP
	id <S131400AbRCUNaP>; Wed, 21 Mar 2001 08:30:15 -0500
Date: Wed, 21 Mar 2001 14:29:32 +0100 (CET)
From: Markus Gaugusch <markus@gaugusch.dhs.org>
X-X-Sender: <markus@phoenix.kerstin.at>
To: <linux-kernel@vger.kernel.org>
Subject: No power down with MVP3 chipset (VIA 82c586B)
Message-ID: <Pine.LNX.4.33.0103211423440.1149-100000@phoenix.kerstin.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[First posting, please don't eat me :-)]

I'm using kernel 2.4.2 and have never been able to shutdown my machine by
software. Neither 2.2.x nor 2.4.x, with and without Real Mode power off.
Bios is broken, no acpi tables can be found:
    ACPI-0191: *** Warning: Invalid table signature found
    ACPI-0073: *** Error: Acpi_load_tables: Could not load RSDT: AE_BAD_SIGNATURE
    ACPI-0101: *** Error: Acpi_load_tables: Could not load tables: AE_BAD_SIGNAT
ACPI: System description table load failed

I tried with ACPI only, APM only and using both.
Real Mode power down reboots the machine and "normal" power down just
crashes (register dump ...).
I read about patches, which fake ACPI tables, and some others which power
down in real mode in a different way(?), but couldn't apply them because
of different kernel versions.

Thank you for any information

Markus Gaugusch

-- 
_____________________________     /"\
Markus Gaugusch  ICQ 11374583     \ /    ASCII Ribbon Campaign
markus@gaugusch.dhs.org            X     Against HTML Mail
                                  / \

