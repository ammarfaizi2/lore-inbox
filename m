Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129786AbQLHS0X>; Fri, 8 Dec 2000 13:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130013AbQLHS0N>; Fri, 8 Dec 2000 13:26:13 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:15765 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S129733AbQLHS0C>; Fri, 8 Dec 2000 13:26:02 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 8 Dec 2000 09:55:29 -0800
Message-Id: <200012081755.JAA04672@adam.yggdrasil.com>
To: proski@gnu.org
Subject: Re: [PATCH] for YMF PCI sound cards
Cc: kai@thphy.uni-duesseldorf.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	This ALSA-based Yamaha PCI driver does not have the changes
from ALSA that were necessary to make it run on the Transmeta-based
Sony PictureBooks, right?  I tried the driver in 2.4.0-test12pre7,
and that driver with Pavel's patch, and that driver with Pavel's
patch with "#include <linux/config.h>, #undef CONFIG_SMP", and
got the same behavior in all three cases:

	Loading the module would cause a very loud monotone
squeal, like some kind of theft detection device.  The computer
would still work while it was sqealing, but sync'ing the discs
would never return.  rmmod'ing the module would cause a second
noise to be superimposed on the first, one that sounded like a
worn down fan or the purr that some BIOS'es make when they are
testing RAM.

	If this version does not have whatever changes were
need for the Transmeta-baed Picturebook, then never mind.
If it is not some obvious oversight, I guess I will try installing
ALSA and comparing the drivers.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
