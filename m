Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318601AbSHLC0b>; Sun, 11 Aug 2002 22:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318602AbSHLC0b>; Sun, 11 Aug 2002 22:26:31 -0400
Received: from morannon.wetafx.co.nz ([203.98.17.18]:25757 "EHLO
	morannon.wetafx.co.nz") by vger.kernel.org with ESMTP
	id <S318601AbSHLC0a>; Sun, 11 Aug 2002 22:26:30 -0400
Subject: Linux Kernel Crash - Vanilla 2.4.18/Redhat 2.4.18-5
From: Aaron Caskey <filburt@wetafx.co.nz>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-AvhFMD5E0fE9siaUn7Y8"
X-Mailer: Evolution/1.0.2 
Date: 12 Aug 2002 14:30:16 +1200
Message-Id: <1029119416.4054.104.camel@filibert>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AvhFMD5E0fE9siaUn7Y8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

We are having oops crashes on a lot of our renderwall machines running 
2.4.18 with SGI's xfs 1.0.1 patch (although xfs support is disabled) and
redhat 2.4.18-5 (our current production Kernel) with a system call
reporting patch (I'm not sure on the name or version).

I've included 2 oops crash logs from the vanilla 2.4.18 kernel, we get
identical crashes on the RedHat kernels. I have to hand copy these
because it kills the machine dead, when I catch a dead redhat machine
I'll email the oops dump from that too.

The machines hardware is as follows:
2 2.2Ghz Xeon Processors
4G registered ECC DDR RAM
Tyan e7500 Motherboard
AMI Bios Rev 1.01

ide HDD with ext3 filesystem

Any help would be appreciated greatly.
Thank You.

-- 
Kind Regards

Aaron Caskey
Wrender Wrangler
-----------------
 /---------------------------------------------------------------\
 |Cubeless academia = armageddon and a barren Earth for children.|
 \---\ /---------------------------------------------------------/
     /
 |\_/|    
 |o o|__  
 --*--__\ 
 C_C_(___)

--=-AvhFMD5E0fE9siaUn7Y8
Content-Disposition: inline; filename=crashdump
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

CPU:    0
EIP:    0010:[<00010202>]   Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: d48fbc10   ecx: c02e7f28   edx: 00000001
esi: 00010202   edi: 00000000   ebp: 00000000   esp: f71f3d64
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 12, stackpage=3Df71f3000)
Stack: f88f1953 d48fbc10 d48fbc10 f88f18d0 c01222b7 d48fbc10 00000000 00000=
001
       00000000 00000000 c011e3fb c02e8320 c011e2bc 00000000 00000001 c02c1=
500
       fffffffe 00000000 c011e03b c02c1500 00000046 0000000e c02bd9c0 00000=
00e
Call Trace: [<f88f1953>] [<f88f18d0>] [<c01222b7>] [<c011e3fb>] [<c011e2bc>=
]
   [<c011e03b>] [<c0108d1f>] [<c011659a>] [<c013c076>] [<f881095d>] [<f880f=
b78>]


   [<f88127b6>] [<f8812660>] [<c0105876>] [<f8812680>]


Code:  Bad EIP value.
 <0>Kernel panic: Aiee, killing interupt handler!
In interrupt handler - not syncing


---------------------------------------------------------------------------=
-------


CPU:    0
EIP:    0010:[<e57d6940>]   Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: cfc05bc0   ecx: c02e7f28   edx: 00000001
esi: e57d6940   edi: 00000000   ebp: 00000000   esp: f7ff9ef4
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 3, stackpage=3Df7ff9000)
Stack: f890f953 cfc05bc0 cfc05bc0 f890f8d0 c01222b7 cfc05bc0 00000000 00000=
001
       00000000 00000000 c011e3fb c02e8320 c011e2bc 00000000 00000007 c02c1=
500
       fffffff8 00000000 c011e03b c02c1500 00000046 0000000e c02bd9c0 00000=
00e
Call Trace: [<f890f953>] [<f890f8d0>] [<c01222b7>] [<c011e3fb>] [<c011e2bc>=
]
   [<c011e03b>] [<c0108d1f>] [<c0116743>] [<c011e5bf>] [<c0105876>] [<c011e=
500>]



Code:  c0 42 55 d2 98 e6 ef f5 00 e2 ef f5 00 00 47 f7 01 00 00 00=20
 <0>Kernel panic: Aiee, killing interupt handler!
In interrupt handler - not syncing


--=-AvhFMD5E0fE9siaUn7Y8--

