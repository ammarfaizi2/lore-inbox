Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131239AbRAXOHN>; Wed, 24 Jan 2001 09:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132025AbRAXOG7>; Wed, 24 Jan 2001 09:06:59 -0500
Received: from w240.z209220232.was-dc.dsl.cnc.net ([209.220.232.240]:4101 "EHLO
	yendi.dmeyer.net") by vger.kernel.org with ESMTP id <S131239AbRAXOGu>;
	Wed, 24 Jan 2001 09:06:50 -0500
Date: Wed, 24 Jan 2001 09:06:45 -0500
From: dmeyer@dmeyer.net
To: linux-kernel@vger.kernel.org
Subject: ACPI trouble with MS-6167 motherboard
Message-ID: <20010124090645.A20129@jhereg.dmeyer.net>
Reply-To: dmeyer@dmeyer.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: dmeyer.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still having ACPI difficulties with Linux-2.4.1-pre10 on my
system.  Up to (and including) Linux-2.4.0, it worked fine; the kernel
reported:

Jan 14 22:53:05 jhereg kernel: ACPI: System description tables found
Jan 14 22:53:05 jhereg kernel: ACPI: System description tables loaded
Jan 14 22:53:05 jhereg kernel: ACPI: Subsystem enabled
Jan 14 22:53:05 jhereg kernel: ACPI: System firmware supports: C2
Jan 14 22:53:05 jhereg kernel: ACPI: System firmware supports: S0 S1

However, since Linux-2.4.1-pre8, I get:

ACPI: System description tables found
    ACPI-0191: *** Warning: Invalid table signature found
    ACPI-0073: *** Error: Acpi_load_tables: Could not load RSDT: AE_BAD_SIGNATURE
    ACPI-0101: *** Error: Acpi_load_tables: Could not load tables: AE_BAD_SIGNATURE
ACPI: System description table load failed



Excerpts from my boot log follow:

BIOS Vendor: Award Software International, Inc.
BIOS Version: 6.0 PG
BIOS Release: 08/30/00
Board Vendor: MICRO-STAR INTERNATIONAL CO., LTD.
Board Name: MS-6167 (AMD751).
Board Version: 1.X.

BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 000000000fef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)

I'd appreciate it if anyone can tell me what the deal is.

-- 
David M. Meyer
dmeyer@dmeyer.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
