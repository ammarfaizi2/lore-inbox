Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265428AbRFVOQB>; Fri, 22 Jun 2001 10:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265426AbRFVOPl>; Fri, 22 Jun 2001 10:15:41 -0400
Received: from [63.122.248.27] ([63.122.248.27]:778 "EHLO
	gator.techcontrol.com") by vger.kernel.org with ESMTP
	id <S265428AbRFVOPj>; Fri, 22 Jun 2001 10:15:39 -0400
Message-ID: <33890A53976FD41191A800B0D03DF196B4C5E0@gator.techcontrol.com>
From: "Andrews, Jeremy" <jandrews@convergentnet.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.5 - Kernel Panic
Date: Fri, 22 Jun 2001 10:07:57 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  I've been trying to update my home (originally RedHat 7.0) linux server
from the 2.4.4 kernel to the 2.4.5 kernel.  On other servers I've had no
problems at all, but for some reason my Gateway GP7-550 P-III at home is
being stubborn.  I've reconfigured and rebuilt numerous times hoping to
figure out what I've done wrong, but no luck.

  When booting, shortly after recognizing all my hardware, I see the
following.  Up to the second NET4 message is normal, but after that...

	LVM version 0.9.1_beta2  by Heinz Mauelshagen (18/01/2001)
	lvm -- Driver successfully initialized
	NET4: Linux TCP/IP 1.0 for NET4.0
	IP Protocols: ICMP, UDP, TCP
	IP: routing cache has tble of 2048 buckets, 16Kbytes
	TCP: Hash tables configured (established 16384 bind 16384)
	ip_tables: (c)2000 Netfilter core team
	NET4: Unix domain sockets 1.0/SMP for Linux NET 4.0
	EXT2-fs: unable to read superblock
	isofs_read_super: bread failed, dev=3:01. iso-blknum=16, block=32
	Kernel panic VFS: Unable to mount root fs on 03:01

  And that's where she sits until I power-cycle her.  Booting to my 2.4.4
kernel there are no problems.

  When compiling, I originally just copied the .config from my 2.4.4 source
tree, loading that with make xconfig.  Due to the problem above, I then
started fresh and ran into the same problem.  I also tried downloading Eric
Raymond's CML2, got eaten by a grue so moved to xconfig, and still same
problem when booting.

  I'm compiling with gcc 2.95.3.

  Any help is appreciated.

Thanks,
  -Jeremy
