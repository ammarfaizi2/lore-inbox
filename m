Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131936AbRAPUER>; Tue, 16 Jan 2001 15:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131848AbRAPUEI>; Tue, 16 Jan 2001 15:04:08 -0500
Received: from vela.salleURL.edu ([130.206.42.85]:6665 "EHLO vela.salleURL.edu")
	by vger.kernel.org with ESMTP id <S131876AbRAPUEE>;
	Tue, 16 Jan 2001 15:04:04 -0500
Date: Tue, 16 Jan 2001 21:17:53 +0000 (GMT)
From: Carles Pina i Estany <is08139@salleURL.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Name of SCSI Device
Message-ID: <Pine.LNX.4.30.0101162111550.15252-100000@vela.salleURL.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

When we install a IDE hard disk drive, and configure as Master and connect
on Primary IDE Interface, this disk WILL BE ALWAYS hda. We can install
other hard disks (e.g. hdb, hdc...) but the disk that it is connected as
hda, will not change.

If we install a SCSI hard disk drive, with ID3, an nothing on ID1 or ID2,
will be sda. If we install a new disk on ID1, the drive that before was
sda now change the name to sdb.

Or, if we have:
sda ID1
sdb ID2
sdc ID3
sdd ID4

And we remove sda, then sdb change to sda, sdc to sdb, sdd to sdc.

Why the name of hard disk drive of SCSI Controller are not fixed?
ID0=sda
ID1=sdb
ID2=sdc
...

Then, it is possible that we must change /etc/fstab

Then, if I have a disk with ID3, I can connect on all computers and ALWAYS
is sdc, I don't count how many disks are before, etc.

I don't understand why the name change...

There are any reason?

Thank you very much.

----
Carles Pina i Estany
   E-Mail: cpina@linuxfan.com || #ICQ: 14446118 || Nick: Pinux
   URL: http://www.salleurl.edu/~is08139
   Ley de Murphy: Si algo puede fallar, fall<NO CARRIER>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
