Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVERJcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVERJcb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 05:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVERJca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 05:32:30 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:50632 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S262141AbVERJcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 05:32:05 -0400
Subject: PROBLEM: ICH6M not recognised as being AHCI capable (libata)
From: Erik Slagter <erik@slagter.name>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 May 2005 11:31:10 +0200
Message-Id: <1116408671.3505.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. ICH6M not recognised as being AHCI capable (libata)

2. During startup, libata refuses to talk to the ICH6 using AHCI, I get
these messages: 

libata version 1.10 loaded.
ahci version 1.00
ACPI: PCI Interrupt 0000:00:1f.2[B] -> GSI 17 (level, low) -> IRQ 201
ahci: probe of 0000:00:1f.2 failed with error -12
ata_piix version 1.03

[-12 == ENOMEM???]

3. libata ich6m ahci

4. Linux version 2.6.12-rc1-bk5 (erik@skylla) (gcc version 4.0.0
20050505 (Red Hat 4.0.0-4)) #12 Tue May 17 15:17:44 CEST 2005

5. No oops

6. init 6 ;-)

7.1.================================================================
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux skylla 2.6.12-rc1-bk5 #12 Tue May 17 15:17:44 CEST 2005 i686 i686
i386 GNU /Linux

Gnu C                  4.0.0
Gnu make               3.80
binutils               2.15.94.0.2.2
util-linux             2.12p
mount                  2.12p
module-init-tools      2.4.26
e2fsprogs              1.37
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.8
quota-tools            3.12.
nfs-utils              1.0.7
Linux C Library        x  2 root root 1489284 May  4
22:26 /lib/libc.so.6
Dynamic linker (ldd)   2.3.5
Procps                 3.2.5
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
udev                   057
Modules Loaded         psmouse autofs4 sunrpc af_packet binfmt_misc
usb_storage evdev usbhid i8k ohci1394 ieee1394 uhci_hcd ehci_hcd
snd_pcm_oss snd_mixer_oss s nd_intel8x0 snd_ac97_codec snd_pcm snd_timer
snd soundcore snd_page_alloc usbcor e
====================================================================
7.2. ===============================================================
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 2.13GHz
stepping        : 8
cpu MHz         : 798.210
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx est tm2
bogomips        : 1572.86
=====================================================================
7.3. see 7.1
7.4.=================================================================
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : libata
01f0-01f7 : libata
03c0-03df : vga+
1000-1005 : motherboard
  1000-1003 : PM1a_EVT_BLK
  1004-1005 : PM1a_CNT_BLK
1006-1007 : motherboard
1008-100f : motherboard
  1008-100b : PM_TMR
1020-1020 : PM2_CNT_BLK
1028-102f : GPE0_BLK
1060-107f : motherboard
1080-10bf : motherboard
10c0-10df : 0000:00:1f.3
  10c0-10df : motherboard
10e0-10ff : motherboard
  10e0-10e5 : ACPI CPU throttle
4000-40ff : PCI CardBus #04
4400-44ff : PCI CardBus #04
bf20-bf3f : 0000:00:1d.3
  bf20-bf3f : uhci_hcd
bf40-bf5f : 0000:00:1d.2
  bf40-bf5f : uhci_hcd
bf60-bf7f : 0000:00:1d.1
  bf60-bf7f : uhci_hcd
bf80-bf9f : 0000:00:1d.0
  bf80-bf9f : uhci_hcd
bfa0-bfaf : 0000:00:1f.2
  bfa0-bfaf : libata
d000-dfff : PCI Bus #01
  de00-deff : 0000:01:00.0
ec40-ec7f : 0000:00:1e.2
  ec40-ec7f : Intel ICH6
ec80-ecff : 0000:00:1e.3
ed00-edff : 0000:00:1e.2
  ed00-edff : Intel ICH6
ee00-eeff : 0000:00:1e.3
f400-f4fe : motherboard

00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffd9fff : System RAM
  00100000-002e1509 : Kernel code
  002e150a-003db6bf : Kernel data
3ffda000-3fffffff : reserved
40000000-40000fff : 0000:03:01.0
  40000000-40000fff : yenta_socket
40400000-407fffff : PCI CardBus #04
40800000-40bfffff : PCI CardBus #04
d0000000-d7ffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
dfcfc700-dfcfc7ff : 0000:03:01.2
dfcfc800-dfcfcfff : 0000:03:01.1
  dfcfc800-dfcfcfff : ohci1394
dfcfd000-dfcfdfff : 0000:03:03.0
dfcfe000-dfcfffff : 0000:03:00.0
  dfcfe000-dfcfffff : b44
dfd00000-dfefffff : PCI Bus #01
  dfdf0000-dfdfffff : 0000:01:00.0
dffffd00-dffffdff : 0000:00:1e.2
  dffffd00-dffffdff : Intel ICH6
dffffe00-dfffffff : 0000:00:1e.2
  dffffe00-dfffffff : Intel ICH6
e0000000-f0006fff : reserved
f0008000-f000bfff : reserved
fec00000-fec0ffff : reserved
fed20000-fee0ffff : reserved
ffa80800-ffa80bff : 0000:00:1d.7
  ffa80800-ffa80bff : ehci_hcd
ffb00000-ffffffff : reserved

7.5.============================================================
$ lspci (I'll add lspci -vv on request)
00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML
Express Processor to DRAM Controller (rev 03)
00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI
Express Root Port (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 03)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3)
00:1e.2 Multimedia audio controller: Intel Corporation
82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
AC'97 Modem Controller (rev 03)
00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface
Bridge (rev 03)
00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA
Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
SMBus Controller (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc M22 [Radeon
Mobility M300]
03:00.0 Ethernet controller: Broadcom Corporation BCM4401-B0 100Base-TX
(rev 02)
03:01.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b3)
03:01.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller
(rev 08)
03:01.2 Class 0805: Ricoh Co Ltd SD Card reader (rev 17)
03:03.0 Network controller: Intel Corporation PRO/Wireless 2915ABG
MiniPCI Adapter (rev 05)
====================================================================

7.6. ===============================================================
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: FUJITSU MHT2080A Rev: 006C
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: SONY     Model: DVD+-RW DW-D56A  Rev: PDS3
  Type:   CD-ROM                           ANSI SCSI revision: 05
====================================================================

7.7. Dell Inspiron 9300, Pentium M, ICH6(M), Fujitsu SATA harddisk, SONY
ATAPI DVD+R/W. Note that the BIOS setup screen does not offer an option to
switch between legacy IDE mode and AHCI mode.

