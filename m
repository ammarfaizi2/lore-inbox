Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318391AbSGRVos>; Thu, 18 Jul 2002 17:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318392AbSGRVos>; Thu, 18 Jul 2002 17:44:48 -0400
Received: from chello213047142196.15.vie.surfer.at ([213.47.142.196]:5504 "EHLO
	aragorn.lain.at") by vger.kernel.org with ESMTP id <S318391AbSGRVor>;
	Thu, 18 Jul 2002 17:44:47 -0400
Date: Thu, 18 Jul 2002 23:48:59 +0200
From: Wolfgang <w.morandell@netway.at>
To: linux-kernel@vger.kernel.org
Subject: kernel panic with linux-2.4.19-rc2-ac1
Message-ID: <20020718214856.GA962@aragorn.groundzero.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

I have switched from linux-2.4.19-rc1-ac7 to linux-2.4.19-rc2-ac1 (both
with preemptive patch). I use the same config but now thw kernel won't
start and spits out the following. If someone could point out where the
error is, I would be most grateful.

Please Cc me.

    Wolfgang


ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Unable to handle kernel NULL pointer dereference at virtual address
00000000
printing eip:
 c020726d
*pde = 00000000
Oops: 0002
CPU: 0
EIP: 0010:[<c020726d>] Not tainted
EFLAGS: 00010212
eax: 00000000 ebx: 00000000 ecx: 00000000 edx: 00000000
esi: cbfede00 edi: 00000000 ebp: 00000000 esp: cbfebeb4
ds: 0018 es: 0018 ss: 0018
Process swapper (pid:1, stackpage=cbfeb000)
Stack: cbf08000 cbf08200 c0206bc4 00000000 00000000 00002200
       00000400 c0208d86
       cbfebefc cbffa520 c12766c0 ffffffff c039d118 c039d24c
       cbf31160 c039cfa0
       c0206984 c02e8d85 c039d2b5 000001f0 000001f7 000003f6
       0000000e c039d2b5
Call Trace: [<c0206bc4>] [<c0206984>] [<c0105600>] [<c0206ff6>]
            [<c0105000>] [<c02071cd>] [<c0105083>] [<c0105000>]
            [<c010745e>] [<c0105060>]
Code: f3 ab e9 9c ff ff ff c1 e9 02 89 d7 f3 ab aa e9 8f ff ff ff
<0>Kernel panic: Attempted to kill init!

