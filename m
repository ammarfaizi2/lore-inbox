Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSJLKmk>; Sat, 12 Oct 2002 06:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSJLKmk>; Sat, 12 Oct 2002 06:42:40 -0400
Received: from f162.law11.hotmail.com ([64.4.17.162]:30215 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262875AbSJLKmi>;
	Sat, 12 Oct 2002 06:42:38 -0400
X-Originating-IP: [213.190.37.247]
From: "Roman Lenskij" <romanlenskij@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: MFK 9.0 BUG 2
Date: Sat, 12 Oct 2002 10:48:21 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F1622OaJ09N7sEawxxa00002385@hotmail.com>
X-OriginalArrivalTime: 12 Oct 2002 10:48:22.0279 (UTC) FILETIME=[E2463170:01C271DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



System AMD Athlon thunder bird 800Mhz
MDK 9.0
mother bord Via kt133
Bug, when configuring system, system stops reponding for 1 sec or so
then for 1 sec everything is working then again ... and so on, after 3-4
min restarts (when in X) or gives this msg


Oct  9 13:52:14 rll kernel: udf: bad mount option "codepage=850"
Oct  9 13:53:04 rll kernel: udf: bad mount option "codepage=850"
Oct  9 13:54:05 rll last message repeated 5 times
Oct  9 13:56:53 rll last message repeated 3 times
Oct  9 14:41:42 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct  9 14:41:42 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct  9 14:42:13 rll last message repeated 647 times
Oct  9 14:43:15 rll last message repeated 1125 times
Oct 10 18:18:27 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 10 18:18:27 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 10 18:18:59 rll last message repeated 570 times
Oct 11 12:52:24 rll kernel: udf: bad mount option "codepage=850"
Oct 11 13:52:05 rll kernel: udf: bad mount option "codepage=850"
Oct 11 18:46:41 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 11 18:46:41 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 11 18:47:13 rll last message repeated 539 times
Oct 12 00:31:43 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 00:31:43 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 00:32:15 rll last message repeated 539 times
Oct 12 00:54:01 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 00:54:01 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 00:54:33 rll last message repeated 539 times
Oct 12 00:57:27 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 00:57:27 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 01:00:24 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 01:00:24 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 01:00:56 rll last message repeated 539 times
Oct 12 01:03:37 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 01:03:37 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 01:04:09 rll last message repeated 539 times
Oct 12 09:06:03 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 09:06:03 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 09:06:35 rll last message repeated 539 times
Oct 12 09:07:00 rll last message repeated 458 times
Oct 12 09:07:00 rll kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000003
Oct 12 09:07:00 rll kernel: *pde = 00000000
Oct 12 09:07:00 rll kernel: *pde = 00000000
Oct 12 09:07:00 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 09:21:57 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 09:21:57 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 09:41:03 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 09:41:03 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 10:18:34 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 10:18:34 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 11:46:22 rll kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 12 11:46:22 rll kernel: ide-scsi: Strange, packet command initiated yet 
DRQ isn't asserted
Oct 12 11:46:54 rll last message repeated 539 times

c0124601
*pde= 132ff067
*pte= 00000000
Oops: 0000
CPU: 0
EIP: 0010:[<co124601>] Not Tained
EFLAGS : 00010006
eax: 00000078 ebx: 00000018 ecx: 00000018 edx: 083445a0
esi: 00000000 edi: d2fc6000 ebp: d2fc7be8 esp: d2fc7bdc
Process (pid: 0, Stackpage = d2fc7000)
Stack: c0124672 00000018 083445a0 d2fc7c10 c01248b9 00000018 d2bc6000 
00000018
       d2fc6000 00000006 001500a8 d2fc6000 00000000 d2fc7c24 c0124bee 
00000018
       00000001 d2fc6000 d2fc7c44 c012381a 00000018 d2fc6000 00000001 
d2fc6000

Call Trace   [<c0124672>] [<c01248b9>] [<c0124bee>] [<c012381a>] 
[<c012384f>]
[<c0123a2c>] [<c010e89a>] [<c010a247>] [<c010a3db>] [<c010c8c8>] 
[<c02218d6>]
[<d886583b>] [<d886c108>] [<d887d340>] [<c01804f8>] [<c019a07f>] 
[<c019a4a2>]
[<d887d7a9>] [<c019a7f7>] [<c011be82>] [<c019d9c2>] [<c019ac5a>] 
[<c019aba0>]
[<c0123b2c>] [<c01236ed>] [<c01202e2>] [<c01201d4>] [<c012000a>] 
[<c010a416>]
[<c010c8c8>] [<c018d7ba>] [<c011b726>] [<c011eabd>] [<c0109643>] 
[<c01186a9>]

Code: 8b 54 82 b0 b8 01 00 00 00 83 ba 01 77 24 4a 74 22 8d 91 eb

<0> Kernel panic: Aiee, killing interrupt handler.
In interrupt handler - not syncing




I called it BSOD (*non windows BSOD, not Blue Screen Of Death) Black Screen 
Of Death :DD

Plz send me a reply

_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

