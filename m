Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132813AbRDUShx>; Sat, 21 Apr 2001 14:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132822AbRDUSho>; Sat, 21 Apr 2001 14:37:44 -0400
Received: from huizehofstee.xs4all.nl ([194.109.241.183]:42759 "EHLO
	server.hofstee") by vger.kernel.org with ESMTP id <S132813AbRDUShj>;
	Sat, 21 Apr 2001 14:37:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Victor Julien <v.p.p.julien@let.rug.nl>
Organization: Huize Hofstee
To: linux-kernel@vger.kernel.org
Subject: 2.4.3+ sound distortion
Date: Sat, 21 Apr 2001 18:04:47 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01042118044700.01268@victor>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've never posted here before, so if i do anything wrong, just let me know.

I have a problem with kernels higher than 2.4.2, the sound distorts when 
playing a song with xmms while the seti@home client runs. 2.4.2 did not have 
this problem. I tried 2.4.3, 2.4.4-pre5 and 2.4.3-ac11. They al showed the 
same problem.

This is my hardware:
AMD Duron 600@800 (6x133)
MSI K7T Turbo-R
320MB PC133
ASUS v6800 Geforce 1 DDR
Creative PCI128

victor@victor:~$ gcc -v
Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.3/specs
gcc version 2.95.3 20010219 (prerelease)

victor@victor:~$ cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Duron(tm) Processor
stepping        : 0
cpu MHz         : 796.830
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov 
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1589.24

victor@victor:~$ cat /proc/pci     
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 3).
      Prefetchable 32 bit memory at 0xc0000000 [0xcfffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.  
      I/O at 0xc000 [0xc00f].
  Bus  0, device   7, function  4:
    Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 64).
  Bus  0, device  10, function  0:
    Ethernet controller: Winbond Electronics Corp W89C940 (rev 11).
      IRQ 10.
      I/O at 0xcc00 [0xcc1f].
  Bus  0, device  13, function  0:
    Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 6).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0xd000 [0xd03f].
  Bus  0, device  15, function  0:
    RAID bus controller: Promise Technology, Inc. 20265 (rev 2).
      IRQ 11.
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd407].
      I/O at 0xd800 [0xd803].
      I/O at 0xdc00 [0xdc07].
      I/O at 0xe000 [0xe003].
      I/O at 0xe400 [0xe43f].
      Non-prefetchable 32 bit memory at 0xdb000000 [0xdb01ffff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation GeForce 256 DDR (rev 16).
      IRQ 9.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xd8000000 [0xd8ffffff].
      Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].

If i need to suply more information please let me know. If you respond please 
put my emailadres in the CC, i am not a member of this mailing-list.

Victor Julien
