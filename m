Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131179AbQLMNOh>; Wed, 13 Dec 2000 08:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131370AbQLMNO1>; Wed, 13 Dec 2000 08:14:27 -0500
Received: from nkmz-ins.ins.dn.ua ([195.184.203.254]:4619 "EHLO nkmz.ins.dn.ua")
	by vger.kernel.org with ESMTP id <S131179AbQLMNOP>;
	Wed, 13 Dec 2000 08:14:15 -0500
Message-ID: <000c01c06501$f9667cf0$0f1b10ac@nkmz.donetsk.ua>
From: "Vladimir Parkhomenko" <vparch@lsto.nkmz.donetsk.ua>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: SCSI SYM53C896 driver, kernel 2.2.17
Date: Wed, 13 Dec 2000 14:41:08 +0200
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0009_01C06512.BBB916E0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2014.211
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2014.211
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit

Good day.

Please help me.
Or tell me about how and where can I get consultation for the problem.
I have small problem with my SCSI driver SYM53C896 on Linux system - kernel
2.2.17.
When I copy huge file (about 1Gb, but < 1.5Gb) from one disk drive to other
is error occured. Perfomance SYM53C896 is very slowly (from 20Mb/s to
4Mb/s), but the connect is being. The system log message and '/proc'
information is attache to this mail.


sorry for my english.

with best regards
Vladimir Parkhomenko
13.12.y2

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="scsi.err"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="scsi.err"

kernel: scsi : aborting command due to timeout : pid 242507, scsi0, =
channel 0, id 1, lun 0 Read (10) 00 00 35 e2 d7 00 00 02 00  =0A=
kernel: sym53c8xx_abort: pid=3D242507 serial_number=3D242534 =
serial_number_at_timeout=3D242534 =0A=
=0A=
kernel: scsi : aborting command due to timeout : pid 242508, scsi0, =
channel 0, id 1, lun 0 Read (10) 00 00 35 e2 d9 00 00 02 00  =0A=
kernel: sym53c8xx_abort: pid=3D242508 serial_number=3D242535 =
serial_number_at_timeout=3D242535 =0A=
kernel: sym53c896-0: abort ccb=3Dac817000 (cancel) =0A=
=0A=
kernel: scsi : aborting command due to timeout : pid 242518, scsi0, =
channel 0, id 1, lun 0 Read (10) 00 00 35 e2 ed 00 00 80 00  =0A=
kernel: sym53c8xx_abort: pid=3D242518 serial_number=3D242545 =
serial_number_at_timeout=3D242545 =0A=
kernel: sym53c896-0: abort ccb=3Dac814800 (cancel) =0A=
=0A=
kernel: SCSI host 0 abort (pid 240519) timed out - resetting =0A=
kernel: SCSI bus is being reset for host 0 channel 0. =0A=
=0A=
kernel: sym53c8xx_reset: pid=3D240519 reset_flags=3D2 =
serial_number=3D240546 serial_number_at_timeout=3D240546 =0A=
kernel: sym53c896-0: restart (scsi reset). =0A=
=0A=
kernel: sym53c896-0: handling phase mismatch from SCRIPTS. =0A=
kernel: sym53c896-0: Downloading SCSI SCRIPTS. =0A=
=0A=
kernel: sym53c896-0-<1,*>: FAST-40 WIDE SCSI 80.0 MB/s (25 ns, offset =
31) =0A=
kernel: sym53c896-0-<0,*>: FAST-40 WIDE SCSI 80.0 MB/s (25 ns, offset =
15) =0A=

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="version"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="version"

Linux version 2.2.17 (root@ml350.nkmz.donetsk.ua) (gcc version =
egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #11 SMP Mon Dec 11 =
16:14:00 EET 2000=0A=

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="filesystems"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="filesystems"

	ext2=0A=
nodev	proc=0A=
nodev	nfs=0A=
nodev	smbfs=0A=
	iso9660=0A=
nodev	autofs=0A=
nodev	devpts=0A=
	vfat=0A=

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="interrupts"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="interrupts"

           CPU0       =0A=
  0:     264614          XT-PIC  timer=0A=
  1:       5870    IO-APIC-edge  keyboard=0A=
  2:          0          XT-PIC  cascade=0A=
  6:         99    IO-APIC-edge  floppy=0A=
  8:          2    IO-APIC-edge  rtc=0A=
 12:          0    IO-APIC-edge  PS/2 Mouse=0A=
 13:          1          XT-PIC  fpu=0A=
 14:         11    IO-APIC-edge  ide0=0A=
 16:    1010752   IO-APIC-level  sym53c8xx, sym53c8xx=0A=
 17:      20292   IO-APIC-level  eth0=0A=
NMI:          0=0A=
ERR:          0=0A=

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="ioports"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ioports"

0000-001f : dma1=0A=
0020-003f : pic1=0A=
0040-005f : timer=0A=
0060-006f : keyboard=0A=
0070-007f : rtc=0A=
0080-008f : dma page reg=0A=
00a0-00bf : pic2=0A=
00c0-00df : dma2=0A=
00f0-00ff : fpu=0A=
01f0-01f7 : ide0=0A=
02f8-02ff : serial(auto)=0A=
03c0-03df : vga+=0A=
03f0-03f5 : floppy=0A=
03f6-03f6 : ide0=0A=
03f7-03f7 : floppy DIR=0A=
03f8-03ff : serial(auto)=0A=
1000-10ff : sym53c8xx=0A=
1400-14ff : sym53c8xx=0A=
2000-201f : Intel Speedo3 Ethernet=0A=
3000-3007 : ide0=0A=
3008-300f : ide1=0A=

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="meminfo"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="meminfo"

        total:    used:    free:  shared: buffers:  cached:=0A=
Mem:  795537408 791658496  3878912  6164480 382468096 386555904=0A=
Swap: 526409728  2535424 523874304=0A=
MemTotal:    776892 kB=0A=
MemFree:       3788 kB=0A=
MemShared:     6020 kB=0A=
Buffers:     373504 kB=0A=
Cached:      377496 kB=0A=
SwapTotal:   514072 kB=0A=
SwapFree:    511596 kB=0A=

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="modules"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="modules"

vfat                    9308   1 (autoclean)=0A=
fat                    31584   1 (autoclean) [vfat]=0A=
nfsd                  143204   8 (autoclean)=0A=

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="mounts"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="mounts"

/dev/root / ext2 rw 0 0=0A=
/proc /proc proc rw 0 0=0A=
none /dev/pts devpts rw 0 0=0A=
/dev/sda5 /u01 ext2 rw 0 0=0A=
/dev/sda6 /u07 ext2 rw 0 0=0A=
/dev/sda7 /u02 ext2 rw 0 0=0A=
/dev/sdb1 /u03 ext2 rw 0 0=0A=
/dev/sdb2 /u05 ext2 rw 0 0=0A=
/dev/sdc6 /u04 ext2 rw 0 0=0A=
/dev/sdc7 /u06 ext2 rw 0 0=0A=
/dev/sda8 /u08 ext2 rw 0 0=0A=
/dev/sdc8 /u09 ext2 rw 0 0=0A=
/dev/fd0 /mnt/floppy vfat rw,noexec,nosuid,nodev 0 0=0A=

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="partitions"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="partitions"

major minor  #blocks  name=0A=
=0A=
   8     0    8886762 sda=0A=
   8     1    1542240 sda1=0A=
   8     2          1 sda2=0A=
   8     3      40131 sda3=0A=
   8     4     514080 sda4=0A=
   8     5    1550241 sda5=0A=
   8     6    1036161 sda6=0A=
   8     7    1550241 sda7=0A=
   8     8    2650693 sda8=0A=
   8    16    8958120 sdb=0A=
   8    17    1036161 sdb1=0A=
   8    18    7920045 sdb2=0A=
   8    32    8958120 sdc=0A=
   8    33    1542240 sdc1=0A=
   8    34          1 sdc2=0A=
   8    35      40131 sdc3=0A=
   8    36     514080 sdc4=0A=
   8    37    1550241 sdc5=0A=
   8    38    1036161 sdc6=0A=
   8    39    1550241 sdc7=0A=
   8    40    2722986 sdc8=0A=

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="stat"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="stat"

cpu  3234 0 15510 256640=0A=
cpu0 3234 0 15510 256640=0A=
disk 69933 915219 26409 0=0A=
disk_rio 4891 915174 976 0=0A=
disk_wio 65042 45 25433 0=0A=
disk_rblk 15548 1830348 3926 0=0A=
disk_wblk 502696 90 203440 0=0A=
page 5444701 1354879=0A=
swap 755 846=0A=
intr 1563582 275384 6214 0 0 0 0 116 249694 2 0 0 0 0 1 11 0 1010852 =
21308 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 =
0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0=0A=
ctxt 672378=0A=
btime 976702980=0A=
processes 605=0A=

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="swaps"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="swaps"

Filename			Type		Size	Used	Priority=0A=
/dev/sda4                       partition	514072	2476	-1=0A=

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="cpuinfo"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cpuinfo"

processor	: 0=0A=
vendor_id	: GenuineIntel=0A=
cpu family	: 6=0A=
model		: 8=0A=
model name	: Pentium III (Coppermine)=0A=
stepping	: 1=0A=
cpu MHz		: 596.039=0A=
cache size	: 256 KB=0A=
fdiv_bug	: no=0A=
hlt_bug		: no=0A=
sep_bug		: no=0A=
f00f_bug	: no=0A=
coma_bug	: no=0A=
fpu		: yes=0A=
fpu_exception	: yes=0A=
cpuid level	: 2=0A=
wp		: yes=0A=
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov =
pat pse36 mmx fxsr xmm=0A=
bogomips	: 1189.48=0A=
=0A=

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="0"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0"

General information:=0A=
  Chip sym53c896, device id 0xb, revision id 0x5=0A=
  IO port address 0x1000, IRQ number 16=0A=
  Using memory mapped IO at virtual address 0xb0800000=0A=
  Synchronous period factor 10, max commands per lun 63=0A=

------=_NextPart_000_0009_01C06512.BBB916E0
Content-Type: application/octet-stream;
	name="1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="1"

General information:=0A=
  Chip sym53c896, device id 0xb, revision id 0x5=0A=
  IO port address 0x1400, IRQ number 16=0A=
  Using memory mapped IO at virtual address 0xb0805000=0A=
  Synchronous period factor 10, max commands per lun 63=0A=

------=_NextPart_000_0009_01C06512.BBB916E0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
