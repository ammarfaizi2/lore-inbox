Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129063AbQJ3PyT>; Mon, 30 Oct 2000 10:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129089AbQJ3PyJ>; Mon, 30 Oct 2000 10:54:09 -0500
Received: from varis.cs.tut.fi ([130.230.4.42]:5839 "EHLO cs.tut.fi")
	by vger.kernel.org with ESMTP id <S129063AbQJ3Px5>;
	Mon, 30 Oct 2000 10:53:57 -0500
Date: Mon, 30 Oct 2000 17:53:55 +0200 (EET)
From: J{rvensivu Riku <galaxy@cs.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: Support for Compaq's NC3134 & NC3135 via the eepro100.o (82559 chip)
 ?
Message-ID: <Pine.GSO.4.21.0010301718110.6057-100000@korppi.cs.tut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Compaq has a dual-port ethernet adapter which is based on the Intel 82559
(the chip used in the Intel Etherexpress Pro/100) as well as an addition
module to this adapter with two extra ports usign the same chip. Any ideas
what does the current kernel module say about this card (w/ and w/o the
extra ports)? Has anyone came across this card and is there any plans to
support it (assuming that the eepro100.o driver doesn't work with all the
4 ports enabled, at least) ?

The card is maid for 64-bit PCI but should be pluggable to the ordinary
32-bit bus in which I should use it.

Sorry, I couldn't have tried these myself because I currently don't have
such board... The NIC's name is: Compaq NC3134 and the additional module
is NC3135. There's also older version of this hardware (might be
called NC3131 if I remember right). Useless to mention, Compaq doesn't
have linux drivers for this board.


-------------------------------------
 Riku Järvensivu <galaxy@cs.tut.fi>
 
 http://www.students.tut.fi/~galaxy/
-------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
