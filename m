Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQKHWtI>; Wed, 8 Nov 2000 17:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129211AbQKHWs5>; Wed, 8 Nov 2000 17:48:57 -0500
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:60133 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S129419AbQKHWsu>; Wed, 8 Nov 2000 17:48:50 -0500
Message-ID: <FEEBE78C8360D411ACFD00D0B74779718808E4@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: accessing on-card ram/rom
Date: Wed, 8 Nov 2000 17:48:47 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have a PCI card which has on-card ram/rom which gets mapped
into pci address space and there is a separate base register
for this memory. Now the question is : can I access this on-card
memory by converting the pci base address into the virtual address
using bus_to_virt and adding the required offset ? Or do I need
to use ioremap function to map the physical address space starting
from the pci base address into the kernel virtual address space ?
Or is there any other interface to access the on-card memory ?
Is it that bus_to_virt can be used only for the normal RAM ?

I tried using bus_to_virt to get the virtual address and then access
it and the kernel panics.

Please copy me on your replies as I am not on the list.

Thanks and regards,
-hiren
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
