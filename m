Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264623AbTFELvb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 07:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264624AbTFELvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 07:51:31 -0400
Received: from adsl-66-72-183-162.dsl.sfldmi.ameritech.net ([66.72.183.162]:13440
	"EHLO kaeding.homelinux.net") by vger.kernel.org with ESMTP
	id S264623AbTFELvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 07:51:24 -0400
Date: Thu, 5 Jun 2003 08:04:53 -0400 (EDT)
From: Thomas Kaeding <kaeding@kaeding.homelinux.org>
X-X-Sender: kaeding@kaeding.localdomain
To: linux-kernel@vger.kernel.org
Subject: more info for last message (bug at page_alloc.c:102)
Message-ID: <Pine.LNX.4.44.0306050801200.854-100000@kaeding.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is more info that you might need.  The problem occurred overnight.
In the morning, the mouse worked until I tried to start an app
in KDE, then everything froze.  Ctl-alt-bkspc gave only a black screen.
I had to hit restart.

Thanks again.

Thomas

Linux kaeding 2.4.20 #7 Thu Apr 10 15:11:01 EDT 2003 i686 unknown unknown
GNU/Linux

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11n
mount                  2.11n
modutils               2.4.12
e2fsprogs              1.27
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         ppp_synctty ppp_async 3c59x lirc_i2c lirc_dev
NVdriver em8300 bt865 adv717x cmpci btaudio tvmixer es1371 ac97_codec
gameport tvaudio bttv msp3400 tuner i2c-algo-bit soundcore w83781d
i2c-proc i2c-dev i2c-i801 i2c-core p4b_smbus usb-uhci usbcore nls_cp437

kaeding kaeding > more /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 1
model name      : Intel(R) Celeron(R) CPU 1.70GHz
stepping        : 3
cpu MHz         : 1716.940
cache size      : 8 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3420.97

kaeding kaeding > more /proc/modules
ppp_synctty             4960   0 (unused)
ppp_async               6464   1
3c59x                  25128   1
lirc_i2c                2596   1
lirc_dev                7648   1 [lirc_i2c]
NVdriver             1065216  10
em8300                 43748   0
bt865                   2816   0 (unused)
adv717x                 2944   0 (unused)
cmpci                  30064   0
btaudio                10144   0
tvmixer                 3680   1
es1371                 26752   1
ac97_codec             10048   0 [es1371]
gameport                1484   0 [es1371]
tvaudio                11136   1 (autoclean)
bttv                   69184   3
msp3400                14384   1 (autoclean)
tuner                   8644   1 (autoclean)
i2c-algo-bit            8396   3 [em8300 bttv]
soundcore               3492  13 [em8300 cmpci btaudio tvmixer es1371
bttv]
w83781d                19424   0 (unused)
i2c-proc                6624   0 [w83781d]
i2c-dev                 4032   0 (unused)
i2c-i801                4676   0 (unused)
i2c-core               15144   0 [lirc_i2c bt865 adv717x tvmixer tvaudio
bttv ms
p3400 tuner i2c-algo-bit w83781d i2c-proc i2c-dev i2c-i801]
p4b_smbus               1852   0 (unused)
usb-uhci               21220   0 (unused)
usbcore                55296   1 [usb-uhci]
nls_cp437               4384   1

kaeding kaeding > more /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0ffebfff : System RAM
  00100000-00278c7a : Kernel code
  00278c7b-00311117 : Kernel data
0ffec000-0ffeefff : ACPI Tables
0ffef000-0fffefff : reserved
0ffff000-0fffffff : ACPI Non-volatile Storage
10000000-100003ff : Intel Corp. 82801DB ICH4 IDE
f6000000-f60fffff : Sigma Designs, Inc. REALmagic Hollywood Plus DVD
Decoder
f6800000-f68003ff : Intel Corp. 82801DB USB EHCI Controller
f7000000-f86fffff : PCI Bus #01
  f7000000-f7ffffff : nVidia Corporation NV5 [Riva TnT2]
f8800000-f8800fff : Brooktree Corporation Bt878 Audio Capture
  f8800000-f8800fff : btaudio
f9000000-f9000fff : Brooktree Corporation Bt878 Video Capture
  f9000000-f9000fff : bttv
f9f00000-fbffffff : PCI Bus #01
  fa000000-fbffffff : nVidia Corporation NV5 [Riva TnT2]
fc000000-fdffffff : Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

kaeding kaeding > more /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0330-0331 : cmpci Midi
0376-0376 : ide1
0378-037a : parport0
0388-038b : cmpci FM
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
a800-a807 : US Robotics/3Com 56K FaxModem Model 5610
  a800-a807 : serial(set)
b000-b03f : 3Com Corporation 3c905 100BaseTX [Boomerang]
  b000-b03f : 02:0d.0
b400-b43f : Ensoniq ES1371 [AudioPCI-97]
  b400-b43f : es1371
b800-b8ff : C-Media Electronics Inc CM8738
  b800-b8ff : cmpci
d000-d01f : Intel Corp. 82801DB USB (Hub #3)
  d000-d01f : usb-uhci
d400-d41f : Intel Corp. 82801DB USB (Hub #2)
  d400-d41f : usb-uhci
d800-d81f : Intel Corp. 82801DB USB (Hub #1)
  d800-d81f : usb-uhci
e800-e80f : i801-smbus
f000-f00f : Intel Corp. 82801DB ICH4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

kaeding kaeding > more /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge
(rev 17).
      Prefetchable 32 bit memory at 0xfc000000 [0xfdffffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev
17).
      Master Capable.  Latency=64.  Min Gnt=8.
  Bus  0, device  29, function  0:
    USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 1).
      IRQ 11.
      I/O at 0xd800 [0xd81f].
  Bus  0, device  29, function  1:
    USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 1).
      IRQ 4.
      I/O at 0xd400 [0xd41f].
  Bus  0, device  29, function  2:
    USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 1).
      IRQ 10.
      I/O at 0xd000 [0xd01f].
  Bus  0, device  29, function  7:
    USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 1).
      IRQ 9.
      Non-prefetchable 32 bit memory at 0xf6800000 [0xf68003ff].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 129).
      Master Capable.  No bursts.  Min Gnt=6.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 1).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 1).
      IRQ 10.
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0x0 [0x7].
      I/O at 0x0 [0x3].
      I/O at 0xf000 [0xf00f].
      Non-prefetchable 32 bit memory at 0x10000000 [0x100003ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: nVidia Corporation NV5 [Riva TnT2] (rev
17).
      IRQ 11.
      Master Capable.  Latency=248.  Min Gnt=5.Max Lat=1.
      Non-prefetchable 32 bit memory at 0xf7000000 [0xf7ffffff].
      Prefetchable 32 bit memory at 0xfa000000 [0xfbffffff].
  Bus  2, device   3, function  0:
    Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 16).
      IRQ 3.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=24.
      I/O at 0xb800 [0xb8ff].
  Bus  2, device   9, function  0:
    Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood Plus
DVD Deco
der (rev 2).
      IRQ 3.
      Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0xf6000000 [0xf60fffff].
  Bus  2, device  10, function  0:
    Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 2).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=12.Max Lat=128.
      I/O at 0xb400 [0xb43f].
  Bus  2, device  11, function  0:
    Multimedia video controller: Brooktree Corporation Bt878 Video Capture
(rev
2).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=16.Max Lat=40.
      Prefetchable 32 bit memory at 0xf9000000 [0xf9000fff].
  Bus  2, device  11, function  1:
    Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev
2).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=4.Max Lat=255.
      Prefetchable 32 bit memory at 0xf8800000 [0xf8800fff].
  Bus  2, device  13, function  0:
    Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang] (rev
0).
      IRQ 3.
      Master Capable.  Latency=32.  Min Gnt=3.Max Lat=8.
      I/O at 0xb000 [0xb03f].
  Bus  2, device  14, function  0:
    Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 1).
      IRQ 10.
      I/O at 0xa800 [0xa807].
  Bus  0, device  31, function  3:
    SMBus: PCI device 8086:24c3 (rev 1).
      I/O at 0xe800 [0xe81f].

kaeding kaeding > more /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: CREATIVE Model: DVD-ROM DVD6240E Rev: 0101
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210A Rev: 1.02
  Type:   CD-ROM                           ANSI SCSI revision: 02

Jun  4 22:28:02 kaeding kernel: NVRM: AGPGART: freed 128 pages
Jun  4 22:28:02 kaeding kernel: NVRM: AGPGART: freed 257 pages
Jun  4 22:28:04 kaeding kernel: NVRM: AGPGART: freed 16 pages
Jun  4 22:28:04 kaeding kernel: NVRM: AGPGART: backend released
Jun  4 22:28:22 kaeding sudo:  kaeding : TTY=tty1 ; PWD=/home/kaeding ;
USER=root ; COMMAND=/usr/bin/fam
Jun  4 22:37:32 kaeding kernel: kernel BUG at page_alloc.c:102!
Jun  4 22:37:32 kaeding kernel: invalid operand: 0000
Jun  4 22:37:32 kaeding kernel: CPU:    0
Jun  4 22:37:32 kaeding kernel: EIP:    0010:[__free_pages_ok+68/652]
Tainted: P
Jun  4 22:37:32 kaeding kernel: EFLAGS: 00010282
Jun  4 22:37:32 kaeding kernel: eax: c119fd80   ebx: c12b8fb4   ecx:
c12b8fd0   edx: c02d421c
Jun  4 22:37:32 kaeding kernel: esi: 00000000   edi: 00000008   ebp:
000001f4   esp: c12eff14
Jun  4 22:37:32 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 22:37:32 kaeding kernel: Process kswapd (pid: 4,
stackpage=c12ef000)
Jun  4 22:37:32 kaeding kernel: Stack: cd1166c0 c12b8fb4 00000008 000001f4
c013372c c12b8fb4 000001d0 00000008
Jun  4 22:37:32 kaeding kernel:        000001f4 c0131c8c cd1166c0 c12b8fb4
c01299f2 c012aa03 c0129a2b 00000020
Jun  4 22:37:32 kaeding kernel:        000001d0 00000020 00000006 00000006
c12ee000 00001f63 000001d0 c02d43b4
Jun  4 22:37:32 kaeding kernel: Call Trace:
[try_to_free_buffers+144/228] [try_to_release_page+68/72]
[shrink_cache+490/764] [__free_pages+27/28] [shrink_cache+547/764]
Jun  4 22:37:32 kaeding kernel:   [shrink_caches+88/136]
[try_to_free_pages_zone+60/92] [kswapd_balance_pgdat+65/140]
[kswapd_balance+26/48] [kswapd+153/188] [kernel_thread+40/56]
Jun  4 22:37:32 kaeding kernel:
Jun  4 22:37:32 kaeding kernel: Code: 0f 0b 66 00 53 02 28 c0 89 d8 2b 05
90 f0 33 c0 69 c0 a3 8b
Jun  4 22:37:33 kaeding kernel:  kernel BUG at page_alloc.c:102!
Jun  4 22:37:33 kaeding kernel: invalid operand: 0000
Jun  4 22:37:33 kaeding kernel: CPU:    0
Jun  4 22:37:33 kaeding kernel: EIP:    0010:[__free_pages_ok+68/652]
Tainted: P
Jun  4 22:37:33 kaeding kernel: EFLAGS: 00010282
Jun  4 22:37:33 kaeding kernel: eax: c1272ed8   ebx: c1148c00   ecx:
c1148c1c   edx: c02d421c
Jun  4 22:37:33 kaeding kernel: esi: 00000000   edi: 00000020   ebp:
00000200   esp: c5f51e10
Jun  4 22:37:33 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 22:37:33 kaeding kernel: Process gtk-gnutella (pid: 28819,
stackpage=c5f51000)
Jun  4 22:37:33 kaeding kernel: Stack: cd116780 c1148c00 00000020 00000200
c013372c c1148c00 000001d2 00000020
Jun  4 22:37:33 kaeding kernel:        00000200 c0131c8c cd116780 c1148c00
c01299f2 c012aa03 c0129a2b 00000020
Jun  4 22:37:33 kaeding kernel:        000001d2 00000020 00000006 00000006
c5f50000 00001fde 000001d2 c02d43b4
Jun  4 22:37:33 kaeding kernel: Call Trace:
[try_to_free_buffers+144/228] [try_to_release_page+68/72]
[shrink_cache+490/764] [__free_pages+27/28] [shrink_cache+547/764]
Jun  4 22:37:33 kaeding kernel:   [shrink_caches+88/136]
[try_to_free_pages_zone+60/92] [balance_classzone+80/456]
[__alloc_pages+274/352] [ext3_get_block+0/100] [_alloc_pages+22/24]
Jun  4 22:37:33 kaeding kernel:   [page_cache_read+110/188]
[generic_file_readahead+261/316] [do_generic_file_read+422/1028]
[generic_file_read+124/272] [file_read_actor+0/140] [sys_read+143/232]
Jun  4 22:37:33 kaeding kernel:   [system_call+51/56]
Jun  4 22:37:33 kaeding kernel:
Jun  4 22:37:33 kaeding kernel: Code: 0f 0b 66 00 53 02 28 c0 89 d8 2b 05
90 f0 33 c0 69 c0 a3 8b
Jun  4 22:43:56 kaeding kernel:  kernel BUG at page_alloc.c:102!
Jun  4 22:43:56 kaeding kernel: invalid operand: 0000
Jun  4 22:43:56 kaeding kernel: CPU:    0
Jun  4 22:43:56 kaeding kernel: EIP:    0010:[__free_pages_ok+68/652]
Tainted: P
Jun  4 22:43:56 kaeding kernel: EFLAGS: 00010282
Jun  4 22:43:56 kaeding kernel: eax: c11b115c   ebx: c1130974   ecx:
c1130990   edx: c02d421c
Jun  4 22:43:56 kaeding kernel: esi: 00000000   edi: 00000020   ebp:
00000200   esp: cfec5e10
Jun  4 22:43:56 kaeding kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 22:43:56 kaeding kernel: Process streamcast.pl (pid: 14515,
stackpage=cfec5000)
Jun  4 22:43:56 kaeding kernel: Stack: cd1167e0 c1130974 00000020 00000200
c013372c c1130974 000001d2 00000020
Jun  4 22:43:56 kaeding kernel:        00000200 c0131c8c cd1167e0 c1130974
c01299f2 c012aa03 c0129a2b 00000020
Jun  4 22:43:56 kaeding kernel:        000001d2 00000020 00000006 00000006
cfec4000 00001fd5 000001d2 c02d43b4
Jun  4 22:43:56 kaeding kernel: Call Trace:
[try_to_free_buffers+144/228] [try_to_release_page+68/72]
[shrink_cache+490/764] [__free_pages+27/28] [shrink_cache+547/764]
Jun  4 22:43:56 kaeding kernel:   [shrink_caches+88/136]
[try_to_free_pages_zone+60/92] [balance_classzone+80/456]
[__alloc_pages+274/352] [ext3_get_block+0/100] [_alloc_pages+22/24]
Jun  4 22:43:56 kaeding kernel:   [page_cache_read+110/188]
[generic_file_readahead+261/316] [do_generic_file_read+422/1028]
[generic_file_read+124/272] [file_read_actor+0/140] [sys_read+143/232]
Jun  4 22:43:56 kaeding kernel:   [system_call+51/56]
Jun  4 22:43:56 kaeding kernel:
Jun  4 22:43:56 kaeding kernel: Code: 0f 0b 66 00 53 02 28 c0 89 d8 2b 05
90 f0 33 c0 69 c0 a3 8b
Jun  5 07:41:48 kaeding syslogd 1.4.1: restart.

---------------------------end







