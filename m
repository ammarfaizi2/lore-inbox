Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289374AbSBKNkE>; Mon, 11 Feb 2002 08:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289363AbSBKNjy>; Mon, 11 Feb 2002 08:39:54 -0500
Received: from ATNSMTP91.24on.cc ([213.225.2.184]:48650 "EHLO
	atnsmtp91.24on.cc") by vger.kernel.org with ESMTP
	id <S289321AbSBKNjl>; Mon, 11 Feb 2002 08:39:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: "sHANT)I(" <shanti@mojo.cc>
Organization: MOJO.cc
Message-Id: <200202111438.15602@@kosh.mojo.cc>
To: alan@lxorguk.ukuu.org.uk
Subject: kernel panic - bug or Hardware ? 
Date: Mon, 11 Feb 2002 14:39:27 +0100
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
VIRTUE: ||||| ... for this will do good YYYYY
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

i run a quad-cpu netserver (64MB parityRAM , 2x onboard Adaptec aic7870 SCSI adapter) under  Debian potato with 2.2.x kernel
without any problem , but had to compile 2.4.17 for getting my Promise-Fastrack66-controller to work .. and since i run on 2.4 i 
get strange kernel panic (totally random in time and action) with always the same trace.
For i really have no idea on kernel debugging, i hope that i am right listed here to find help

i also attached the relevant ksyms-enties 

-snip-------------------------
Feb  5 06:25:26 paladin kernel: Unable to handle kernel NULL pointer dereference at virtual address 000000ff
Feb  5 06:25:26 paladin kernel:  printing eip:
Feb  5 06:25:26 paladin kernel: 000000ff
Feb  5 06:25:26 paladin kernel: *pde = 00000000
Feb  5 06:25:26 paladin kernel: Oops: 0000
Feb  5 06:25:26 paladin kernel: CPU:    1
Feb  5 06:25:26 paladin kernel: EIP:    0010:[<000000ff>]    Not tainted
Feb  5 06:25:26 paladin kernel: EFLAGS: 00010002
Feb  5 06:25:26 paladin kernel: eax: c1145e78   ebx: c0129de0   ecx: 000000ff   edx: 00000000
Feb  5 06:25:26 paladin kernel: esi: c01053c0   edi: ffffe000   ebp: 00000000   esp: c1131f6c
Feb  5 06:25:26 paladin kernel: ds: 0018   es: 0018   ss: 0018
Feb  5 06:25:26 paladin kernel: Process swapper (pid: 0, stackpage=c1131000)
Feb  5 06:25:26 paladin kernel: Stack: c0110174 00000000 c1130000 c010b74a c1130000 c1130000 c1130000 c01053c0 
Feb  5 06:25:26 paladin kernel:        ffffe000 00000000 00000000 00000018 00000018 fffffffb c01053ec 00000010 
Feb  5 06:25:26 paladin kernel:        00000246 c0105452 00000000 0000721c 00000000 c0368a26 00000282 00000a98 
Feb  5 06:25:26 paladin kernel: Call Trace: [<c0110174>] [<c010b74a>] [<c01053c0>] [<c01053ec>] [<c0105452>] 
Feb  5 06:25:26 paladin kernel:    [<c0115a6e>] 
Feb  5 06:25:26 paladin kernel: 
Feb  5 06:25:26 paladin kernel: Code:  Bad EIP value.
Feb  5 06:25:26 paladin kernel:  <0>Kernel panic: Attempted to kill the idle task!
-----------------snap-----------------


ksyms:
=======
00000000 A agp_frontend_cleanup
c01053c0 t default_idle
c01053f4 t poll_idle
c0105414 T cpu_idl
c0110154 t clear_IO_APIC
c01154e4 T sys_init_module
c0115ad4 T try_inc_mod_count


i am really sure that this could be a hardware problem , but i cant trace the malfunc. hardware or identify it .. 
i also ran a comlete memtest on the RAM without result .. 

thanks 4 help

-c-

-- 

vaja con dios !

                    sHANT)I(-    service with a sm)le
