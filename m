Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132959AbRAXWB0>; Wed, 24 Jan 2001 17:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132958AbRAXWBR>; Wed, 24 Jan 2001 17:01:17 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:56071 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S132959AbRAXWBB>; Wed, 24 Jan 2001 17:01:01 -0500
Message-ID: <4148FEAAD879D311AC5700A0C969E8905DE5D4@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: acpi@phobos.fachschaften.tu-muenchen.de,
        "'dmeyer@dmeyer.net'" <dmeyer@dmeyer.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: ACPI trouble with MS-6167 motherboard (fwd)
Date: Wed, 24 Jan 2001 13:54:48 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is pretty weird, since the latest ACPI update went in pre10, and it was
pretty minor. That you are saying problems started in pre8 implies this is
not a problem with the ACPI driver, but something else.. hmm..

So it worked in pre7 and broke in pre8?

Regards -- Andy

> Date: Wed, 24 Jan 2001 09:06:45 -0500
> From: dmeyer@dmeyer.net
> Subject: ACPI trouble with MS-6167 motherboard
> 
> I'm still having ACPI difficulties with Linux-2.4.1-pre10 on my
> system.  Up to (and including) Linux-2.4.0, it worked fine; the kernel
> reported:
> 
> Jan 14 22:53:05 jhereg kernel: ACPI: System description tables found
> Jan 14 22:53:05 jhereg kernel: ACPI: System description tables loaded
> Jan 14 22:53:05 jhereg kernel: ACPI: Subsystem enabled
> Jan 14 22:53:05 jhereg kernel: ACPI: System firmware supports: C2
> Jan 14 22:53:05 jhereg kernel: ACPI: System firmware supports: S0 S1
> 
> However, since Linux-2.4.1-pre8, I get:
> 
> ACPI: System description tables found
>     ACPI-0191: *** Warning: Invalid table signature found
>     ACPI-0073: *** Error: Acpi_load_tables: Could not load 
> RSDT: AE_BAD_SIGNATURE
>     ACPI-0101: *** Error: Acpi_load_tables: Could not load 
> tables: AE_BAD_SIGNATURE
> ACPI: System description table load failed
> 
> 
> 
> Excerpts from my boot log follow:
> 
> BIOS Vendor: Award Software International, Inc.
> BIOS Version: 6.0 PG
> BIOS Release: 08/30/00
> Board Vendor: MICRO-STAR INTERNATIONAL CO., LTD.
> Board Name: MS-6167 (AMD751).
> Board Version: 1.X.
> 
> BIOS-provided physical RAM map:
>  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
>  BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
>  BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
>  BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
>  BIOS-e820: 000000000fef0000 @ 0000000000100000 (usable)
>  BIOS-e820: 000000000000d000 @ 000000000fff3000 (ACPI data)
>  BIOS-e820: 0000000000003000 @ 000000000fff0000 (ACPI NVS)
> 
> I'd appreciate it if anyone can tell me what the deal is.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
