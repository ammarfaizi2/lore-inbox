Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTHZNMn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 09:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTHZNMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 09:12:43 -0400
Received: from ms-smtp-04.tampabay.rr.com ([65.32.1.35]:7302 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S263761AbTHZNMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 09:12:42 -0400
Subject: re: [ACPI] 2.4.22, My bios is to old?
From: "Tony A. Lambley" <tal@vextech.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061903560.686.6.camel@lappy2.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 26 Aug 2003 09:12:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same problem on a sager 5600D that's only 8 months old. It
didn't happen with 2.4.22-rc2, I missed -rc3, but it happens in -rc4. I
also get it in 2.6.0-test4. Was something back-ported?

Here's my grepped dmesg:

$ dmesg |grep ACPI
 BIOS-e820: 000000003fef0000 - 000000003fefb000 (ACPI data)
 BIOS-e820: 000000003fefb000 - 000000003ff00000 (ACPI NVS)
ACPI: have wakeup address 0xc0001000
ACPI disabled because your bios is from 92 and too old
ACPI: RSDP (v000 PTLTD                                     ) @
0x000f6360
ACPI: RSDT (v001 PTLTD  Sheeks   0x06040000  LTP 0x00000000) @
0x3fef6ae7
ACPI: FADT (v001 Clevo  845MP    0x06040000 PTL  0x00000050) @
0x3fefaf2d
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @
0x3fefafa1
ACPI: DSDT (v001 INTEL  845M     0x06040000 MSFT 0x0100000d) @
0x00000000
ACPI: MADT not present
ACPI: Subsystem revision 20030813
ACPI: Interpreter disabled.
PCI: ACPI tables contain no PCI IRQ routing entries
