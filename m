Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRJABOk>; Sun, 30 Sep 2001 21:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274372AbRJABOa>; Sun, 30 Sep 2001 21:14:30 -0400
Received: from [203.94.130.164] ([203.94.130.164]:9739 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id <S274368AbRJABOS>;
	Sun, 30 Sep 2001 21:14:18 -0400
Date: Mon, 1 Oct 2001 11:27:36 +1000 (EST)
From: <brett@bad-sports.com>
To: <linux-kernel@vger.kernel.org>
Subject: Panasonic KXLC101 (pcmcia scsi/sound) system hang
Message-ID: <Pine.LNX.4.33.0110011122210.1954-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

While trying to get the above card to work (scsi for a start, since there
seems to be a driver for this), this happened:

Sep 29 10:25:43 lapsis cardmgr[87]: initializing socket 1
Sep 29 10:25:43 lapsis cardmgr[87]: socket 1: Panasonic KXLC101
Sep 29 10:25:43 lapsis cardmgr[87]: executing: 'modprobe qlogic_cs'
Sep 29 10:25:43 lapsis cardmgr[87]: + Warning: loading
/lib/modules/2.4.9-ac16/kernel/drivers/scsi/scsi_mod.o will taint the
kernel: no license
Sep 29 10:25:43 lapsis kernel: SCSI subsystem driver Revision: 1.00
Sep 29 10:25:43 lapsis cardmgr[87]: + Warning: loading
/lib/modules/2.4.9-ac16/kernel/drivers/scsi/pcmcia/qlogic_cs.o will taint
the kernel: no license
Sep 29 10:25:43 lapsis kernel: Ql: Using preset base address of 230
Sep 29 10:25:43 lapsis kernel: Ql: Using preset IRQ 5
Sep 29 10:25:43 lapsis kernel: scsi0 : Qlogicfas Driver version 0.46, chip
50 at 230, IRQ 5, TPdma:1
Sep 29 10:25:49 lapsis kernel: scsi : aborting command due to timeout :
pid 0, scsi0, channel 0, id 0, lun 0 Inquiry 00 00 00 ff 00

---

And then a system hang, beyond sysrq.
What should I do from this, to get some useful debugging info?
Or is this card a lost cause in the first place ?

---

Secondly, apparently the sound card part of it is sb compatible, and uses
an OPL3.  Since there is already a pci driver, how hard will it be to
create a pcmcia driver for this ?

---

Any help appreciated, more info on demand, of course.
And please CC me, as I only monitor the list by geocrawler, which is
sporadic at best.

thanks,

	/ Brett Pemberton

