Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKSRh7>; Sun, 19 Nov 2000 12:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQKSRht>; Sun, 19 Nov 2000 12:37:49 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:54175 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S129152AbQKSRho>; Sun, 19 Nov 2000 12:37:44 -0500
Date: Sun, 19 Nov 2000 17:43:43 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11-pre3: kernel: Attempt to read inode for relocated directory
Message-ID: <20001119174342.A10255@iapetus.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.4.0-test11-pre3 kernel said

Nov 19 17:40:25 iapetus kernel: Attempt to read inode for relocated directory 
Nov 19 17:40:25 iapetus last message repeated 8 times

while doing a

	mount -t iso9660 /dev/hdc /cdrom
	cd /cdrom
	find -depth |cpio -pdm /dst

Is reproducable here, both by loopback mounting the iso9660
image as by mounting the CD-RW where it has been written to.

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
