Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129861AbRB0WsN>; Tue, 27 Feb 2001 17:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129865AbRB0WsE>; Tue, 27 Feb 2001 17:48:04 -0500
Received: from june.Broomfield1.Level3.net ([209.245.18.7]:35826 "EHLO
	june.Broomfield1.level3.net") by vger.kernel.org with ESMTP
	id <S129861AbRB0Wru>; Tue, 27 Feb 2001 17:47:50 -0500
From: Peter.Havens@Level3.com
Message-ID: <7599F001C7F8D4118AAD0008C791997403E947@N0239IDC1.oss.level3.com>
To: linux-kernel@vger.kernel.org
Subject: Promise Ultra100 IDE PDC20265 chip problem
Date: Tue, 27 Feb 2001 15:50:07 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(I am not subscribed to this list, if it is in fact a list. Please CC any
replies to me directly - Thanks)

I am attempting to install the new beta release of Red Hat (fisher) on my
home computer. It has an Asus A7V motherboard and a Promise Ultra100 IDE
controller (PDC20265 chip), with two partitions. Windows ME is installed in
the first partition. The second one is where I'm attempting to install Red
Hat.

In previous releases of the Linux kernel, my hard drive was not seen at all.
I could go all the way up to the point in the Red Hat installation where it
wanted to do disk geometry, and then said that I didn't have any mass media
device. Searching through various mail archives lead me to believe the
culprit was the PDC20265 controller chip and the fact that it was too new to
be recognized.

In the new kernel 2.4.0 (and thereby the fisher release of Red Hat), I now
see the error below printed out to the console when booting from the Red Hat
installation floppy. After the error is printed out, my computer hangs. I
apologize in advance if this is not a Linux kernel issue, and appreciate any
help that can be provided.

--Pete

[snip]

PDC 20265: chipset revision 2
PDC 20265: not 100% native mode: will probe irqs later

[snip]

Partition Check:
hde: [PTBL] [1826/255/63] hde1 hde2 < hde5hde: dma_intr: status=0x51 {
DriveReady SeekComplete Error }
hde: dma_intr: error=0x10 { SectorIdNotFound }, LBAsect=32885055, sector=0
hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }

[last repeats 3-4 times]

hde: DMA disabled

[hang]
