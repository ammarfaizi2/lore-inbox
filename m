Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKRGbr>; Sat, 18 Nov 2000 01:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKRGbh>; Sat, 18 Nov 2000 01:31:37 -0500
Received: from [209.249.10.20] ([209.249.10.20]:53155 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129091AbQKRGbZ>; Sat, 18 Nov 2000 01:31:25 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 17 Nov 2000 22:01:23 -0800
Message-Id: <200011180601.WAA01562@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: sound and scsi pci MODULE_DEVICE_TABLE entries? (primary for Alan Cox)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



	I tried sending this to Alan Cox, but his mailer complained
that we are connected via AboveNet, which blocks ORBS (which is true,
and which I have complained about to our ISP many times).  It is
primary intended for Alan, but anyone else who wants to chime in
is welcome to.

Adam
----------------------------------------------------------------------
Hello Alan,

        Jeff Garzik tells me that you, with some help from some other
kernel developers, are hacking on the sound drivers right now.  I
would like to add PCI MODULE_DEVICE_TABLE entries to three of
the four PCI sound drivers: cmpci, cs46xx and nm256_audio.
(I have already sent a similar patch to Zach Brown for maestro,
although that was a port to the new PCI interface.)  This will
enable depmod to record the PCI ID's that they care about in
/lib/modules/<version>/modules.pcimap, which, in turn, will
enable more automated module loading based on hardware configuration.

        Would this submission be duplicative of what you are working on?
If not, can I submit them to you or is there someone more appropriate
for me to submit changes to right now (e.g., each driver's author,
someone else)?  Since there are only four PCI sound drivers right
now, I would like to be able to fix the whole category.

        Also, do you know if there is someone shepherding the drivers/scsi
patches?  That is a more important category for automated loading, since
it may be needed in booting.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
