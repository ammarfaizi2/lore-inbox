Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937005AbWLEWxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937005AbWLEWxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937030AbWLEWxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:53:19 -0500
Received: from 249-107.customer.cloud9.net ([168.100.249.107]:43831 "EHLO
	mail.prager.ws" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937005AbWLEWxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:53:18 -0500
Date: Tue, 5 Dec 2006 17:53:17 -0500
From: Bernd Prager <bernd@prager.ws>
To: linux-kernel@vger.kernel.org
Subject: can't boot : Spurious ACK with kernel 2.6.19
Message-ID: <20061205225316.GA2948@mail.prager.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to upgrade to kernel 1.6.19.
The boot process immediatly locks in a loop with the message:
"atkbd.c: Spurious ACK on isa0060/serio0. Some program might be trying access hardware directly."

The box is running fine with kernel 1.6.18.4.

It's an iDEQ200V box with a BioStar motherboar, VIA KM400 + VT8237 chipset.
Here's my BIOS information based on dmidecode:

BIOS Information
        Vendor: Phoenix Technologies, LTD
        Version: 6.00 PG
        Release Date: 08/19/2003
        Address: 0xE0000
        Runtime Size: 128 kB
        ROM Size: 512 kB
        Characteristics:
                ISA is supported
                PCI is supported
                PNP is supported
                APM is supported
                BIOS is upgradeable
                BIOS shadowing is allowed
                ESCD support is available
                Boot from CD is supported
                Selectable boot is supported
                BIOS ROM is socketed
                EDD is supported
                5.25"/360 KB floppy services are supported (int 13h)
                5.25"/1.2 MB floppy services are supported (int 13h)
                3.5"/720 KB floppy services are supported (int 13h)
                3.5"/2.88 MB floppy services are supported (int 13h)
                Print screen service is supported (int 5h)
                8042 keyboard services are supported (int 9h)
                Serial services are supported (int 14h)
                Printer services are supported (int 17h)
                CGA/mono video services are supported (int 10h)
                ACPI is supported
                USB legacy is supported
                AGP is supported
                LS-120 boot is supported
                ATAPI Zip drive boot is supported

( .. more info available if useful ..)

Did anybody discovered similar issues or have any ideas on how to solve that?

Thanks for any help,
-- Bernd


