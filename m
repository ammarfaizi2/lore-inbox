Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263687AbREYKh0>; Fri, 25 May 2001 06:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263688AbREYKhQ>; Fri, 25 May 2001 06:37:16 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:46267 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S263687AbREYKg6>; Fri, 25 May 2001 06:36:58 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 25 May 2001 03:36:43 -0700
Message-Id: <200105251036.DAA23376@adam.yggdrasil.com>
To: hugh@misc.nu
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
Cc: aaronl@vitelus.com, acahalan@cs.uml.edu, greg@kroah.com,
        linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Here's a surprise.  I think the problems with the keyspan
copyrights may have sprung from an administrative error.  I notice that
the copyright notices in
linux-2.4.*/drivers/usb/serial/keyspan_usa{26,28,49}msg.h, which look
GPL compatible to me, look as if they were intended for
keyspan_usa{18x,19,28,28x,49w}_fw.h, since they refer to firmware
in their titles:

        Copyright (c) 1998-2000 InnoSys Incorporated.  All Rights Reserved
        This file is available under a BSD-style copyright

        Keyspan USB Async Firmware to run on Anchor EZ-USB
                          ^^^^^^^^


	Yet, the keyspan*msg.h files have no firmware.  The firmware
is in keyspan_usa*_fw.h.

	Hugh, perhaps you could pass this up the chain of command
at Keyspan and see if they will simply grant permission to
replace the *_fw.h copyright notice with the one from *msg.h, which
is probably a lot simpler than having them spend lawyer and management
time on writing new terms.

	I have cc'ed this to linux-kernel because there is a
current discussion going on there on this subject that I had just
responded to.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
