Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270375AbTG1RzT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 13:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270379AbTG1RzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 13:55:19 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:60108 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S270375AbTG1RzO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 13:55:14 -0400
Date: Mon, 28 Jul 2003 14:09:40 -0400 (EDT)
From: Richard A Nelson <cowboy@vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: ACPI failure (2.6.0-test<x> and 2.4.22-pre<x>)
Message-ID: <Pine.LNX.4.56.0307281358170.5314@onqynaqf.yrkvatgba.voz.pbz>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


IBM T30 Laptop:
IBM machine detected. Enabling interrupts during APM calls.
IBM machine detected. Disabling SMBus accesses.  <- 2.6 only
No local APIC present or hardware disabled       <- 2.4 only
Local APIC disabled by BIOS -- reenabling.       <- 2.6 only
Found and enabled local APIC!                    <- 2.6 only
ACPI:             have wakeup address 0xc0001000

model name      : Intel(R) Pentium(R) 4 Mobile CPU 1.80GHz
Bios Version:     1IET66WW (2.05 )               <- most recent available
BIOS32 Service Directory present.
ACPI 2.0 present.
        OEM ID: IBM
RSD table at 0x0FF63195.
PNP 1.0 present.
        Event Notification: Polling
        Event Notification Flag Address: 0x000004B4
        Real Mode Code Address: F000:9D36
        Real Mode Data Address: 0040:0000
        Protected Mode Code Address: 0x000F9D54
        Protected Mode Data Address: 0x00000400
PCI Interrupt Routing 1.0 present.
        Table Size: 256 bytes
        Router ID: 00:1f.0
        Exclusive IRQs: None
        Compatible Router: 8086:122e

On either 2.6, or 2.4, booting with ACPI enabled gets as far as
parsing the ACPI EC table - at which point it oops with bad pointer
and halts the system.  Sorry at this point I don't have the register
contents; it took a while to narrow it this far - and have the
screen in such a state that I can see any relevant information other
than the the trying to kill init message :)

-- 
Rick Nelson
I can saw a woman in two, but you won't want to look in the box when I do
'For My Next Trick I'll Need a Volunteer' -- Warren Zevon
