Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130649AbQLISsG>; Sat, 9 Dec 2000 13:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130530AbQLISr4>; Sat, 9 Dec 2000 13:47:56 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:14539 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S130085AbQLISrn>; Sat, 9 Dec 2000 13:47:43 -0500
Date: Sat, 9 Dec 2000 17:36:42 +0000 (GMT)
From: davej@suse.de
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PIRQ routing problem in test12-pre7.
Message-ID: <Pine.LNX.4.21.0012091721530.491-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PCI: PCI BIOS revision 2.10 entry at 0xfb240, last bus=1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0586] at 00:07.0
..
PCI: Assigned IRQ 11 for device 00:08.0
PCI: The same IRQ used for device 01:00.0
IRQ routing conflict in pirq table! Try 'pci=autoirq'

00:08.1 Input device controller: Creative Labs SB Live! (rev 01)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev01)

Works fine with test12-pre5

btw, the option pci=autoirq doesn't seem to exist.

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
