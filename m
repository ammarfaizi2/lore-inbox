Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbUCTSsm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 13:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263507AbUCTSsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 13:48:42 -0500
Received: from painless.aaisp.net.uk ([217.169.20.17]:65005 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S263504AbUCTSsj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 13:48:39 -0500
Subject: ACPI error with 2.4.26-pre5
From: Andrew Clayton <andrew@digital-domain.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1079808518.1120.25.camel@alpha.digital-domain.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 20 Mar 2004 18:48:38 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

With 2.4.26-pre5 I am seeing the following error at boot up.


ACPI: Subsystem revision 20040311
PCI: PCI BIOS revision 2.10 entry at 0xe8964, last bus=1
PCI: Using configuration type 1
    ACPI-0433: *** Warning: Existing references (4) on node being
deleted (c129e
660)
    ACPI-0433: *** Warning: Existing references (9) on node being
deleted (c12ae
da0)
ACPI: IRQ9 SCI: Edge set to Level Trigger.
    ACPI-0097: *** Error: Unable to initialize general purpose events,
AE_NOT_FO
UND
ACPI: Unable to start the ACPI Interpreter
    ACPI-0433: *** Warning: Existing references (65419) on node being
deleted (c
129e4e0)
PCI: Probing PCI hardware
PCI: ACPI tables contain no PCI IRQ routing entries
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router VIA [1106/3074] at 00:11.0



2.4.26-pre4 works fine. This is on a Fujitsu-Siemens C-1020 laptop
running Fedora Core 1


To keep the size of this email down I have provided links to relevant
bits of information.

2.4.26-pre5 .config
http://digital-domain.net/kernel/config

2.4.26-pre5 kernel boot messages
http://digital-domain.net/kernel/2.4.26-pre5.dmesg

2.4.26.-pre4 kernel boot messages (for comparison)
http://digital-domain.net/kernel/2.4.26-pre4.dmesg

Output of lspci -vv
http://digital-domain.net/kernel/lspci-vv


If you would like any extra info please CC me...


Cheers,

Andrew Clayton


