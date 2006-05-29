Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWE2EmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWE2EmP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 00:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWE2EmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 00:42:14 -0400
Received: from fw.bitband.com ([213.8.50.174]:42122 "EHLO mail1.bitband.com")
	by vger.kernel.org with ESMTP id S1751170AbWE2EmO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 00:42:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Pci-X nic irq problem with acpi 2.6.15
Date: Mon, 29 May 2006 07:42:08 +0300
Message-ID: <83CA05F64804AF43B8F733C4ABDFAA510136506B@mail1.bitband.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Pci-X nic irq problem with acpi 2.6.15
Thread-Index: AcaC2HKPs1GP+9ahRoCatPUxmpqm0wAAb0Mg
From: "Sion Khalaf" <Sion@bitband.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

Kernel 2.6.15 issue:
	I am trying to install 2 x quad NICs,with Intel chipset 
	into PCI-X slots on Super Micro board H8DC8, With NVIDIA
chipset.
	When booting, there is no probing on the kernel for those cards,
and there are no interfaces.
	When using grub with the option acpi=off, it works.

Kernel 2.6.11.6 - same server, works fine, and I can load the e1000
drivers for the cards.

Both kernel have very similar .config, and both enabled acpi.

cat /proc/interrupts shows irq 9 is sharing acpi and the e1000 drives

Can anyone tell me what is wrong?

Thank you,
Sion
