Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132765AbRD2KhO>; Sun, 29 Apr 2001 06:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132947AbRD2KhF>; Sun, 29 Apr 2001 06:37:05 -0400
Received: from front1.grolier.fr ([194.158.96.51]:25812 "EHLO
	front1.grolier.fr") by vger.kernel.org with ESMTP
	id <S132765AbRD2Kg5>; Sun, 29 Apr 2001 06:36:57 -0400
Message-ID: <3AEBEF6F.8070406@freesurf.fr>
Date: Sun, 29 Apr 2001 12:39:43 +0200
From: Kilobug <kilobug@freesurf.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3 i686; en-US; rv:0.8.1+) Gecko/20010426
X-Accept-Language: fr, en, fr-fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: black pixels on X with kernel > 2.4.1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,
   I don't know if it's an X or a linux problem,I'm really sorry if I 
bother you for nothing.

Here is the bug report:
1. black pixels on X with kernel > 2.4.1
2. when I use any kernel > 2.4.1 (I've tried with 2.4.2 and 2.4.4) some 
areas and some pixel on the X server becomes black (or really darker). I 
have a Riva 128 grapical card, with XFree4 and the "nv" driver.This 
appears both with the Framebuffer enabled and disabled
3. graphic X
4. 2.4.2, 2.4.4
5.  None
6. None
7.1 Here is the ver_linux with the 2.4.1 kernel:
Linux asuka 2.4.1 #4 SMP Tue Feb 27 19:09:58 CET 2001 i686 unknown

Gnu C                  2.95.4
Gnu make               3.79.1
binutils               2.11.90.0.5
util-linux             2.11b
mount                  2.11b
modutils               2.4.2
e2fsprogs              1.19
Linux C Library        2.2.2
Dynamic linker (ldd)   2.2.2
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded        

The X server is:
XFree86 Version 4.0.2 / X Window System
(protocol Version 11, revision 0, vendor release 6400)
Release Date: 18 December 2000

All of them are from Debian "unstable"
7.2cat /proc/cpuinfo
processor : 0
vendor_id : AuthenticAMD
cpu family : 6
model : 3
model name : AMD Duron(tm) Processor
stepping : 1
cpu MHz : 699.683
cache size : 64 KB
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 1
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips : 1395.91

7.3 None
7.40000-001f : dma1
0020-003f : pic1
0040-005f : timer0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(set)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
d000-d00f : VIA Technologies, Inc. Bus Master IDE
d400-d41f : VIA Technologies, Inc. UHCI USB
d800-d81f : VIA Technologies, Inc. UHCI USB (#2)
dc00-dcff : VIA Technologies, Inc. AC97 Audio Controller
  dc00-dcff : via82cxxx
e000-e003 : VIA Technologies, Inc. AC97 Audio Controller
e400-e403 : VIA Technologies, Inc. AC97 Audio Controller
ec00-ecff : Realtek Semiconductor Co., Ltd. RTL-8139
  ec00-ecff : eth0

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07feffff : System RAM
  00100000-00244098 : Kernel code
  00244099-002bb67f : Kernel data
07ff0000-07ff2fff : ACPI Non-volatile Storage
07ff3000-07ffffff : ACPI Tables
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d5ffffff : PCI Bus #01
  d4000000-d4ffffff : NVidia / SGS Thomson (Joint Venture) Riva128
   d4000000-d4ffffff : rivafb
d6000000-d6ffffff : PCI Bus #01
  d6000000-d6ffffff : NVidia / SGS Thomson (Joint Venture) Riva128
   d6000000-d6ffffff : rivafb
d8000000-d80000ff : Realtek Semiconductor Co., Ltd. RTL-8139
  d8000000-d80000ff : eth0
ffff0000-ffffffff : reserved

7.5
PCI devices found:
  Bus  0, device   0, function  0:
   Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 2).
     Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
   PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0).
     Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
   ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 
34).
  Bus  0, device   7, function  1:
   IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 16).
     Master Capable.  Latency=32. 
     I/O at 0xd000 [0xd00f].
  Bus  0, device   7, function  2:
   USB Controller: VIA Technologies, Inc. UHCI USB (rev 16).

     IRQ 5.
     Master Capable.  Latency=32. 
     I/O at 0xd400 [0xd41f].
  Bus  0, device   7, function  3:
   USB Controller: VIA Technologies, Inc. UHCI USB (#2) (rev 16).
     IRQ 5.
     Master Capable.  Latency=32. 
     I/O at 0xd800 [0xd81f].
  Bus  0, device   7, function  4:
   Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 
48).
  Bus  0, device   7, function  5:
   Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 32).
     IRQ 11.
     I/O at 0xdc00 [0xdcff].
     I/O at 0xe000 [0xe003].
     I/O at 0xe400 [0xe403].
  Bus  0, device   9, function  0:
   Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
     IRQ 11.
     Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
     I/O at 0xec00 [0xecff].
     Non-prefetchable 32 bit memory at 0xd8000000 [0xd80000ff].
  Bus  1, device   0, function  0:
   VGA compatible controller: NVidia / SGS Thomson (Joint Venture) 
Riva128 (rev 34).
     IRQ 10.
     Master Capable.  Latency=32.  Min Gnt=3.Max Lat=1.
     Non-prefetchable 32 bit memory at 0xd4000000 [0xd4ffffff].
     Prefetchable 32 bit memory at 0xd6000000 [0xd6ffffff].

Thank you for you great work on the kernel and good luck for the future...

--
** Gael Le Mignot, Ing2 EPITA, Coder of The Kilobug Team **
Home Mail : kilobug@freesurf.fr          Work Mail : le-mig_g@epita.fr
GSM       : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959

"Software is like sex it's better when it's free.", Linus Torvalds

