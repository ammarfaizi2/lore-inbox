Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293347AbSC3XgG>; Sat, 30 Mar 2002 18:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293448AbSC3Xf4>; Sat, 30 Mar 2002 18:35:56 -0500
Received: from [62.189.41.121] ([62.189.41.121]:8452 "EHLO getyour.pawsoff.org")
	by vger.kernel.org with ESMTP id <S293347AbSC3Xfj>;
	Sat, 30 Mar 2002 18:35:39 -0500
From: Kieran Fulke <kieran@getyour.pawsoff.org>
Message-Id: <200203302339.g2UNdXcG006793@getyour.pawsoff.org>
Subject: Oops - 2.4.18 MegaRaid/Alpha
To: linux-kernel@vger.kernel.org
Date: Sat, 30 Mar 2002 23:39:31 +0000 (UTC)
X-Mailer: ELM [version 2.4ME+ PL94 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

got this on 'modprobe megaraid'
similar message when compiled into the kernel proper:

 kernel: megaraid: v1.18 (Release Date: Thu Oct 11 15:02:53 EDT 2001)
 kernel: megaraid: found 0x8086:0x1960:idx 0:bus 0:slot 7:func 1
 kernel: scsi1 : Found a MegaRAID controller at 0x2400000, IRQ: 24
 kernel: modprobe(204): Oops 0
 kernel: pc = [<fffffffc00277cb0>]  ra = [<fffffffc002789d8>]  ps = 0000    Not tainted
 kernel: v0 = 000000009e4a0670  t0 = 000000009e4a0670  t1 = ffffffff9e4b6010
 kernel: t2 = fffffc001e533b97  t3 = fffffc001e533b8b  t4 = 00000000000f00a1
 kernel: t5 = fffffc001e533b88  t6 = 0000000000000000  t7 = fffffc001e530000
 kernel: s0 = 000000001e4b6010  s1 = fffffc001e533b88  s2 = 000000001e4b6010
 kernel: s3 = 0000000000000000  s4 = fffffc001e4a00c0  s5 = 000000001e4b601f
 kernel: s6 = 0000000000000000
 kernel: a0 = fffffc001e4a00c0  a1 = fffffc001e533b88  a2 = 0000000000000000
 kernel: a3 = 0000000000000000  a4 = fffffc001e4a00c0  a5 = fffffc0000acdfc0
 kernel: t8 = 0000000000000000  t9 = fffffc0000a28a80  t10= fffffc001ff0d000
 kernel: t11= 000000000000000a  pv = fffffc000081c380  at = fffffc0000acdfd8
 kernel: gp = fffffffc00286f30  sp = fffffc001e533ad8
 kernel: Trace:fffffc000084ad00 fffffc000081c010 fffffc000099b24c fffffc000099c9d8 fffffc000084b468 fffffc0000825a0c fffffc0000810b20
 kernel: Code: a04d0018  4161f40e  b45e0050  2fe00000  47ff041f  2fe00000 <2c2b000f> 47ff041f

happens on 2.4.18-xfs, and also on a vanilla 2.4.18 (root fs is ext3)
only other modules loaded are serial.o, unix.o and rtc.o

regards
