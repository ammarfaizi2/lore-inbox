Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129718AbQLQXOD>; Sun, 17 Dec 2000 18:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbQLQXNn>; Sun, 17 Dec 2000 18:13:43 -0500
Received: from adsl-pool27-251.chicago.il.ameritech.net ([64.108.13.251]:50049
	"EHLO nanook.ath.cx") by vger.kernel.org with ESMTP
	id <S129718AbQLQXNe>; Sun, 17 Dec 2000 18:13:34 -0500
Date: Sun, 17 Dec 2000 16:48:54 -0600 (CST)
From: Hexxor <hexxor@rains.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.0-test12 and pci
Message-ID: <Pine.LNX.4.30.0012171642320.1612-100000@nanook.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all, I hope I'm posting to the right place for this

I noticed there was a patch to enable the 'pci=autoirq' option, but any
occurance I've found seems to be incomplete or something (it won't apply)
and I'm getting weird irq messages in my logs, searching for the errors
brings up posts from MJ (who wrote the patch, I think)

any help would be appreciated, as I don't know much about what this error
could mean

Dec 16 04:01:55 nanook kernel: Kernel command line: auto BOOT_IMAGE=Linux
ro root=301 BOOT_FILE=/boot/vmlinuz hdc=ide-scsi pci=autoirq
Dec 16 04:01:55 nanook kernel: PCI: Unknown option `autoirq'
Dec 16 04:01:55 nanook kernel: IRQ routing conflict in pirq table! Try 'pci=autoirq'


also, I get this one occasionally:

Dec 14 02:01:24 nanook kernel: spurious 8259A interrupt: IRQ7.

all this started happening after I upgraded to 2.4.0-test12, which was the
same day I put an AMD k6/2 450 cpu in this box, relevant?

TIA

-- 


-Hexxor / Charles D

"Do not take for granted, the powers out there."

GMUd-s:--a--C++UL++++P++++L++++E----W++N+o+K-O-
w---M-V-PS+++PEY+PGPt---5--X-R!tvb+DID+Geh--ry+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
