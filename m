Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313062AbSDCFl0>; Wed, 3 Apr 2002 00:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313063AbSDCFlR>; Wed, 3 Apr 2002 00:41:17 -0500
Received: from [65.119.4.9] ([65.119.4.9]:20195 "EHLO
	superglide.netfx-2000.net") by vger.kernel.org with ESMTP
	id <S313062AbSDCFlE>; Wed, 3 Apr 2002 00:41:04 -0500
Date: Tue, 2 Apr 2002 21:41:03 -0800
Message-Id: <200204030541.g335f3a21868@superglide.netfx-2000.net>
From: "Aryojan -" <aryojan@linuxfreemail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel BUG at slab.c <- Thanks for your support
X-Mailer: Linux Free Mail 2.0
X-IPAddress: 200.80.30.90
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mar  1 01:57:43 gnet kernel: kernel BUG at slab.c:1248!
Mar  1 01:57:43 gnet kernel: invalid operand: 0000
Mar  1 01:57:43 gnet kernel: CPU:    0
Mar  1 01:57:43 gnet kernel: EIP:    0010:[<c0129133>]    Tainted: P 
Mar  1 01:57:43 gnet kernel: EFLAGS: 00210082
Mar  1 01:57:43 gnet kernel: eax: 0000001b   ebx: c0c03658   ecx: c02ac880   edx: 0000169b
Mar  1 01:57:43 gnet kernel: esi: c12031d0   edi: c0c0369b   ebp: c0c0369b   esp: c16ade1c
Mar  1 01:57:43 gnet kernel: ds: 0018   es: 0018   ss: 0018
Mar  1 01:57:43 gnet kernel: Process kdeinit (pid: 396, stackpage=c16ad000)
Mar  1 01:57:43 gnet kernel: Stack: c025beca 000004e0 00000000 c1203500 000001f0 000001f0 00000040 00200246
Mar  1 01:57:43 gnet kernel:        c0128d07 c12031d0 000001f0 c1203500 c1203508 000001f0 00000000 c0208816
Mar  1 01:57:43 gnet kernel:        00000200 c1a59e00 c1203510 00000008 00000001 c1a58000 c012935c c1203500 
Mar  1 01:57:43 gnet kernel: Call Trace: [<c0128d07>] [<c0208816>] [<c012935c>] [<c0208c0a>] [<c0208160>]
Mar  1 01:57:43 gnet kernel:    [<c02082cc>] [<c02416d0>] [<c0205cd9>] [<c0205f1e>] [<c012ffc6>] [<c0106c6b>] 
Mar  1 01:57:43 gnet kernel:
Mar  1 01:57:43 gnet kernel: Code: 0f 0b 83 c4 08 ba a5 c2 0f 17 89 d8 03 46 18 87 50 fc 81 fa
Mar  1 01:58:06 gnet kernel:  <6>NVRM: AGPGART: freed 16 pages
Mar  1 01:58:06 gnet kernel: NVRM: AGPGART: backend released

gnet:/# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
gcc version 2.95.4 20011006 (Debian prerelease)


processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 1
model name      : AMD-K7(tm) Processor
stepping        : 2
cpu MHz         : 601.080
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat mmx syscall mmxext 3dnowext 3dnow
bogomips        : 1199.30

ppp_deflate            40064   0 (autoclean)
bsd_comp                4160   0 (autoclean)
ppp_async               6592   1 (autoclean)
ppp_generic            18600   3 (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    4960   0 (autoclean) [ppp_generic]
NVdriver              945504  10 (autoclean)
vfat                    9788   1 (autoclean)
fat                    30872   0 (autoclean) [vfat]
aic7xxx               125440   0 (unused)
scsi_mod               56892   1 [aic7xxx]
8139too                14656   1
mii                     1424   0 [8139too]
via82cxxx_audio        18688   2
ac97_codec              9792   0 [via82cxxx_audio]
uart401                 6432   0 [via82cxxx_audio]
sound                  57804   0 [via82cxxx_audio uart401]
soundcore               4004   5 [via82cxxx_audio sound]




Get your own FREE E-mail address at http://www.linuxfreemail.com
Linux FREE Mail is 100% FREE, 100% Linux, 100% better, and 100% yours!


