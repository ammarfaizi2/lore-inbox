Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132276AbRBDUyX>; Sun, 4 Feb 2001 15:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132308AbRBDUyO>; Sun, 4 Feb 2001 15:54:14 -0500
Received: from cr949225-b.rchrd1.on.wave.home.com ([24.112.58.97]:19725 "HELO
	enfusion-group.com") by vger.kernel.org with SMTP
	id <S132276AbRBDUyD>; Sun, 4 Feb 2001 15:54:03 -0500
Date: Sun, 4 Feb 2001 15:53:54 -0500
From: Adrian Chung <adrian@enfusion-group.com>
To: linux-kernel@vger.kernel.org
Subject: Dual Promise Ultra66 PCI Cards
Message-ID: <20010204155354.A2674@toad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Organization: enfusion-group
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been attempting to get two Promise Ultra66 controllers working
with an Asus P2B-F motherboard.  I've got one controller successfully
working, but as soon as I stick the second controller in the computer,
the system refuses to boot.

With 2.2.18 and the linux-ide patches (Uniform E-IDE 6.30), the
computer refuses to boot if there are no bootable drives on the
motherboard's IDE controllers.  I have 4 hard drives on the promise
ultra66, and a cdrom drive on the motherboard's controller.  I've
tried setting the BIOS IDE/SCSI first option to SCSI, and it still
doesn't work.

I moved my boot drive to the motherboard's controller, and then linux
boots, but after detecting IDE devices, it hangs just after printing:

ide1 at ...
ide2 at ...
ide3 at ...

I don't have the exact messages at hand, but can produce them...

Any ideas?  Can this work?  I've read on the Promise site that
flashing the second controller with their "dummy" BIOS may make a
difference, but I'm not sure.

--
Adrian Chung
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
