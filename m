Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275178AbRJPJEG>; Tue, 16 Oct 2001 05:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275485AbRJPJD4>; Tue, 16 Oct 2001 05:03:56 -0400
Received: from haneman.dialup.fu-berlin.de ([160.45.224.9]:2176 "EHLO
	haneman.dialup.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S275178AbRJPJDu>; Tue, 16 Oct 2001 05:03:50 -0400
Date: Tue, 16 Oct 2001 12:03:01 +0200 (MESZ)
From: Enver Haase <ehaase@inf.fu-berlin.de>
To: Philip.Blundell@pobox.com, tim@cyberelk.demon.co.uk, renau@acm.org,
        campbell@torque.net, linux-kernel@vger.kernel.org
Subject: Parport PCI card doesn't share IRQ
Message-ID: <Pine.LNX.4.10.10110161156410.1239-100000@haneman.hacenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi parport hackers,

I have a

Communication controller: PCI device 9710:9815 (rev 1).

here, and it runs fine as long as you don't try to share its IRQ. Maybe
related: "cat /proc/interrupts" does not show the card is on IRQ 11 --- so
when I put my NE2000 clone network card _also_ on IRQ 11, the system hangs
as soon as the card is used, i.e. ifconfig'ed.

Is there something I (or you) can do about it?


Regards+greetings,
Enver

PS: I have to share the IRQ between USB and NE2000 now, this works fine.
However, I sometimes use Win98 to burn CDs. It doesn't start with this
setup so I have to BIOS-SETUP the Comm.Card to share IRQ with the NE2000
for this other OS.... brrrr!

