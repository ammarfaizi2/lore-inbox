Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131466AbRCNRZ5>; Wed, 14 Mar 2001 12:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131473AbRCNRZh>; Wed, 14 Mar 2001 12:25:37 -0500
Received: from scl-ims.phoenix.com ([134.122.1.73]:53260 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP
	id <S131466AbRCNRZb>; Wed, 14 Mar 2001 12:25:31 -0500
Message-ID: <D973CF70008ED411B273009027893BA40972A9@irv-exch.phoenix.com>
From: David Christensen <David_Christensen@Phoenix.com>
To: "'Stephen Torri'" <s.torri@lancaster.ac.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: ACPI:system description tables not found.
Date: Wed, 14 Mar 2001 09:24:39 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

Your BIOS isn't reporting any ACPI capability.  If it were you would have at
least two more entries in the e820 output that say ACPI NVS and ACPI
Reclaim.  Have you been able to install a MS OS and have it recognize ACPI?
Are there any other BIOS settings that might be related (what about a PnP OS
setting or something under Power Management)?  You might also check for any
BIOS updates available from the motherboard manufacturer.

Dave

-----Original Message-----
From: Stephen Torri [mailto:s.torri@lancaster.ac.uk]
Sent: Friday, March 09, 2001 1:09 PM
To: David Christensen
Cc: Linux Kernel
Subject: RE: ACPI:system description tables not found.


On Thu, 8 Mar 2001, David Christensen wrote:

> Stephen,
>
> Is there a BIOS setup option for enabling ACPI?  Make sure it is enabled.

The BIOS setup option for ACPI is enabled.

> Also attach a copy of the E820 output from dmesg.

Linux version 2.4.2 (root@base.torri.linux) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #2 SMP Mon Feb 26 23:47:16 GMT 2001

BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved)
 BIOS-e820: 0000000017f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000001000 @ 00000000fec00000 (reserved)
 BIOS-e820: 0000000000001000 @ 00000000fee00000 (reserved)
 BIOS-e820: 0000000000040000 @ 00000000fffc0000 (reserved)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
found SMP MP-table at 000fb4f0
hm, page 000fb000 reserved twice.
hm, page 000fc000 reserved twice.
hm, page 000f2000 reserved twice.
hm, page 000f3000 reserved twice.
On node 0 totalpages: 98304
zone(0): 4096 pages.
zone(1): 94208 pages.
zone(2): 0 pages.

Stephen
-----------------------------------------------
Buyer's Guide for a Operating System:
Don't care to know: Mac
Don't mind knowing but not too much: Windows
Hit me! I can take it!: Linux

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
