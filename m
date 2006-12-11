Return-Path: <linux-kernel-owner+w=401wt.eu-S937689AbWLKWca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937689AbWLKWca (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 17:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937690AbWLKWca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 17:32:30 -0500
Received: from buick.jordet.net ([193.91.240.190]:43020 "EHLO buick.jordet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937689AbWLKWc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 17:32:29 -0500
Subject: Teles PCI not initializing with HiSax
From: Stian Jordet <liste@jordet.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 11 Dec 2006 23:32:26 +0100
Message-Id: <1165876346.3988.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

since at least 2.6.18, my ISDN card has given me this error in dmesg:

ISDN subsystem Rev: 1.1.2.3/1.1.2.3/1.1.2.2/1.1.2.3/none/1.1.2.2
PPP BSD Compression module registered
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (kernel)
HiSax: Layer1 Revision 2.46.2.5
HiSax: Layer2 Revision 2.30.2.4
HiSax: TeiMgr Revision 2.20.2.3
HiSax: Layer3 Revision 2.22.2.3
HiSax: LinkLayer Revision 2.59.2.4
HiSax: Total 1 card defined
HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
HiSax: Teles/PCI driver Rev. 2.23.2.3
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 19
Found: Zoran, base-address: 0xdb800000, irq: 0x13
HiSax: Teles PCI config irq:19 mem:e084e000
TelesPCI: ISAC version (0): 2086/2186 V1.1
TelesPCI: HSCX version A: V2.1  B: V2.1
Teles PCI: IRQ 19 count 0
Teles PCI: IRQ 19 count 0
Teles PCI: IRQ(19) getting no interrupts during init 1
Teles PCI: IRQ 19 count 0
Teles PCI: IRQ(19) getting no interrupts during init 2
Teles PCI: IRQ 19 count 0
Teles PCI: IRQ(19) getting no interrupts during init 3
HiSax: Card Teles PCI not installed !

I also get this error when I boot with "acpi=off noapic", so I'm pretty
sure it's a hisax bug, not an acpi/irq error.

Anyone have an idea what's the problem here?

Please cc me, as I'm not subscribed.

Thanks.

Best regards,
Stian

