Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281536AbRKPUR1>; Fri, 16 Nov 2001 15:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281535AbRKPURU>; Fri, 16 Nov 2001 15:17:20 -0500
Received: from flounder.jimking.net ([209.205.176.18]:42503 "EHLO
	flounder.jimking.net") by vger.kernel.org with ESMTP
	id <S281534AbRKPURO>; Fri, 16 Nov 2001 15:17:14 -0500
To: linux-kernel@vger.kernel.org
Subject: Totally Stumped
From: Tony Reed <Tony@TRLJC.COM>
Encrypted: : PGP
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) Emacs/21.1 (i586-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20011116201702.1317C15B48@kubrick.trljc.com>
Date: Fri, 16 Nov 2001 15:17:02 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.0] Won't compile 8139too

[2.0] see [1.]

[3.0] kernel

[4.0] Linux version 2.4.8 (tony@kubrick) (gcc version 2.95.3 20010315
     (release)) #2 Mon Aug 20 17:40:37 EDT 2001
[5.0] NA

[6.0] make[3]: Entering directory
     `/usr/src/linux-2.4.14/linux/drivers/net' gcc -D__KERNEL__
     -I/usr/src/linux-2.4.14/linux/include -Wall -Wstrict-prototypes
     -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing
     -fno-common -pipe -mpreferred-stack-boundary=2 -march=i586 -c -o
     8139too.o 8139too.c


     8139too.c: In function `netdev_ethtool_ioctl': 8139too.c:2432:
     Unrecognizable insn: (insn/i 609 1066 1063 (parallel[ (set
     (reg:SI 6 ebp) (asm_operands:SI ("addl %3,%1 ; sbbl %0,%0; cmpl
     %1,%4; sbbl $0,%0") ("=&r") 0[ (reg/v:SI 1 edx [165]) (mem:SI
     (plus:SI (reg/f:SI 6 ebp) (const_int -352 [0xfffffea0])) 0)
     (mem/s:SI (plus:SI (reg:SI 0 eax [173]) (const_int 12 [0xc])) 0)
                    ] 
                    [ 
                        (asm_input:SI ("1"))
                        (asm_input:SI ("g"))
                        (asm_input:SI ("g"))
                    ]  ("/usr/src/linux-2.4.14/linux/include/asm/uaccess.h") 558))
            (set (reg/v:SI 1 edx [165]) (asm_operands:SI ("addl %3,%1
                ; sbbl %0,%0; cmpl %1,%4; sbbl $0,%0") ("=r") 1[
                (reg/v:SI 1 edx [165]) (mem:SI (plus:SI (reg/f:SI 6
                ebp) (const_int -352 [0xfffffea0])) 0) (mem/s:SI
                (plus:SI (reg:SI 0 eax [173]) (const_int 12 [0xc])) 0)
                    ] 
                    [ 
                        (asm_input:SI ("1"))
                        (asm_input:SI ("g"))
                        (asm_input:SI ("g"))
                    ]  ("/usr/src/linux-2.4.14/linux/include/asm/uaccess.h") 558))
            (clobber (reg:QI 19 dirflag))
            (clobber (reg:QI 18 fpsr))
            (clobber (reg:QI 17 flags))
        ] ) -1 (insn_list 595 (insn_list 602 (nil)))
    (nil)) 8139too.c:2432: Internal compiler error in
    reload_cse_simplify_operands, at reload1.c:8355 Please submit a full
    bug report, with preprocessed source if appropriate.  See
    <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.
    make[3]: *** [8139too.o] Error 1 make[2]: *** [first_rule] Error 2
    make[1]: *** [_subdir_net] Error 2 make: *** [_dir_drivers] Error 2
    make[3]: Leaving directory `/usr/src/linux-2.4.14/linux/drivers/net'
    make[2]: Leaving directory `/usr/src/linux-2.4.14/linux/drivers/net'       
    make[1]: Leaving directory `/usr/src/linux-2.4.14/linux/drivers'

[7.1] 
Gnu C                  3.0.1
Gnu make               3.79.1
binutils               2.9.1.0.24
util-linux             2.10s
mount                  2.9u
modutils               2.4.6
e2fsprogs              1.18
PPP                    2.4.0
Dynamic linker (ldd)   2.1.2
Procps                 2.0.4
Net-tools              1.53
Kbd                    command
Sh-utils               2.0

[7.2]
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 5
model           : 8
model name      : WinChip 2
stepping        : 5
cpu MHz         : 240.552
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr mce cx8 mmx 3dnow centaur_mcr
bogomips        : 480.05
[7.3] NA
[7.4]
cat /proc/ioports

0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : Micron FDC 37C665
  01f0-01f7 : ide0
0290-029f : Classic/Tahiti/Monterey
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : Micron FDC 37C665
  03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cfb : PCI conf2
fc00-fcff : Realtek Semiconductor Co., Ltd. RTL-8139
  fc00-fcff : 8139too

cat /proc/iomem

00000000-0009efff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-03ffffff : System RAM
  00100000-0025de9b : Kernel code
  0025de9c-002d6c37 : Kernel data
10000000-107fffff : S3 Inc. 86c964 [Vision 964 VRAM] vers 0
ffbfff00-ffbfffff : Realtek Semiconductor Co., Ltd. RTL-8139
  ffbfff00-ffbfffff : 8139too

[7.5]

cat /proc/pci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corporation 82434LX [Mercury/Neptune] (rev 17).
      Master Capable.  Latency=64.  
  Bus  0, device   1, function  0:
    IDE interface: Micron FDC 37C665 (rev 1).
      I/O at 0x1f0 [0x1f7].
      I/O at 0x3f6 [0x3f6].
  Bus  0, device   2, function  0:
    Non-VGA unclassified device: Intel Corporation 82378IB [SIO ISA Bridge] (rev 3).
  Bus  0, device   6, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=32.Max Lat=64.
      I/O at 0xfc00 [0xfcff].
      Non-prefetchable 32 bit memory at 0xffbfff00 [0xffbfffff].
  Bus  0, device  14, function  0:
    VGA compatible unclassified device: S3 Inc. 86c964 [Vision 964
      VRAM] vers 0 (rev 0).  Non-prefetchable 32 bit memory at
      0x10000000 [0x107fffff].

[7.6] NA



I haven't been able to build this since 2.4.8


-- 
   Tony Reed 
<Tony@TRLJC.COM>
