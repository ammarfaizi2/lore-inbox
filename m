Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131099AbRAFLh7>; Sat, 6 Jan 2001 06:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131159AbRAFLht>; Sat, 6 Jan 2001 06:37:49 -0500
Received: from pop.gmx.net ([194.221.183.20]:5707 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S131099AbRAFLhm>;
	Sat, 6 Jan 2001 06:37:42 -0500
From: Thomas Fuhrich <thomas.fuhrich@gmx.net>
Reply-To: thomas.fuhrich@gmx.net
To: chaffee@cs.berkeley.edu
Subject: Bug in vfat-module in all kernel versions 2.4.0-testx and 2.4.0-prerelease
Date: Sat, 6 Jan 2001 12:36:20 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01010612413100.00427@snoopy>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there seems to be a bug in the vfat-module. When I mount my SCSI MO drive with a
512 bytes/block disk, everything works fine. If I do the same thing with a
disks with 2kB/block I can mount it and read the directory. Once I try to run a
programm from the disk or try to edit or copy a file in either direction, I run
into a segmention fault. Afterwards, the partition cannot be unmounted anymore.
(By the way, since the mtools don't need the kernel to read a disk, they work
fine on the very same disk. Kernel 2.2.14-SuSE works fine as well.)
Hope that helps.
-Thomas

If more information is needed (which I do think is neccessary), please send me
an e-mail to  

thomas.fuhrich@gmx.net
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
