Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270000AbRHETZu>; Sun, 5 Aug 2001 15:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269997AbRHETZk>; Sun, 5 Aug 2001 15:25:40 -0400
Received: from redbull.speedroad.net ([195.139.232.25]:10760 "HELO
	redbull.speedroad.net") by vger.kernel.org with SMTP
	id <S270003AbRHETZ3> convert rfc822-to-8bit; Sun, 5 Aug 2001 15:25:29 -0400
Date: Sun, 05 Aug 2001 21:23:21 +0200
From: Arnvid Karstad <arnvid@karstad.org>
To: linux-kernel@vger.kernel.org
Subject: Problems with 2.4.7-ac6 + SMP + FastTrak100
Message-Id: <20010805210628.B856.ARNVID@karstad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.00.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hiya,

I rebuilt my kernel 2.4.7 after applied Alan Cox patch 6 to get FastTrak
100 support in my kernel. The kernel boots fine up until after it's
freeing memory used by kernel with the following printout..


Freeing unused kernel memory: 236kbytes
Invalid operand: 0000
CPU:0
EIP: 0010:[<c010ca24>]
EFALGS: 00010206
... then all the registers

then
..
Process swapper
...
code: 0f ae 82 90 03 00 00 db c2 eb 08 90 dd b2 90 03 00 00 9b 0f


And then it dies in "idle task something" and freezes.. ;>
(it's a thunder storm here atm, so I will boot to get more info later)

My system is a 

Dual P2 300 Mhz with 192MB ram
Promise FastTrak 100 + 4x IBM ATA 100 75GB disks
Intel EtherPro/100 and an old Mach64CT gfx adapter

Regards

Arnvid

