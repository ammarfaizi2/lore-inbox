Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129650AbQKHXA7>; Wed, 8 Nov 2000 18:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129265AbQKHXAt>; Wed, 8 Nov 2000 18:00:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23612 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129650AbQKHXAq>; Wed, 8 Nov 2000 18:00:46 -0500
Subject: Linux 2.4.0test11pre1ac1
To: linux-kernel@vger.kernel.org
Date: Wed, 8 Nov 2000 23:01:50 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13teE4-0000XI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patches I have in my pending/twiddled with pile at the moment.
I'll also send bits of this off to Linus

Whats different

o	Ramfs allows size limiting (very handy when fiddling with PDA's)
o	Knows the 'kgcc' convention for conectiva/mandrake/red hat
o	Build ACPI if you have ACPI but no interpreter
o	Tidy up naming on machine check code
o	36bit MTRR
o	Fix PIV ident bug
o	Fix K6 CPU on dual board crash
o	Much faster block copy functions on the Athlon
o	Fix daemonize to do exit_files. All callers do this or should do
	anyway
o	Cpqarray procfs fix
o	Fix build bug with old hard disk driver
o	Fix free then reference with pcbit isdn
o	Check/requestion region clean for radio drivers
o	Cleaner version of the PnP cadet radio patch
o	Seperate tx timeout code for 8390
o	Network driver request region fixes
o	de4x5 user space copy in spinlock fix
o	epic100 delay fixes
o	Avoid crash on iph5526 on out of memory
o	Fix locking bugs on roadrunner
o	Fix crash on insmod risk with many scsi drivers
o	Fix incorrect runtime panics in some scsi drivers
o	Fix HZ in the aha152x driver
o	Remove escaped and dead check for I2O in megaraid
o	Fix i810 audio driver
o	Fix cramfs initrd data loss bug
o	Fix power management locking
o	Fix resource printks that only print 4 digits
o	Fix missing return value in atm pvc
o	Disable SPX (doesnt work, no maintainer etc)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
