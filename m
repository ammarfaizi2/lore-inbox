Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277949AbRKFErG>; Mon, 5 Nov 2001 23:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281458AbRKFEq5>; Mon, 5 Nov 2001 23:46:57 -0500
Received: from mercury.jncasr.ac.in ([202.41.111.11]:46991 "EHLO
	mercury.intranet.jncasr.ac.in") by vger.kernel.org with ESMTP
	id <S277949AbRKFEqq>; Mon, 5 Nov 2001 23:46:46 -0500
Date: Tue, 6 Nov 2001 10:21:48 +0530 (IST)
From: CMC <cmc@jncasr.ac.in>
X-X-Sender: <cmc@mercury.intranet.jncasr.ac.in>
To: <linux-kernel@vger.kernel.org>
Subject: Crash due to kernel bug 
Message-ID: <Pine.LNX.4.33.0111061018540.6335-100000@mercury.intranet.jncasr.ac.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The RH7.1 system with 2.4.2 kernel crashed and the /var/log/messages had
this report.

Nov  4 08:55:19 mercury kernel: kernel BUG at inode.c:527!
Nov  4 08:55:19 mercury kernel: invalid operand: 0000
Nov  4 08:55:19 mercury kernel: CPU:    0
Nov  4 08:55:19 mercury kernel: EIP:    0010:[prune_icache+148/272]
Nov  4 08:55:19 mercury kernel: EIP:    0010:[<c0146954>]
Nov  4 08:55:19 mercury kernel: EFLAGS: 00010286
Nov  4 08:55:19 mercury kernel: eax: 0000001b   ebx: c94b00e8   ecx: fffffffe
edx: 00000000
Nov  4 08:55:19 mercury kernel: esi: c94b00e0   edi: c899cde8   ebp: c147bf98
esp: c147bf74
Nov  4 08:55:19 mercury kernel: ds: 0018   es: 0018   ss: 0018
Nov  4 08:55:19 mercury kernel: Process kswapd (pid: 4,
stackpage=c147b000)
Nov  4 08:55:19 mercury kernel: Stack: c0214b5b c0214c3e 0000020f 00000132
c94b0
2c8 cd246de8 00010f00 00000004
Nov  4 08:55:19 mercury kernel:        00000020 00000004 c0146a05 000002b0
c012cba6 00000004 00000004 c144be6c

proc/modules
tulip                  38096   2 (autoclean)
8139too                16480   1 (autoclean)
usb-uhci               20848   0 (unused)
usbcore                49632   1 [usb-uhci]
sd_mod                 11808   0 (unused)
scsi_mod               94304   1 [sd_mod]

/proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 2
cpu MHz         : 400.915
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov
pat p
se36 mmx fxsr
bogomips        : 799.53


What could be the reason for this crash.?


regards,
Nagamani.
-------------------------------------------------------------------------------


