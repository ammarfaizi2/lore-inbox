Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136455AbRD3Gem>; Mon, 30 Apr 2001 02:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136456AbRD3Gec>; Mon, 30 Apr 2001 02:34:32 -0400
Received: from anduin.net ([62.180.76.74]:17636 "HELO anduin.net")
	by vger.kernel.org with SMTP id <S136455AbRD3GeM>;
	Mon, 30 Apr 2001 02:34:12 -0400
From: "Eirik Overby" <ltning@anduin.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Mon, 30 Apr 2001 08:34:35 +0100 (CET)
Reply-To: "Eirik Overby" <ltning@anduin.net>
X-Mailer: PMMail 2.20.2200 for OS/2 Warp 4.05
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: 2.4.x SMP ssues on 440LX (?)
Message-Id: <20010430063418Z136455-409+1422@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

argls.. forgot the panic message :) 
Here goes..

invalid operand: 0000
CPU: 0
EIP: 0010:[<c010c630>]
EFLAGS: 00010206
eax: 0183fbff ebx: cba52000 ecx: c02d0000 edx: cba52000
esi: c02d0000 edi: c02d0350 edp: 00000000 esp: c02d1f74
ds: 0018 es:0018  ss:0018
Process swapper (pid: 0, stackpage=c02d1000)
Stack:  c010581d cba52000 c0305800 cba52350 cba52000 cbd87a40 00000000
cba53e1c
  c0110e66 c02d1fd4 00000001 cdb87a40 c01051b0 cba52000 c02d0000 00000001
  c02d0000 00000030 00000000 c02d0000 c0309440 c01051b0 c02d0000 c02d0000
Call Trace:[<c010581d>] [<c0110e66>] [<c01051b0>] [<c01051b0>]
           [<c01051b0>] [<c010526e>] [<c0105000>] [<c01001cf>]
Code: 0f ae 82 90 03 00 00 db e2 eb 0c 90 8d 74 26 00 dd b2 90 03
Kernel panic: Attempted to kill the idle task!
In idle task - not syncing


-Eirik

