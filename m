Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbWFTBXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbWFTBXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 21:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWFTBXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 21:23:09 -0400
Received: from mail02.syd.optusnet.com.au ([211.29.132.183]:49090 "EHLO
	mail02.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S965028AbWFTBXI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 21:23:08 -0400
References: <20060620001522.18454.qmail@web52902.mail.yahoo.com>
Message-ID: <cone.1150766585.735266.688.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Chris Rankin <rankincj@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17: PM-Timer bug warning?
Date: Tue, 20 Jun 2006 11:23:05 +1000
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-688-1150766585-0001";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-688-1150766585-0001
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Chris Rankin writes:

> Hi,
> 
> I have found these messages in my dual P4 Xeon boot log:
> 
> Linux version 2.6.17 (chris@volcano.underworld) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #2
> SMP PREEMPT Mon Jun 19 10:38:36 BST 2006
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
>  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003ff75000 (usable)
>  BIOS-e820: 000000003ff75000 - 000000003ff77000 (ACPI NVS)
>  BIOS-e820: 000000003ff77000 - 000000003ff98000 (ACPI data)
>  BIOS-e820: 000000003ff98000 - 0000000040000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 00000000fec90000 (reserved)
>  BIOS-e820: 00000000fee00000 - 00000000fee10000 (reserved)
>  BIOS-e820: 00000000ffb00000 - 0000000100000000 (reserved)
> 127MB HIGHMEM available.
> 896MB LOWMEM available.
> found SMP MP-table at 000fe710
> On node 0 totalpages: 262005
>   DMA zone: 4096 pages, LIFO batch:0
>   Normal zone: 225280 pages, LIFO batch:31
>   HighMem zone: 32629 pages, LIFO batch:7
> DMI 2.3 present.
> ACPI: RSDP (v000 DELL                                  ) @ 0x000febc0
> ACPI: RSDT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd4d9
> ACPI: FADT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd511
> ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffefa6f
> ACPI: MADT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd585
> ACPI: BOOT (v001 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd609
> ACPI: ASF! (v016 DELL    WS 650  0x00000008 ASL  0x00000061) @ 0x000fd631
> ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
> ACPI: PM-Timer IO Port: 0x808
> 
> ...
> 
> Simple Boot Flag value 0x87 read from CMOS RAM was invalid
> Simple Boot Flag at 0x7a set to 0x1
> Machine check exception polling timer started.
> * This chipset may have PM-Timer Bug.  Due to workarounds for a bug,
> * this time source is slow. If you are sure your timer does not have
> * this bug, please use "pmtmr_good" to disable the workaround
> 
> It looks like my chipset is in the kernel's "gray-list" for having a hardware timer bug. So seeing
> as I *do* have the relevant hardware, what would I need do to determine whether this chipset
> actually does have the bug or not, please?
> 
> 00:00.0 Host bridge: Intel Corporation E7505 Memory Controller Hub (rev 03)
> 00:01.0 PCI bridge: Intel Corporation E7505/E7205 PCI-to-AGP Bridge (rev 03)
> 00:02.0 PCI bridge: Intel Corporation E7505 Hub Interface B PCI-to-PCI Bridge (rev 03)
> 00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller
> #1 (rev 01)
> 00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller
> #2 (rev 01)
> 00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller
> #3 (rev 01)
> 00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 01)
> 00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 81)
> 00:1f.0 ISA bridge: Intel Corporation 82801DB/DBL (ICH4/ICH4-L) LPC Interface Bridge (rev 01)
> 00:1f.1 IDE interface: Intel Corporation 82801DB (ICH4) IDE Controller (rev 01)
> 00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
> 00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97
> Audio Controller (rev 01)

We don't have such a list that tells us which hardware is prone otherwise we 
could have put the workaround for broken chipsets only. As your hardware is 
SMP then you'll have a good working TSC timer so I recommend simply removing 
the PM Timer option from your kernel configuration, or specify a different 
clocksource (TSC) in your bootparameters. I can't recall the syntax for it 
offhand.

--
-ck



--=_mimegpg-kolivas.org-688-1150766585-0001
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBEl035ZUg7+tp6mRURArs6AJ0V4krIoeIdv1xxkTGsUzHUgcbn+QCcCgft
NvTybx9RIPSuyKPWj3ojhU8=
=szqK
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-688-1150766585-0001--
