Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266818AbRGFTjl>; Fri, 6 Jul 2001 15:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266817AbRGFTjb>; Fri, 6 Jul 2001 15:39:31 -0400
Received: from ns1.dvti.com ([12.144.144.44]:21144 "EHLO hannibal.mammoth.org")
	by vger.kernel.org with ESMTP id <S266815AbRGFTjY>;
	Fri, 6 Jul 2001 15:39:24 -0400
Date: Fri, 6 Jul 2001 14:39:24 -0500 (CDT)
From: josh <skulcap@mammoth.org>
To: linux-kernel@vger.kernel.org
Subject: funky tyan s2510
Message-ID: <Pine.LNX.4.21.0107061109400.20154-100000@hannibal.mammoth.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a tyan s2510 with a single pIII 800Mhz cpu and 1GB of RAM.
I have been having problems with this system from the get go and
cant seem to narrow down what the problem is.  I have tried running
2.4.6, but the system usually doesnt last more than a day.  With 
2.4.2 i get a variety of kernel messages:
#############################################
vs-5150: search_by_key: invalid format found in block 0. Fsck?
vs-13050: reiserfs_update_sd: i/o failure occurred trying to update [59906829 0x0 SD] stat datavs-13060: reiserfs_update_sd: stat data of object [10616 10762 0x0 SD] (nlink == 1) not found (pos 6)
vs-13060: reiserfs_update_sd: stat data of object [8766 9018 0x0 SD] (nlink == 1) not found (pos 0)
vs-13060: reiserfs_update_sd: stat data of object [8766 8959 0x0 SD] (nlink == 1) not found (pos 12)
vs-13060: reiserfs_update_sd: stat data of object [8766 8959 0x0 SD] (nlink == 1) not found (pos 12)
memory.c:303: bad pmd 8524468b.
memory.c:83: bad pmd 831074c0.
memory.c:83: bad pmd 8524468b.
memory.c:83: bad pmd 831074c0.
memory.c:83: bad pmd 8524468b.
memory.c:83: bad pmd 831074c0.
memory.c:83: bad pmd 8524468b.
memory.c:83: bad pmd 831074c0.
kernel BUG at inode.c:79!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01418fe>]
EFLAGS: 00010282
eax: 0000001a   ebx: f5e3c2a0   ecx: d99ae000   edx: 00000000
esi: c027e120   edi: dc12a620   ebp: d99affa4   esp: d99aff44
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 13400, stackpage=d99af000)
Stack: c02301a5 c0230225 0000004f f5e3c2a0 c01428b6 f5e3c2a0 dc12a620 f5e3c2a0
       c01413c6 f5e3c2a0 00000000 f5d1ea00 c013b1fc dc12a620 dc12a620 dc12a620
       d82e0000 c013b2d3 f5d1ea00 dc12a620 d99ae000 00000000 bffffe82 bffffc48
Call Trace: [<c01428b6>] [<c01413c6>] [<c013b1fc>] [<c013b2d3>] [<c0108d5f>]

Code: 0f 0b 83 c4 0c a1 90 09 2d c0 53 50 e8 d9 65 fe ff 83 c4 08
############################################################

gcc never gets all the way through a make... it will die with a
sig11, misc asm errors, or random crap.

This is a serverworks chipset... i have always thought that they were
a bit, you know, funny.  :)   

Any ideas?

                          www.mammoth.org/~skulcap
**********************************************BEGIN GEEK CODE BLOCK************
"Sometimes, if you're perfectly      * GCS d- s: a-- C++ ULSC++++$ P+ L+++ E--- 
still, you can hear the virgin       * W+(++) N++ o+ K- w--(---) O- M- V- PS-- 
weeping for the savior of your will."* PE Y+ PGP t+ 5 X+ R !tv b+>+++ DI++ D++  
 --DreamTheater, "Lines in the Sand" * G e h+ r-- y-   (www.geekcode.com)
**********************************************END GEEK CODE BLOCK**************



