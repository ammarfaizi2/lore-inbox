Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278808AbRK1VBo>; Wed, 28 Nov 2001 16:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280678AbRK1VBf>; Wed, 28 Nov 2001 16:01:35 -0500
Received: from web13905.mail.yahoo.com ([216.136.175.68]:38408 "HELO
	web13905.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S278808AbRK1VBR>; Wed, 28 Nov 2001 16:01:17 -0500
Message-ID: <20011128210116.67766.qmail@web13905.mail.yahoo.com>
Date: Wed, 28 Nov 2001 13:01:16 -0800 (PST)
From: nobody <climb_no_fear@yahoo.com>
Subject: 2.4.16 kernel oops - X-related?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just compiled and fired up 2.4.16 and I've had two
oopses within an hour.  I am new to this (I've never
reported a kernel bug before) but I've never had this
many crashes before.  I am running a dual Celeron (see
below) on Red Hat Linux 7.1 gcc 2.96.  Could these be
X or kde-related?  My AGP video card is listed at the
bottom, should that help. I can include other log
info, if needed.

Thx,
John

Nov 27 23:23:35 hal9000 kernel:  printing eip:
Nov 27 23:23:35 hal9000 kernel: c013749f
Nov 27 23:23:35 hal9000 kernel: *pde = 0c94b067
Nov 27 23:23:35 hal9000 kernel: *pte = 00000000
Nov 27 23:23:35 hal9000 kernel: Oops: 0000
Nov 27 23:23:35 hal9000 kernel: CPU:    0
Nov 27 23:23:35 hal9000 kernel: EIP:   
0010:[fput+15/240]    Not tainted
Nov 27 23:23:35 hal9000 kernel: EIP:   
0010:[<c013749f>]    Not tainted
Nov 27 23:23:35 hal9000 kernel: EFLAGS: 00010282
Nov 27 23:23:35 hal9000 kernel: eax: ca1bf560   ebx:
ca1bf560   ecx: ca2e9ee0   edx: ca2e9ee0
Nov 27 23:23:35 hal9000 kernel: esi: 00000000   edi:
ce871008   ebp: 00000000   esp: cc921f04
Nov 27 23:23:35 hal9000 kernel: ds: 0018   es: 0018  
ss: 0018
Nov 27 23:23:35 hal9000 kernel: Process X (pid: 1089,
stackpage=cc921000)
Nov 27 23:23:35 hal9000 kernel: Stack: 00000000
c01a0789 cc7f2000 cd157640 ce871140 ce871000 ce871008
00000000
Nov 27 23:23:35 hal9000 kernel:        c01440a5
00000001 7fffffff 01000000 c014444e cc921f54 cc921f54
00000304
Nov 27 23:23:36 hal9000 kernel:        cc920000
7fffffff 00000019 00000000 00000000 ce871000 00000008
081d76e0
Nov 27 23:23:36 hal9000 kernel: Call Trace:
[tty_poll+121/144] [poll_freewait+53/80]
[do_select+542/576] [sys_select+825/1152]
[system_call+51/56]
Nov 27 23:23:36 hal9000 kernel: Call Trace:
[<c01a0789>] [<c01440a5>] [<c014444e>] [<c01447d9>]
[<c010712b>]
Nov 27 23:23:36 hal9000 kernel:
Nov 27 23:23:36 hal9000 kernel: Code: 8b 7d 08 f0 ff
4b 14 0f 94 c0 84 c0 0f 84 bc 00 00 00 53 e8
Nov 27 23:23:36 hal9000 kdm[1080]: Server for display
:0 terminated unexpectedly: 2816



Nov 27 23:41:41 hal9000 kernel: Unable to handle
kernel paging request at virtual address f000e2b3
Nov 27 23:41:41 hal9000 kernel:  printing eip:
Nov 27 23:41:41 hal9000 kernel: c01282e5
Nov 27 23:41:41 hal9000 kernel: *pde = 00000000
Nov 27 23:41:41 hal9000 kernel: Oops: 0000
Nov 27 23:41:41 hal9000 kernel: CPU:    1
Nov 27 23:41:41 hal9000 kernel: EIP:   
0010:[find_vma_prepare+37/112]    Not tainted
Nov 27 23:41:41 hal9000 kernel: EIP:   
0010:[<c01282e5>]    Not tainted
Nov 27 23:41:41 hal9000 kernel: EFLAGS: 00010286
Nov 27 23:41:41 hal9000 kernel: eax: f000e2ab   ebx:
c0000000   ecx: f000e2c3   edx: c0000008
Nov 27 23:41:41 hal9000 kernel: esi: 40fcb000   edi:
00000000   ebp: c3d5def8   esp: c3d5dec4
Nov 27 23:41:41 hal9000 kernel: ds: 0018   es: 0018  
ss: 0018
Nov 27 23:41:41 hal9000 kernel: Process kdm (pid:
1085, stackpage=c3d5d000)
Nov 27 23:41:41 hal9000 kernel: Stack: c3d5def8
c3d5defc c3d5df00 cfd35780 c012873a cfd35780 40fcb000
c3d5def8
Nov 27 23:41:41 hal9000 kernel:        c3d5defc
c3d5df00 00000000 00000075 cfd35780 00000000 c902b910
c014a39a
Nov 27 23:41:41 hal9000 kernel:        c902b860
00000001 c012acad c902b860 00001000 00000001 00000000
00000400
Nov 27 23:41:41 hal9000 kernel: Call Trace:
[do_mmap_pgoff+570/1264] [update_atime+74/80]
[do_generic_file_read+1101/1120] [open_namei+790/1344]
[old_mmap+238/304]
Nov 27 23:41:41 hal9000 kernel: Call Trace:
[<c012873a>] [<c014a39a>] [<c012acad>] [<c0140cd6>]
[<c010ca1e>]
Nov 27 23:41:41 hal9000 kernel:    [system_call+51/56]
Nov 27 23:41:41 hal9000 kernel:    [<c010712b>]
Nov 27 23:41:41 hal9000 kernel:
Nov 27 23:41:41 hal9000 kernel: Code: 39 71 f0 76 0c
39 71 ec 89 c7 76 2f 8d 51 0c eb 05 89 cb 8d
Nov 27 23:42:31 hal9000 kdm[1067]: Server for display
:0 terminated unexpectedly: 0

______________________________

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 434.329
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 865.07

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Celeron (Mendocino)
stepping        : 5
cpu MHz         : 434.329
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8
apic sep mtrr pge mca cmov
pat pse36 mmx fxsr
bogomips        : 868.35
______________________________
VGA compatible controller: ATI Technologies Inc Rage
128 RF (rev 0).
      Master Capable.  Latency=32.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xd0000000
[0xd3ffffff].
      I/O at 0x9000 [0x90ff].
      Non-prefetchable 32 bit memory at 0xd5000000 [0xd5003fff].

__________________________________________________
Do You Yahoo!?
Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
