Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292837AbSCSVTM>; Tue, 19 Mar 2002 16:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292841AbSCSVTD>; Tue, 19 Mar 2002 16:19:03 -0500
Received: from mx.debryansk.ru ([193.124.26.65]:51722 "EHLO
	tower.tts.debryansk.ru") by vger.kernel.org with ESMTP
	id <S292837AbSCSVS4>; Tue, 19 Mar 2002 16:18:56 -0500
Message-Id: <200203192118.g2JLIku25969@tower.tts.debryansk.ru>
Content-Type: text/plain;
  charset="koi8-r"
From: =?koi8-r?b?98nUwczJyg==?= <ka@beep.ru>
Reply-To: ka@beep.ru
To: linux-kernel@vger.kernel.org
Subject: bug
Date: Wed, 20 Mar 2002 00:20:28 +0300
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(i'm not subscribed to linux kernel mail list)
System dying while watching video from cdrom.
When I installed kernel 2.4.18, anytime i was watching video from cdrom
system was dying in 10-15 minits and hdd led was on
(normally hdd led do not light while reading from cdrom).
There is no such problem in 2.4.17.

Chipset VIA Apollo pro 133 (VT82C693A and VT82C686A)
Cdrom Mitsumi FX810T4

/proc/version
Linux version 2.4.18 (agri@agri) (gcc version 3.0.4) #3 Птн Мар 15 22:43:10 
MSK
 2002

ver_linux output:
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux agri 2.4.18 #3 Птн Мар 15 22:43:10 MSK 2002 i686 unknown

Gnu C                  3.0.4
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.10q
mount                  2.10q
modutils               2.4.1
e2fsprogs              1.19
PPP                    2.4.0
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Linux C++ Library      3.0.4
Procps                 2.0.7
Net-tools              1.57
Kbd                    1.02
Sh-utils               2.0
Modules Loaded         rtc serial isa-pnp isofs cdrom

/proc/cpuinfo:
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Celeron (Mendocino)
stepping	: 0
cpu MHz		: 487.515
cache size	: 128 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 
mmx
 fxsr
bogomips	: 973.20

/proc/modules:
isofs                  16720   0 (unused)
cdrom                  27840   0 (unused)
rtc                     5760   0 (autoclean)
serial                 45680   0 (autoclean) (unused)
isa-pnp                29168   0 (autoclean) [serial]

/proc/ioports:
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
01f0-01f7 : ide0
0213-0213 : isapnp read
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5000-500f : PCI device 1106:3057
6000-607f : PCI device 1106:3057
e000-e00f : PCI device 1106:0571
  e000-e007 : ide0
  e008-e00f : ide1
e400-e41f : PCI device 1106:3038
e800-e81f : PCI device 1106:3038
ec00-ec07 : PCI device 12b9:1008
  ec00-ec07 : serial(auto)

/proc/iomem:
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-001d4bc4 : Kernel code
  001d4bc5-002038bf : Kernel data
d0000000-d7ffffff : PCI Bus #01
  d0000000-d3ffffff : PCI device 5333:8a13
d8000000-d83fffff : PCI device 1106:0691
ffff0000-ffffffff : reserved

hdparm /dev/hdd (cdrom):

 HDIO_GET_MULTCOUNT failed: Invalid argument
 HDIO_GET_NOWERR failed: Invalid argument
 HDIO_GETGEO failed: Invalid argument

/dev/hdd:
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  1 (on)
 readahead    =  8 (on)


hdparm /dev/hda:

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  1 (32-bit)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 2490/255/63, sectors = 40011300, start = 0
