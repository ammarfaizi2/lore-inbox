Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272304AbRIVWAc>; Sat, 22 Sep 2001 18:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272407AbRIVWAW>; Sat, 22 Sep 2001 18:00:22 -0400
Received: from nic-131-c196-222.mw.mediaone.net ([24.131.196.222]:2316 "EHLO
	moonweaver.awesomeplay.com") by vger.kernel.org with ESMTP
	id <S272304AbRIVWAE>; Sat, 22 Sep 2001 18:00:04 -0400
Subject: ATAPI CD-ROM lockups
From: Sean Middleditch <elanthis@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 22 Sep 2001 18:02:42 -0400
Message-Id: <1001196162.772.12.camel@stargrazer>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

	I have, for a long time now, had problems with one or both of my CD-ROM
drives (one is a CD-RW, the other a DVD drive).  I get hard kernel
lockups when reading from them at times.

	I've had this problem back when I ran Mandrake (and a 2.2.x kernel),
and I still have it now (Debian Sid, kernel 2.4.9).  I always thought it
was a buggy Mandrake kernel, but now I'm pretty dang sure that's not the
case.

	This error is in /var/log/kern.log:
Sep 22 17:33:08 localhost kernel: scsi0: ERROR on channel 0, id 0, lun
0, CDB: Request Sense 00 00 00 40 00 
Sep 22 17:33:08 localhost kernel: Info fld=0x0, Current sd0b:00: sense
key Medium Error
Sep 22 17:33:08 localhost kernel:  I/O error: dev 0b:00, sector 4608

	I've seen, long ago, more errors printed to the terminal screen, but
now since I run X all the time, I don't see these - how can I get to
them, or would they just be the message posted above?

	I'm currently running an Athlong system, AMD chipset (don't know
which), 160 MB of 100mhz SDRAM.  The CD drives in questions are an
Iomega ZIP-CD 650 and some generic "Compaq" DVD-drive (no, the machine
is not a Compaq - I've replaced just about every part in it, except that
DVD drive).  I've had this problem with all sorts of other hard-ware
configs on this machine, on three different distros, on different
motherboards, with different kernel versions.  I've also had the problem
even when teh DVD drive was not in the system.  In short, the only thing
that has remained the same is the Zip CD.  In addition, I don't recall
ever having this problem under Windows 98 when it was installed, but
then again, it's pretty difficult to find out *why* a Windows box locks
up.  I was on the Windows box capable of installing software of a CD,
which tends to be fairly difficuly in Linux thanks to these lockups.

	I don't know what to do about this other than try buying a new CD-RW
and DVD drive, but I *am* a poor college student.  ~,^

	btw, I'm not subsribed to the list, there is way too much traffic for
me here.  My e-mail is at sean.middleditch@iname.com.

Thanks,
Sean Etc.

