Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153964AbQBNGEX>; Mon, 14 Feb 2000 01:04:23 -0500
Received: by vger.rutgers.edu id <S153968AbQBNGD6>; Mon, 14 Feb 2000 01:03:58 -0500
Received: from ns.asimus.de ([193.101.116.1]:3321 "EHLO isdnpc.asimus.de") by vger.rutgers.edu with ESMTP id <S154067AbQBNGDh> convert rfc822-to-8bit; Mon, 14 Feb 2000 01:03:37 -0500
Message-ID: <01BF76DB.5DA0FC10@PCB>
From: Thomas Scholz <scholz@mail.asimus.de>
To: "'linux-kernel@vger.rutgers.edu'" <linux-kernel@vger.rutgers.edu>
Subject: compiling error with 2.3.45: pcmciasupport cs.c miss the linux/compile.h
Date: Mon, 14 Feb 2000 11:05:11 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Sender: owner-linux-kernel@vger.rutgers.edu

Hello I hope I can help you !

1. compiling error with 2.3.45: pcmciasupport cs.c miss the linux/compile.h

2. The Compiler says 'cs.c don't find linux/compile.h'  by compiling the modules for pcmcia

3. modules pcmcia 

4. "linux jess 2.2.13 #6 Sat Feb 12 23:51:35 CET 2000 i486 unknown" eval

5   ???

6.  forget it, compile the kernel

7.  

7.1.-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux jess 2.2.13 #6 Sat Feb 12 23:51:35 CET 2000 i486 unknown
Kernel modules         2.3.6
Gnu C                  2.7.2.3
Binutils               2.9.1.0.25
Linux C Library        x   1 root     root      4223971 Dec  6 21:00 /lib/libc.so.6
Dynamic linker         ldd (GNU libc) 2.1.2
Procps                 2.0.2
Mount                  2.9z
Net-tools              1.53
Kbd                    0.99
Sh-utils               2.0
Modules Loaded         sr_mod isofs adlib_card opl3 sb uart401 sound soundcore autofs 3c589_cs ds i82365 pcmcia_core serial memstat cdrom ppscsi sd_mod scsi_mod parport_pc parport

7.2. 
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 4
model		: 8
model name	: 486 DX/4
stepping	: 0
fdiv_bug		: no
hlt_bug		: no
sep_bug	: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme
bogomips	: 49.77
 
 7.3. sr_mod                 17860   0 (autoclean) (unused)
isofs                  19568   0 (autoclean) (unused)
adlib_card               900   0 (autoclean)
opl3                   12008   0 (autoclean) [adlib_card]
sb                     36660   0 (autoclean)
uart401                 6416   0 (autoclean) [sb]
sound                  61740   0 (autoclean) [adlib_card opl3 sb uart401]
soundcore               2788   6 (autoclean) [sb sound]
autofs                  9888   1 (autoclean)
3c589_cs                8944   1
ds                      7116   2 [3c589_cs]
i82365                 32472   2
pcmcia_core            55176   0 [3c589_cs ds i82365]
serial                 42932   0 (autoclean)
memstat                 1604   0 (unused)
cdrom                  14168   0 [sr_mod]
ppscsi                 11068   0
sd_mod                 19580   0 (unused)
scsi_mod               62248   2 [sr_mod ppscsi sd_mod]
parport_pc              6308   0 (unused)
parport                 7800   0 [parport_pc]

7.4 
Attached devices: none

7.5  notebook 20MB , FP 2GB 
       pcmica i82365 

X. i crack the prolbem:  I copy the compile.h for kernel 2.3.13 into to usr/src/linux/include/linux 
 

THANK YOU for your wunderful performance in a free linux
greetings Thomas Scholz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
