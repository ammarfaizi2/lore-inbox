Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270047AbUIDEaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270047AbUIDEaT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 00:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270049AbUIDEaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 00:30:19 -0400
Received: from lakermmtao08.cox.net ([68.230.240.31]:12683 "EHLO
	lakermmtao08.cox.net") by vger.kernel.org with ESMTP
	id S270047AbUIDEaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 00:30:12 -0400
Mime-Version: 1.0 (Apple Message framework v619)
Content-Transfer-Encoding: 7bit
Message-Id: <1B6CEB06-FE2B-11D8-B9BD-000393ACC76E@mac.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [2.4.25] "pc_keyb: controller jammed (0xFF)" on Super Micro P5MMA98
Date: Sat, 4 Sep 2004 00:30:10 -0400
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Super Micro P5MMA98 motherboard that does not recognize the 
PS/2
keyboard controller under Debian.  It repeatedly gives errors like the 
following
for about the first 500 lines of output, and the keyboard controller 
doesn't work.

pc_keyb: controller jammed (0xFF).
pc_keyb: controller jammed (0xFF).
pc_keyb: controller jammed (0xFF).
pc_keyb: controller jammed (0xFF).

I saw a couple earlier posts that indicated this may arise when the 
keyboard
controller registers can't be read and give all ones, but I'm unclear 
as to how
to fix this.  The computer appears to boot Windows fine with full 
keyboard
support, so I think this is just a Linux issue.

A full dmesg is here:
http://www.tjhsst.edu/~kmoffett/dmesg.txt

And the kernel config is here:
http://www.tjhsst.edu/~kmoffett/config-2.4.25-1-386.txt

The kernel has stock Debian patches for 2.4.25 from unstable (sid).

Thanks for your help!

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------

