Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSEYSPw>; Sat, 25 May 2002 14:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315202AbSEYSPu>; Sat, 25 May 2002 14:15:50 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:20109 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S315198AbSEYSPr>; Sat, 25 May 2002 14:15:47 -0400
Message-ID: <3CEFD385.5060001@linuxhq.com>
Date: Sat, 25 May 2002 14:10:13 -0400
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: HFS Compile Problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1] HFS Compile Error

[2] Bug report:
inode.c: In function `hfs_prepare_write':
inode.c:242: dereferencing pointer to incomplete type
make[2]: *** [inode.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.18/fs/hfs'
make[1]: *** [_subdir_hfs] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.18/fs'
make: *** [_dir_fs] Error 2

[3] Keywords: Filesystem, HFS

[4] Linux version 2.5.18

[5] N/A

[6] N/A

[7] System Information:

[7.1] Linux boolean 2.5.18 #3 Tue May 21 03:03:18 EDT 2002 i686 unknown

Gnu C                  gcc (GCC) 3.1 (Red Hat Linux Rawhide 3.1-1) 
Copyright (C) 2002 Free Software Foundation, Inc. This is free software; 
see the source for copying conditions. There is NO warranty; not even 
for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
Gnu make               3.79.1
util-linux             2.11f
mount                  2.11g
modutils               2.4.14
e2fsprogs              1.23
pcmcia-cs              3.1.31
Linux C Library        2.2.90
Dynamic linker (ldd)   2.2.90
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0.11
Modules Loaded

[7.2]
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 1
cpu MHz         : 448.347
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 894.56

[7.3] No Modules

[7.4]
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0100-013f : orinoco_cs
01f0-01f7 : ide0
02f8-02ff : Lucent Microelectronics 56k WinModem
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1c00-1cff : Lucent Microelectronics 56k WinModem
4000-40ff : PCI CardBus #14
4400-44ff : PCI CardBus #14
4800-48ff : PCI CardBus #15
4c00-4cff : PCI CardBus #15
fe00-fe3f : Intel Corp. 82371AB PIIX4 ACPI
fe60-fe7f : Intel Corp. 82371AB PIIX4 ACPI
fefc-feff : Yamaha Corporation YMF-744B [DS-1S Audio Controller]
ff00-ff3f : Yamaha Corporation YMF-744B [DS-1S Audio Controller]
ff60-ff7f : Toshiba America Info Systems FIR Port Type-DO
ff80-ff9f : Intel Corp. 82371AB PIIX4 USB
fff0-ffff : Intel Corp. 82371AB PIIX4 IDE
fff0-fff7 : ide0
fff8-ffff : ide1

[7.5]
  00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host 
bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge 
(rev 03)
00:05.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:05.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:05.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:05.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
00:07.0 Communication controller: Lucent Microelectronics 56k WinModem 
(rev 01)
00:09.0 IRDA controller: Toshiba America Info Systems FIR Port Type-DO
00:0b.0 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to 
Cardbus Bridge with ZV Support (rev 20)
00:0b.1 CardBus bridge: Toshiba America Info Systems ToPIC95 PCI to 
Cardbus Bridge with ZV Support (rev 20)
00:0c.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S 
Audio Controller] (rev 02)
01:00.0 VGA compatible controller: S3 Inc. 86C270-294 Savage/MX-/IX (rev 11)

  -o)  J o h n   W e b e r
  /\\ john.weber@linuxhq.com
_\/v http://www.linuxhq.com/people/weber/

