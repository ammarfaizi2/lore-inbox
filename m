Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278042AbRJ0IVr>; Sat, 27 Oct 2001 04:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278046AbRJ0IVh>; Sat, 27 Oct 2001 04:21:37 -0400
Received: from 39dyn126.com21.casema.net ([213.17.44.126]:27537 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S278042AbRJ0IV2>; Sat, 27 Oct 2001 04:21:28 -0400
Message-Id: <200110270822.KAA11581@cave.bitwizard.nl>
Subject: SR driver
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Date: Sat, 27 Oct 2001 10:22:03 +0200 (MEST)
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I have a program that will read a device. However, instead of stopping
on error, it will "note the error for later use", and continue.

When I do this on SCSI or IDE disks, the program will get EOF at the
end of the disk, and it can take appropriate action. However, when
run against a SCSI cdrom, it will continue going untill it fills 
all my disk space. 

This happened on our fileserver, which is currently running 2.4.13,
but it might have been running 2.4.10 at the time that this happened.
(Uptime tells me the machine has been rebooted in the meantime). 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
