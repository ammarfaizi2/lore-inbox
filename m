Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132809AbRDQSmu>; Tue, 17 Apr 2001 14:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132811AbRDQSml>; Tue, 17 Apr 2001 14:42:41 -0400
Received: from sirius-giga.rz.uni-ulm.de ([134.60.246.36]:39814 "EHLO
	mail.rz.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S132809AbRDQSm1>; Tue, 17 Apr 2001 14:42:27 -0400
Date: Tue, 17 Apr 2001 20:42:25 +0200 (MEST)
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: AHA-154X/1535 not recognized any more
Message-ID: <Pine.SOL.4.33.0104172009480.16832-100000@lyra.rz.uni-ulm.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In my computer, I use an old ISA PNP SCSI host adapter, where I connectend
an external Iomega ZIP plus - this strange device (PPA and SCSI on the
same connector) doesn't like to share its SCSI-Bus with other devices -
thus I need two host adapters for two devices :-(

Now I have the problem that kernels 2.4.2 and 2.4.3 don't recognize this
adapter any more, while all 2.2-kernels I used (I currently remember
2.2.19, 2.2.18 and debian-2.2.17pre6) work with it without problems.

The BIOS message states it is an AHA 1540CP/1542CP BIOS V1.2, Win98SE
recognizes it as an AHA-154X/AHA-1535 Plug and Play SCSI Adapter, and runs
it with IRQ 10 and DMA 7.

According to dmesg, the 2.2.X kernels recognize it as an AHA 1542, whereas
the 2.4 series says that isapnp found an aha1535, but no driver is loaded.

pnpdump from isapnptools-1.21 recognizes it as an ADP1542 - even when
running with an 2.4.3-kernel.

I have put both dmesg-outputs and some other hopefully debugging output on
the web at http://schabi.de/scsi/ - I didn't want to post those files on
the mailing list, but if some of don't have http access, I'll happily mail
you those files personally.

Now I want to know whether this is a bug in the kernel (and where to
search to eventually fix it) or a misconfiguration in my host.

If you need some other info, or want me to run some tests, feel free to
mail me. It might even be possible to borrow the card to someone, as I'll
by a second hand IDE ZIP tomorrow, and then I could spare the card for
some weeks.

Thanks a lot,
markus

PS: I subscribed to the kernel list, so you don't have to BCC your answers
to me.

