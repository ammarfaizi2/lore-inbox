Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130468AbQKQROc>; Fri, 17 Nov 2000 12:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130450AbQKQROX>; Fri, 17 Nov 2000 12:14:23 -0500
Received: from mh1dmz1.bloomberg.com ([199.172.169.36]:714 "EHLO
	mh1dmz1.bloomberg.com") by vger.kernel.org with ESMTP
	id <S130424AbQKQRON>; Fri, 17 Nov 2000 12:14:13 -0500
From: Dave Seff <dseff@bloomberg.com>
Date: Fri, 17 Nov 2000 12:44:11 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: groudier@club-internet.fr
Subject: Kernel Panic
MIME-Version: 1.0
Message-Id: <00111712441100.05390@jupiter>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not subscribed to this list, so please cc me on replies. Thanks. 
I was running mke2fs on an external 17GB SCSI drive. This started spewing and 
blasted the 2.2.17mdksmp kernel. 



ncr53c896-0:2: ERROR (0:4) (8-0-0) (0/f) @ (script 42c:0f000001).
ncr53c896-0: script cmd = 71500000
ncr53c896-0: regdump: da 00 80 0f 47 00 02 0b 81 00 82 00 80 00 08 02.
ncr53c896-0: have to clear fifos.
ncr53c896-0: unexpected disconnect
ncr53c896-0:2: ERROR (0:4) (8-0-0) (0/7) @ (script dc:870b0000).
ncr53c896-0: script cmd = 900a0000
ncr53c896-0: regdump: da 00 80 07 47 00 02 0b 02 08 00 00 80 00 03 02.
ncr53c896-0: have to clear fifos.
ncr53c896-0: unexpected disconnect
ncr53c896-0: SCSI parity error detected: SCR1=138 DBC=870b0000 SSTAT1=3
ncr53c896-0:2: SIR 16, incorrect nexus identification on reselection
ncr53c896-0:2: ERROR (81:0) (6-a3-2) (0/7) @ (scripth 12c0:48000000).
ncr53c896-0: script cmd = 80080000
ncr53c896-0: regdump: da 00 00 07 47 00 02 0b 76 00 82 00 80 00 00 02.
ncr53c896-0: have to clear fifos.
Unable to handle kernel NULL pointer dereference at virtual address 00000040
current->tss.cr3 = 00101000, %cr3 = 00101000
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c024877f>]
EFLAGS: 00010046
eax: 00000000   ebx: db222800   ecx: f7ff8960   edx: 00000000
esi: f7fd5000   edi: f7fd51c4   ebp: 00000000   esp: c02e7e14
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, process nr: 0, stackpage=c02e7000)
Stack: f7fd51c4 1b222800 00000000 c011056f c0240fe3 f7fe8c00 00000000 
00000000 
       00000086 00000000 00000286 c009ee00 00000004 c0248c06 f7fd5000 
00000001 
       db222800 00000000 00000000 f7fd5000 0000000a 00000004 00000246 
00000001 
Call Trace: [<c011056f>] [<c0240fe3>] [<c0248c06>] [<c010bb79>] [<c0247e1e>] 
[<c010b9e9>] [<c0249ebf>] 
       [<c0114c0a>] [<c011056f>] [<c010b9e9>] [<c0114e44>] [<c010a58f>] 
[<c011ac71>] [<c010bb79>] [<c010bb90>] 
       [<c0110fbe>] [<c010a5e8>] [<c0107af9>] [<c0106000>] [<c01001ae>] 
Code: 8a 45 40 8d 14 80 8d 14 d0 8d 54 96 7c 89 54 24 2c 8b 44 24 
Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!
In swapper task - not syncing


Dave Seff
Systems Administrator
Bloomberg Financial Markets
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
