Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279547AbRKHN2p>; Thu, 8 Nov 2001 08:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279588AbRKHN2g>; Thu, 8 Nov 2001 08:28:36 -0500
Received: from pool-141-158-41-82.phil.east.verizon.net ([141.158.41.82]:47488
	"EHLO jsmith.org.org") by vger.kernel.org with ESMTP
	id <S279547AbRKHN22>; Thu, 8 Nov 2001 08:28:28 -0500
Subject: Problems with recent kernels
From: "Justin R. Smith" <jsmith@mcs.drexel.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0+cvs.2001.11.06.15.04 (Preview Release)
Date: 08 Nov 2001 08:27:49 -0500
Message-Id: <1005226069.12034.0.camel@jsmith.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please respond to me personally since I am not subscribed to this list.

Is there a problem with some of the recent kernels? (2.4.12-2.4.14)

I am running Redhat 7.1 on two systems:

1. a Pentium II system using the ext2 file systems on all partitions.

2. a Pentium III system using the ext2 file system.

 When I switched to kernel version 2.4.12 on both machines, I
encountered problems:

1. the Pentium II machine had major file system errors on boot after
clean shutdowns (major =  fsck must be run in manual mode). After a few
reboots, the system was unusable. I reinstalled the operating system and
upgraded the kernel to 2.4.9 and it has run perfectly since.

2. the Pentium III system had different problems (under kernel 2.4.12):
many applications crashed with error messages 

     xmalloc cannot allocate 10 bytes

although the system has 300 meg of RAM and a gig of swap.

When I moved to the 2.4.14 kernel on the Pentium II machine, I got a
file system error after a clean shutdown, but it wasn't as severe as the
problems I had earlier: the damaged file system passed the fsck test.
Again, retreating to 2.4.9 solved the problems.

Any suggestions?
-- 

