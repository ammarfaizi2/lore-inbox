Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLTSYF>; Wed, 20 Dec 2000 13:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129828AbQLTSX4>; Wed, 20 Dec 2000 13:23:56 -0500
Received: from ddsl.net ([202.9.145.10]:16145 "EHLO eth.net")
	by vger.kernel.org with ESMTP id <S129340AbQLTSXr>;
	Wed, 20 Dec 2000 13:23:47 -0500
Message-ID: <002801c06aae$5c2a3e60$3fa509ca@madan>
Reply-To: "Madan A S" <madanas@ieee.org>
From: "Madan A S" <madanas@eth.net>
To: <linux-kernel@vger.kernel.org>
Subject: sm56 modem driver installation help
Date: Wed, 20 Dec 2000 23:27:37 +0530
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0025_01C06ADC.70621780"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0025_01C06ADC.70621780
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

IMP:please reply me my mail address and not to the vger.kernel.org
I used the follwing to setup the modem driver from motorola, after
installing rpm thru Kpackage
----------------------------------------
depmod -a
ln -sf /dev/ttyEo /dev/modem
mknod /dev/motomem c 28 0

The query in kppp says, "Sorry,the didn't respond" . I see sm56.o in
/2.2.14/misc directory and clearly can see the package in Kpackage .....
Please help me in making my SM56PCI imternal modem work...

Regards,
Madan A S


These are the files after setup

file:conf.modules
------------------
alias char-major-24 sm56
options sm56 country=3D1
alias sound cmpci

file:/proc/devices
-------------------
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  7 vcs
 10 misc
 14 sound
 29 fb
 36 netlink
128 ptm
136 pts
162 raw
Block devices:
  1 ramdisk
  2 fd
  3 ide0
  9 md
 22 ide1

file:/proc/modules
-------------------
lockd                  31176   1 (autoclean)
sunrpc                 52964   1 (autoclean) [lockd]
ppp                    20236   0 (autoclean) (unused)
slhc                    4504   0 (autoclean) [ppp]
nls_iso8859-1           2240   3 (autoclean)
nls_cp437               3748   3 (autoclean)
vfat                    9372   3 (autoclean)
fat                    30720   3 (autoclean) [vfat]
cmpci                  20060   0
soundcore               2596   4 [cmpci]

file:/var/log/messages
------------------------
Dec 20 14:35:51 localhost syslogd 1.3-3: restart.
Dec 20 14:35:51 localhost syslog: syslogd startup succeeded
Dec 20 14:35:51 localhost syslog: klogd startup succeeded
Dec 20 14:35:51 localhost kernel: klogd 1.3-3, log source =3D /proc/kmsg
started.
Dec 20 14:35:51 localhost kernel: Inspecting /boot/System.map-2.2.14-12
Dec 20 14:35:51 localhost kernel: Loaded 7330 symbols from
/boot/System.map-2.2.14-12.
Dec 20 14:35:51 localhost kernel: Symbols match kernel version 2.2.14.
Dec 20 14:35:51 localhost kernel: Loaded 187 symbols from 10 modules.
Dec 20 14:35:51 localhost kernel: Linux version 2.2.14-12
(root@porky.devel.redhat.com) (gcc version egcs-2.91.66 19990314/Linux
(egcs-1.1.2 release)) #1 Tue Apr 25 13:04:07 EDT 2000
Dec 20 14:35:51 localhost kernel: Detected 400906147 Hz processor.
Dec 20 14:35:51 localhost kernel: Console: colour VGA+ 80x25
Dec 20 14:35:51 localhost kernel: Calibrating delay loop... 399.77 =
BogoMIPS
Dec 20 14:35:51 localhost kernel: Memory: 22356k/24512k available (1068k
kernel code, 412k reserved, 612k data, 64k init, 0k bigmem)
Dec 20 14:35:51 localhost kernel: Dentry hash table entries: 262144 =
(order
9, 2048k)
Dec 20 14:35:51 localhost kernel: Buffer cache hash table entries: 32768
(order 5, 128k)
Dec 20 14:35:51 localhost kernel: Page cache hash table entries: 8192 =
(order
3, 32k)
Dec 20 14:35:51 localhost kernel: VFS: Diskquotas version dquot_6.4.0
initialized
Dec 20 14:35:51 localhost kernel: CPU: Intel Celeron (Mendocino) =
stepping 05
Dec 20 14:35:51 localhost kernel: Checking 386/387 coupling... OK, FPU =
using
exception 16 error reporting.
Dec 20 14:35:51 localhost kernel: Checking 'hlt' instruction... OK.
Dec 20 14:35:51 localhost kernel: POSIX conformance testing by UNIFIX
Dec 20 14:35:51 localhost kernel: mtrr: v1.35a (19990819) Richard Gooch
(rgooch@atnf.csiro.au)
Dec 20 14:35:51 localhost kernel: PCI: PCI BIOS revision 2.10 entry at
0xfb300
Dec 20 14:35:51 localhost kernel: PCI: Using configuration type 1
Dec 20 14:35:51 localhost kernel: PCI: Probing PCI hardware
Dec 20 14:35:51 localhost kernel: Linux NET4.0 for Linux 2.2
Dec 20 14:35:51 localhost kernel: Based upon Swansea University Computer
Society NET3.039
Dec 20 14:35:51 localhost kernel: NET4: Unix domain sockets 1.0 for =
Linux
NET4.0.
Dec 20 14:35:51 localhost kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Dec 20 14:35:51 localhost kernel: IP Protocols: ICMP, UDP, TCP, IGMP
Dec 20 14:35:51 localhost kernel: TCP: Hash tables configured (ehash =
32768
bhash 32768)
Dec 20 14:35:51 localhost kernel: Initializing RT netlink socket
Dec 20 14:35:51 localhost kernel: Starting kswapd v 1.5
Dec 20 14:35:51 localhost kernel: Detected PS/2 Mouse Port.
Dec 20 14:35:51 localhost kernel: Serial driver version 4.27 with =
MANY_PORTS
MULTIPORT SHARE_IRQ enabled
Dec 20 14:35:51 localhost kernel: ttyS00 at 0x03f8 (irq =3D 4) is a =
16550A
Dec 20 14:35:51 localhost kernel: ttyS01 at 0x02f8 (irq =3D 3) is a =
16550A
Dec 20 14:35:51 localhost kernel: pty: 256 Unix98 ptys configured
Dec 20 14:35:51 localhost kernel: apm: BIOS version 1.2 Flags 0x07 =
(Driver
version 1.9)
Dec 20 14:35:51 localhost kernel: Real Time Clock Driver v1.09
Dec 20 14:35:51 localhost kernel: RAM disk driver initialized:  16 RAM =
disks
of 4096K size
Dec 20 14:35:51 localhost kernel: SIS5513: IDE controller on PCI bus 00 =
dev
01
Dec 20 14:35:51 localhost kernel: SIS5513: not 100% native mode: will =
probe
irqs later
Dec 20 14:35:51 localhost kernel:     ide0: BM-DMA at 0x4000-0x4007, =
BIOS
settings: hda:DMA, hdb:DMA
Dec 20 14:35:51 localhost kernel:     ide1: BM-DMA at 0x4008-0x400f, =
BIOS
settings: hdc:DMA, hdd:DMA
Dec 20 14:35:51 localhost kernel: hda: ST36421A, ATA DISK drive
Dec 20 14:35:51 localhost kernel: hdd: Philips 40X PCA403CD, ATAPI CDROM
drive
Dec 20 14:35:51 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Dec 20 14:35:51 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Dec 20 14:35:51 localhost kernel: hda: ST36421A, 6150MB w/256kB Cache,
CHS=3D784/255/63
Dec 20 14:35:51 localhost kernel: hdd: ATAPI 48X CD-ROM drive, 128kB =
Cache
Dec 20 14:35:51 localhost kernel: Uniform CDROM driver Revision: 2.56
Dec 20 14:35:51 localhost kernel: Floppy drive(s): fd0 is 1.44M
Dec 20 14:35:51 localhost kernel: FDC 0 is a post-1991 82077
Dec 20 14:35:51 localhost kernel: md driver 0.90.0 MAX_MD_DEVS=3D256,
MAX_REAL=3D12
Dec 20 14:35:51 localhost kernel: raid5: measuring checksumming speed
Dec 20 14:35:51 localhost kernel: raid5: MMX detected, trying high-speed =
MMX
checksum routines
Dec 20 14:35:51 localhost kernel:    pII_mmx   :   891.540 MB/sec
Dec 20 14:35:51 localhost kernel:    p5_mmx    :   936.498 MB/sec
Dec 20 14:35:51 localhost kernel:    8regs     :   688.467 MB/sec
Dec 20 14:35:51 localhost kernel:    32regs    :   385.953 MB/sec
Dec 20 14:35:51 localhost kernel: using fastest function: p5_mmx =
(936.498
MB/sec)
Dec 20 14:35:51 localhost kernel: scsi : 0 hosts.
Dec 20 14:35:51 localhost kernel: scsi : detected total.
Dec 20 14:35:51 localhost kernel: md.c: sizeof(mdp_super_t) =3D 4096
Dec 20 14:35:51 localhost kernel: Partition check:
Dec 20 14:35:51 localhost kernel:  hda: hda1 hda2 < hda5 hda6 > hda3 =
hda4
Dec 20 14:35:51 localhost kernel: autodetecting RAID arrays
Dec 20 14:35:51 localhost kernel: autorun ...
Dec 20 14:35:51 localhost kernel: ... autorun DONE.
Dec 20 14:35:51 localhost kernel: VFS: Mounted root (ext2 filesystem)
readonly.
Dec 20 14:35:51 localhost kernel: Freeing unused kernel memory: 64k =
freed
Dec 20 14:35:51 localhost kernel: Adding Swap: 64252k swap-space
(priority -1)
Dec 20 14:35:51 localhost kernel: cm: version v1.1 time 13:05:42 Apr 25 =
2000
Dec 20 14:35:51 localhost kernel: cm: found CM8738 adapter at io 0xe000 =
irq
10
Dec 20 14:35:51 localhost kernel: CSLIP: code copyright 1989 Regents of =
the
University of California
Dec 20 14:35:51 localhost kernel: PPP: version 2.3.7 (demand dialling)
Dec 20 14:35:51 localhost kernel: PPP line discipline registered.
Dec 20 14:35:52 localhost identd: identd startup succeeded
Dec 20 14:35:34 localhost rc.sysinit: Mounting proc filesystem succeeded
Dec 20 14:35:34 localhost sysctl: net.ipv4.ip_forward =3D 0
Dec 20 14:35:34 localhost sysctl: net.ipv4.conf.all.rp_filter =3D 1
Dec 20 14:35:34 localhost sysctl: net.ipv4.ip_always_defrag =3D 0
Dec 20 14:35:34 localhost sysctl: kernel.sysrq =3D 0
Dec 20 14:35:34 localhost rc.sysinit: Configuring kernel parameters
succeeded
Dec 20 14:35:34 localhost date: Wed Dec 20 14:35:33 IST 2000
Dec 20 14:35:34 localhost rc.sysinit: Setting clock : Wed Dec 20 =
14:35:33
IST 2000 succeeded
Dec 20 14:35:34 localhost rc.sysinit: Loading default keymap succeeded
Dec 20 14:35:34 localhost rc.sysinit: Activating swap partitions =
succeeded
Dec 20 14:35:34 localhost rc.sysinit: Setting hostname Pina succeeded
Dec 20 14:35:34 localhost fsck: /dev/hda4: clean, 66947/173888 files,
238767/347405 blocks
Dec 20 14:35:34 localhost rc.sysinit: Checking root filesystem succeeded
Dec 20 14:35:34 localhost rc.sysinit: Remounting root filesystem in
read-write mode succeeded
Dec 20 14:35:39 localhost rc.sysinit: Finding module dependencies =
succeeded
Dec 20 14:35:40 localhost rc.sysinit: Loading sound module (cmpci) =
succeeded
Dec 20 14:35:40 localhost aumix-minimal: vol set to 64, 64
Dec 20 14:35:40 localhost rc.sysinit: Loading mixer settings succeeded
Dec 20 14:35:40 localhost aumix-minimal: synth set to 64, 64, R
Dec 20 14:35:40 localhost aumix-minimal: pcm set to 100, 100
Dec 20 14:35:40 localhost aumix-minimal: line set to 64, 64, R
Dec 20 14:35:40 localhost aumix-minimal: mic set to 64, 64, R
Dec 20 14:35:40 localhost aumix-minimal: cd set to 64, 64, R
Dec 20 14:35:40 localhost rc.sysinit: Checking filesystems succeeded
Dec 20 14:35:40 localhost rc.sysinit: Mounting local filesystems =
succeeded
Dec 20 14:35:40 localhost rc.sysinit: Turning on user and group quotas =
for
local filesystems succeeded
Dec 20 14:35:41 localhost rc.sysinit: Enabling swap space succeeded
Dec 20 14:35:41 localhost init: Entering runlevel: 5
Dec 20 14:35:48 localhost kudzu:  succeeded
Dec 20 14:35:48 localhost sysctl: net.ipv4.ip_forward =3D 0
Dec 20 14:35:48 localhost sysctl: net.ipv4.conf.all.rp_filter =3D 1
Dec 20 14:35:48 localhost sysctl: net.ipv4.ip_always_defrag =3D 0
Dec 20 14:35:48 localhost sysctl: kernel.sysrq =3D 0
Dec 20 14:35:48 localhost network: Setting network parameters succeeded
Dec 20 14:35:49 localhost network: Bringing up interface lo succeeded
Dec 20 14:35:49 localhost portmap: portmap startup succeeded
Dec 20 14:35:50 localhost nfslock: rpc.lockd startup succeeded
Dec 20 14:35:50 localhost nfslock: rpc.statd startup succeeded
Dec 20 14:35:50 localhost apmd: apmd startup succeeded
Dec 20 14:35:50 localhost apmd[305]: Version 3.0final (APM BIOS 1.2, =
Linux
driver 1.9)
Dec 20 14:35:50 localhost random: Initializing random number generator
succeeded
Dec 20 14:35:50 localhost netfs: Mounting other filesystems succeeded
Dec 20 14:35:52 localhost atd: atd startup succeeded
Dec 20 14:35:53 localhost crond: crond startup succeeded
Dec 20 14:35:53 localhost rc: Starting pcmcia succeeded
Dec 20 14:35:53 localhost inet: inetd startup succeeded
Dec 20 14:35:54 localhost inetd[429]: auth/tcp: bind: Address already in =
use
Dec 20 14:35:54 localhost lpd: lpd startup succeeded
Dec 20 14:35:54 localhost lpd[443]: restarted
Dec 20 14:35:54 localhost keytable: Loading keymap:
Dec 20 14:35:54 localhost keytable: Loading
/usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz
Dec 20 14:35:54 localhost keytable: Loading system font:
Dec 20 14:35:55 localhost rc: Starting keytable succeeded
Dec 20 14:35:57 localhost sendmail: sendmail startup succeeded
Dec 20 14:35:57 localhost gpm: gpm startup succeeded
Dec 20 14:35:58 localhost xfs: xfs startup succeeded
Dec 20 14:35:58 localhost xfs: Warning: The directory
"/usr/X11R6/lib/X11/fonts/100dpi" does not exist.
Dec 20 14:35:58 localhost xfs:          Entry deleted from font path.
Dec 20 14:35:59 localhost linuxconf: Linuxconf final setup
Dec 20 14:36:00 localhost rc: Starting linuxconf succeeded
Dec 20 14:36:14 localhost PAM_pwdb[591]: authentication failure; =
(uid=3D0) ->
root for gdm service
Dec 20 14:36:15 localhost gdm[591]: Couldn't authenticate root
Dec 20 14:36:22 localhost PAM_pwdb[591]: (gdm) session opened for user =
root
by (uid=3D0)
Dec 20 14:36:22 localhost gdm[591]: gdm_slave_session_start: root on :0
Dec 20 14:43:06 localhost modprobe: modprobe: Can't locate module
char-major-28
Dec 20 14:43:29 localhost modprobe: modprobe: Can't locate module
char-major-24
Dec 20 14:45:54 localhost inetd[429]: auth/tcp: bind: Address already in =
use
Dec 20 14:47:45 localhost PAM_pwdb[591]: (gdm) session closed for user =
root
Dec 20 14:48:00 localhost PAM_pwdb[789]: (gdm) session opened for user =
root
by (uid=3D0)
Dec 20 14:48:00 localhost gdm[789]: gdm_slave_session_start: root on :0
Dec 20 14:55:54 localhost inetd[429]: auth/tcp: bind: Address already in =
use
Dec 20 15:05:54 localhost inetd[429]: auth/tcp: bind: Address already in =
use
Dec 20 15:14:26 localhost PAM_pwdb[789]: (gdm) session closed for user =
root
Dec 20 15:14:48 localhost PAM_pwdb[577]: (login) session opened for user
root by LOGIN(uid=3D0)
Dec 20 15:15:54 localhost inetd[429]: auth/tcp: bind: Address already in =
use





------=_NextPart_000_0025_01C06ADC.70621780
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" =
http-equiv=3DContent-Type>
<META content=3D"MSHTML 5.00.2614.3500" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>IMP:please reply me my mail address and =
not to the=20
vger.kernel.org</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I used the follwing to setup the modem =
driver from=20
motorola, after<BR>installing rpm thru=20
Kpackage<BR>----------------------------------------<BR>depmod -a<BR>ln =
-sf=20
/dev/ttyEo /dev/modem<BR>mknod /dev/motomem c 28 0<BR><BR>The query in =
kppp=20
says, "Sorry,the didn't respond" . I see sm56.o in<BR>/2.2.14/misc =
directory and=20
clearly can see the package in Kpackage .....<BR>Please help me in =
making my=20
SM56PCI imternal modem work...<BR><BR>Regards,<BR>Madan A =
S<BR><BR><BR>These are=20
the files after =
setup<BR><BR>file:conf.modules<BR>------------------<BR>alias=20
char-major-24 sm56<BR>options sm56 country=3D1<BR>alias sound=20
cmpci<BR><BR>file:/proc/devices<BR>-------------------<BR>Character=20
devices:<BR>&nbsp; 1 mem<BR>&nbsp; 2 pty<BR>&nbsp; 3 ttyp<BR>&nbsp; 4=20
ttyS<BR>&nbsp; 5 cua<BR>&nbsp; 7 vcs<BR>&nbsp;10 misc<BR>&nbsp;14=20
sound<BR>&nbsp;29 fb<BR>&nbsp;36 netlink<BR>128 ptm<BR>136 pts<BR>162=20
raw<BR>Block devices:<BR>&nbsp; 1 ramdisk<BR>&nbsp; 2 fd<BR>&nbsp; 3=20
ide0<BR>&nbsp; 9 md<BR>&nbsp;22=20
ide1<BR><BR>file:/proc/modules<BR>-------------------<BR>lockd&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=20
31176&nbsp;&nbsp; 1=20
(autoclean)<BR>sunrpc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
52964&nbsp;&nbsp; 1 (autoclean)=20
[lockd]<BR>ppp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
20236&nbsp;&nbsp; 0 (autoclean)=20
(unused)<BR>slhc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
4504&nbsp;&nbsp; 0 (autoclean)=20
[ppp]<BR>nls_iso8859-1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;=20
2240&nbsp;&nbsp; 3=20
(autoclean)<BR>nls_cp437&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
3748&nbsp;&nbsp; 3=20
(autoclean)<BR>vfat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
9372&nbsp;&nbsp; 3=20
(autoclean)<BR>fat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
30720&nbsp;&nbsp; 3 (autoclean)=20
[vfat]<BR>cmpci&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
20060&nbsp;&nbsp;=20
0<BR>soundcore&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;=20
2596&nbsp;&nbsp; 4=20
[cmpci]<BR><BR>file:/var/log/messages<BR>------------------------<BR>Dec =
20=20
14:35:51 localhost syslogd 1.3-3: restart.<BR>Dec 20 14:35:51 localhost =
syslog:=20
syslogd startup succeeded<BR>Dec 20 14:35:51 localhost syslog: klogd =
startup=20
succeeded<BR>Dec 20 14:35:51 localhost kernel: klogd 1.3-3, log source =
=3D=20
/proc/kmsg<BR>started.<BR>Dec 20 14:35:51 localhost kernel: Inspecting=20
/boot/System.map-2.2.14-12<BR>Dec 20 14:35:51 localhost kernel: Loaded =
7330=20
symbols from<BR>/boot/System.map-2.2.14-12.<BR>Dec 20 14:35:51 localhost =
kernel:=20
Symbols match kernel version 2.2.14.<BR>Dec 20 14:35:51 localhost =
kernel: Loaded=20
187 symbols from 10 modules.<BR>Dec 20 14:35:51 localhost kernel: Linux =
version=20
2.2.14-12<BR>(<A=20
href=3D"mailto:root@porky.devel.redhat.com">root@porky.devel.redhat.com</=
A>) (gcc=20
version egcs-2.91.66 19990314/Linux<BR>(egcs-1.1.2 release)) #1 Tue Apr =
25=20
13:04:07 EDT 2000<BR>Dec 20 14:35:51 localhost kernel: Detected =
400906147 Hz=20
processor.<BR>Dec 20 14:35:51 localhost kernel: Console: colour VGA+=20
80x25<BR>Dec 20 14:35:51 localhost kernel: Calibrating delay loop... =
399.77=20
BogoMIPS<BR>Dec 20 14:35:51 localhost kernel: Memory: 22356k/24512k =
available=20
(1068k<BR>kernel code, 412k reserved, 612k data, 64k init, 0k =
bigmem)<BR>Dec 20=20
14:35:51 localhost kernel: Dentry hash table entries: 262144 =
(order<BR>9,=20
2048k)<BR>Dec 20 14:35:51 localhost kernel: Buffer cache hash table =
entries:=20
32768<BR>(order 5, 128k)<BR>Dec 20 14:35:51 localhost kernel: Page cache =
hash=20
table entries: 8192 (order<BR>3, 32k)<BR>Dec 20 14:35:51 localhost =
kernel: VFS:=20
Diskquotas version dquot_6.4.0<BR>initialized<BR>Dec 20 14:35:51 =
localhost=20
kernel: CPU: Intel Celeron (Mendocino) stepping 05<BR>Dec 20 14:35:51 =
localhost=20
kernel: Checking 386/387 coupling... OK, FPU using<BR>exception 16 error =

reporting.<BR>Dec 20 14:35:51 localhost kernel: Checking 'hlt' =
instruction...=20
OK.<BR>Dec 20 14:35:51 localhost kernel: POSIX conformance testing by=20
UNIFIX<BR>Dec 20 14:35:51 localhost kernel: mtrr: v1.35a (19990819) =
Richard=20
Gooch<BR>(<A =
href=3D"mailto:rgooch@atnf.csiro.au">rgooch@atnf.csiro.au</A>)<BR>Dec=20
20 14:35:51 localhost kernel: PCI: PCI BIOS revision 2.10 entry=20
at<BR>0xfb300<BR>Dec 20 14:35:51 localhost kernel: PCI: Using =
configuration type=20
1<BR>Dec 20 14:35:51 localhost kernel: PCI: Probing PCI hardware<BR>Dec =
20=20
14:35:51 localhost kernel: Linux NET4.0 for Linux 2.2<BR>Dec 20 14:35:51 =

localhost kernel: Based upon Swansea University Computer<BR>Society=20
NET3.039<BR>Dec 20 14:35:51 localhost kernel: NET4: Unix domain sockets =
1.0 for=20
Linux<BR>NET4.0.<BR>Dec 20 14:35:51 localhost kernel: NET4: Linux TCP/IP =
1.0 for=20
NET4.0<BR>Dec 20 14:35:51 localhost kernel: IP Protocols: ICMP, UDP, =
TCP,=20
IGMP<BR>Dec 20 14:35:51 localhost kernel: TCP: Hash tables configured =
(ehash=20
32768<BR>bhash 32768)<BR>Dec 20 14:35:51 localhost kernel: Initializing =
RT=20
netlink socket<BR>Dec 20 14:35:51 localhost kernel: Starting kswapd v =
1.5<BR>Dec=20
20 14:35:51 localhost kernel: Detected PS/2 Mouse Port.<BR>Dec 20 =
14:35:51=20
localhost kernel: Serial driver version 4.27 with =
MANY_PORTS<BR>MULTIPORT=20
SHARE_IRQ enabled<BR>Dec 20 14:35:51 localhost kernel: ttyS00 at 0x03f8 =
(irq =3D=20
4) is a 16550A<BR>Dec 20 14:35:51 localhost kernel: ttyS01 at 0x02f8 =
(irq =3D 3)=20
is a 16550A<BR>Dec 20 14:35:51 localhost kernel: pty: 256 Unix98 ptys=20
configured<BR>Dec 20 14:35:51 localhost kernel: apm: BIOS version 1.2 =
Flags 0x07=20
(Driver<BR>version 1.9)<BR>Dec 20 14:35:51 localhost kernel: Real Time =
Clock=20
Driver v1.09<BR>Dec 20 14:35:51 localhost kernel: RAM disk driver=20
initialized:&nbsp; 16 RAM disks<BR>of 4096K size<BR>Dec 20 14:35:51 =
localhost=20
kernel: SIS5513: IDE controller on PCI bus 00 dev<BR>01<BR>Dec 20 =
14:35:51=20
localhost kernel: SIS5513: not 100% native mode: will probe<BR>irqs =
later<BR>Dec=20
20 14:35:51 localhost kernel:&nbsp;&nbsp;&nbsp;&nbsp; ide0: BM-DMA at=20
0x4000-0x4007, BIOS<BR>settings: hda:DMA, hdb:DMA<BR>Dec 20 14:35:51 =
localhost=20
kernel:&nbsp;&nbsp;&nbsp;&nbsp; ide1: BM-DMA at 0x4008-0x400f, =
BIOS<BR>settings:=20
hdc:DMA, hdd:DMA<BR>Dec 20 14:35:51 localhost kernel: hda: ST36421A, ATA =
DISK=20
drive<BR>Dec 20 14:35:51 localhost kernel: hdd: Philips 40X PCA403CD, =
ATAPI=20
CDROM<BR>drive<BR>Dec 20 14:35:51 localhost kernel: ide0 at =
0x1f0-0x1f7,0x3f6 on=20
irq 14<BR>Dec 20 14:35:51 localhost kernel: ide1 at 0x170-0x177,0x376 on =
irq=20
15<BR>Dec 20 14:35:51 localhost kernel: hda: ST36421A, 6150MB w/256kB=20
Cache,<BR>CHS=3D784/255/63<BR>Dec 20 14:35:51 localhost kernel: hdd: =
ATAPI 48X=20
CD-ROM drive, 128kB Cache<BR>Dec 20 14:35:51 localhost kernel: Uniform =
CDROM=20
driver Revision: 2.56<BR>Dec 20 14:35:51 localhost kernel: Floppy =
drive(s): fd0=20
is 1.44M<BR>Dec 20 14:35:51 localhost kernel: FDC 0 is a post-1991 =
82077<BR>Dec=20
20 14:35:51 localhost kernel: md driver 0.90.0=20
MAX_MD_DEVS=3D256,<BR>MAX_REAL=3D12<BR>Dec 20 14:35:51 localhost kernel: =
raid5:=20
measuring checksumming speed<BR>Dec 20 14:35:51 localhost kernel: raid5: =
MMX=20
detected, trying high-speed MMX<BR>checksum routines<BR>Dec 20 14:35:51=20
localhost kernel:&nbsp;&nbsp;&nbsp; pII_mmx&nbsp;&nbsp; :&nbsp;&nbsp; =
891.540=20
MB/sec<BR>Dec 20 14:35:51 localhost kernel:&nbsp;&nbsp;&nbsp;=20
p5_mmx&nbsp;&nbsp;&nbsp; :&nbsp;&nbsp; 936.498 MB/sec<BR>Dec 20 14:35:51 =

localhost kernel:&nbsp;&nbsp;&nbsp; 8regs&nbsp;&nbsp;&nbsp;&nbsp; =
:&nbsp;&nbsp;=20
688.467 MB/sec<BR>Dec 20 14:35:51 localhost kernel:&nbsp;&nbsp;&nbsp;=20
32regs&nbsp;&nbsp;&nbsp; :&nbsp;&nbsp; 385.953 MB/sec<BR>Dec 20 14:35:51 =

localhost kernel: using fastest function: p5_mmx =
(936.498<BR>MB/sec)<BR>Dec 20=20
14:35:51 localhost kernel: scsi : 0 hosts.<BR>Dec 20 14:35:51 localhost =
kernel:=20
scsi : detected total.<BR>Dec 20 14:35:51 localhost kernel: md.c:=20
sizeof(mdp_super_t) =3D 4096<BR>Dec 20 14:35:51 localhost kernel: =
Partition=20
check:<BR>Dec 20 14:35:51 localhost kernel:&nbsp; hda: hda1 hda2 &lt; =
hda5 hda6=20
&gt; hda3 hda4<BR>Dec 20 14:35:51 localhost kernel: autodetecting RAID=20
arrays<BR>Dec 20 14:35:51 localhost kernel: autorun ...<BR>Dec 20 =
14:35:51=20
localhost kernel: ... autorun DONE.<BR>Dec 20 14:35:51 localhost kernel: =
VFS:=20
Mounted root (ext2 filesystem)<BR>readonly.<BR>Dec 20 14:35:51 localhost =
kernel:=20
Freeing unused kernel memory: 64k freed<BR>Dec 20 14:35:51 localhost =
kernel:=20
Adding Swap: 64252k swap-space<BR>(priority -1)<BR>Dec 20 14:35:51 =
localhost=20
kernel: cm: version v1.1 time 13:05:42 Apr 25 2000<BR>Dec 20 14:35:51 =
localhost=20
kernel: cm: found CM8738 adapter at io 0xe000 irq<BR>10<BR>Dec 20 =
14:35:51=20
localhost kernel: CSLIP: code copyright 1989 Regents of =
the<BR>University of=20
California<BR>Dec 20 14:35:51 localhost kernel: PPP: version 2.3.7 =
(demand=20
dialling)<BR>Dec 20 14:35:51 localhost kernel: PPP line discipline=20
registered.<BR>Dec 20 14:35:52 localhost identd: identd startup =
succeeded<BR>Dec=20
20 14:35:34 localhost rc.sysinit: Mounting proc filesystem =
succeeded<BR>Dec 20=20
14:35:34 localhost sysctl: net.ipv4.ip_forward =3D 0<BR>Dec 20 14:35:34 =
localhost=20
sysctl: net.ipv4.conf.all.rp_filter =3D 1<BR>Dec 20 14:35:34 localhost =
sysctl:=20
net.ipv4.ip_always_defrag =3D 0<BR>Dec 20 14:35:34 localhost sysctl: =
kernel.sysrq=20
=3D 0<BR>Dec 20 14:35:34 localhost rc.sysinit: Configuring kernel=20
parameters<BR>succeeded<BR>Dec 20 14:35:34 localhost date: Wed Dec 20 =
14:35:33=20
IST 2000<BR>Dec 20 14:35:34 localhost rc.sysinit: Setting clock : Wed =
Dec 20=20
14:35:33<BR>IST 2000 succeeded<BR>Dec 20 14:35:34 localhost rc.sysinit: =
Loading=20
default keymap succeeded<BR>Dec 20 14:35:34 localhost rc.sysinit: =
Activating=20
swap partitions succeeded<BR>Dec 20 14:35:34 localhost rc.sysinit: =
Setting=20
hostname Pina succeeded<BR>Dec 20 14:35:34 localhost fsck: /dev/hda4: =
clean,=20
66947/173888 files,<BR>238767/347405 blocks<BR>Dec 20 14:35:34 localhost =

rc.sysinit: Checking root filesystem succeeded<BR>Dec 20 14:35:34 =
localhost=20
rc.sysinit: Remounting root filesystem in<BR>read-write mode =
succeeded<BR>Dec 20=20
14:35:39 localhost rc.sysinit: Finding module dependencies =
succeeded<BR>Dec 20=20
14:35:40 localhost rc.sysinit: Loading sound module (cmpci) =
succeeded<BR>Dec 20=20
14:35:40 localhost aumix-minimal: vol set to 64, 64<BR>Dec 20 14:35:40 =
localhost=20
rc.sysinit: Loading mixer settings succeeded<BR>Dec 20 14:35:40 =
localhost=20
aumix-minimal: synth set to 64, 64, R<BR>Dec 20 14:35:40 localhost=20
aumix-minimal: pcm set to 100, 100<BR>Dec 20 14:35:40 localhost =
aumix-minimal:=20
line set to 64, 64, R<BR>Dec 20 14:35:40 localhost aumix-minimal: mic =
set to 64,=20
64, R<BR>Dec 20 14:35:40 localhost aumix-minimal: cd set to 64, 64, =
R<BR>Dec 20=20
14:35:40 localhost rc.sysinit: Checking filesystems succeeded<BR>Dec 20 =
14:35:40=20
localhost rc.sysinit: Mounting local filesystems succeeded<BR>Dec 20 =
14:35:40=20
localhost rc.sysinit: Turning on user and group quotas for<BR>local =
filesystems=20
succeeded<BR>Dec 20 14:35:41 localhost rc.sysinit: Enabling swap space=20
succeeded<BR>Dec 20 14:35:41 localhost init: Entering runlevel: 5<BR>Dec =
20=20
14:35:48 localhost kudzu:&nbsp; succeeded<BR>Dec 20 14:35:48 localhost =
sysctl:=20
net.ipv4.ip_forward =3D 0<BR>Dec 20 14:35:48 localhost sysctl:=20
net.ipv4.conf.all.rp_filter =3D 1<BR>Dec 20 14:35:48 localhost sysctl:=20
net.ipv4.ip_always_defrag =3D 0<BR>Dec 20 14:35:48 localhost sysctl: =
kernel.sysrq=20
=3D 0<BR>Dec 20 14:35:48 localhost network: Setting network parameters=20
succeeded<BR>Dec 20 14:35:49 localhost network: Bringing up interface lo =

succeeded<BR>Dec 20 14:35:49 localhost portmap: portmap startup =
succeeded<BR>Dec=20
20 14:35:50 localhost nfslock: rpc.lockd startup succeeded<BR>Dec 20 =
14:35:50=20
localhost nfslock: rpc.statd startup succeeded<BR>Dec 20 14:35:50 =
localhost=20
apmd: apmd startup succeeded<BR>Dec 20 14:35:50 localhost apmd[305]: =
Version=20
3.0final (APM BIOS 1.2, Linux<BR>driver 1.9)<BR>Dec 20 14:35:50 =
localhost=20
random: Initializing random number generator<BR>succeeded<BR>Dec 20 =
14:35:50=20
localhost netfs: Mounting other filesystems succeeded<BR>Dec 20 14:35:52 =

localhost atd: atd startup succeeded<BR>Dec 20 14:35:53 localhost crond: =
crond=20
startup succeeded<BR>Dec 20 14:35:53 localhost rc: Starting pcmcia=20
succeeded<BR>Dec 20 14:35:53 localhost inet: inetd startup =
succeeded<BR>Dec 20=20
14:35:54 localhost inetd[429]: auth/tcp: bind: Address already in =
use<BR>Dec 20=20
14:35:54 localhost lpd: lpd startup succeeded<BR>Dec 20 14:35:54 =
localhost=20
lpd[443]: restarted<BR>Dec 20 14:35:54 localhost keytable: Loading=20
keymap:<BR>Dec 20 14:35:54 localhost keytable:=20
Loading<BR>/usr/lib/kbd/keymaps/i386/qwerty/us.kmap.gz<BR>Dec 20 =
14:35:54=20
localhost keytable: Loading system font:<BR>Dec 20 14:35:55 localhost =
rc:=20
Starting keytable succeeded<BR>Dec 20 14:35:57 localhost sendmail: =
sendmail=20
startup succeeded<BR>Dec 20 14:35:57 localhost gpm: gpm startup =
succeeded<BR>Dec=20
20 14:35:58 localhost xfs: xfs startup succeeded<BR>Dec 20 14:35:58 =
localhost=20
xfs: Warning: The directory<BR>"/usr/X11R6/lib/X11/fonts/100dpi" does =
not=20
exist.<BR>Dec 20 14:35:58 localhost=20
xfs:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Entry deleted =
from=20
font path.<BR>Dec 20 14:35:59 localhost linuxconf: Linuxconf final =
setup<BR>Dec=20
20 14:36:00 localhost rc: Starting linuxconf succeeded<BR>Dec 20 =
14:36:14=20
localhost PAM_pwdb[591]: authentication failure; (uid=3D0) -&gt;<BR>root =
for gdm=20
service<BR>Dec 20 14:36:15 localhost gdm[591]: Couldn't authenticate =
root<BR>Dec=20
20 14:36:22 localhost PAM_pwdb[591]: (gdm) session opened for user =
root<BR>by=20
(uid=3D0)<BR>Dec 20 14:36:22 localhost gdm[591]: =
gdm_slave_session_start: root on=20
:0<BR>Dec 20 14:43:06 localhost modprobe: modprobe: Can't locate=20
module<BR>char-major-28<BR>Dec 20 14:43:29 localhost modprobe: modprobe: =
Can't=20
locate module<BR>char-major-24<BR>Dec 20 14:45:54 localhost inetd[429]:=20
auth/tcp: bind: Address already in use<BR>Dec 20 14:47:45 localhost=20
PAM_pwdb[591]: (gdm) session closed for user root<BR>Dec 20 14:48:00 =
localhost=20
PAM_pwdb[789]: (gdm) session opened for user root<BR>by (uid=3D0)<BR>Dec =
20=20
14:48:00 localhost gdm[789]: gdm_slave_session_start: root on :0<BR>Dec =
20=20
14:55:54 localhost inetd[429]: auth/tcp: bind: Address already in =
use<BR>Dec 20=20
15:05:54 localhost inetd[429]: auth/tcp: bind: Address already in =
use<BR>Dec 20=20
15:14:26 localhost PAM_pwdb[789]: (gdm) session closed for user =
root<BR>Dec 20=20
15:14:48 localhost PAM_pwdb[577]: (login) session opened for =
user<BR>root by=20
LOGIN(uid=3D0)<BR>Dec 20 15:15:54 localhost inetd[429]: auth/tcp: bind: =
Address=20
already in use<BR><BR><BR><BR></DIV></FONT></BODY></HTML>

------=_NextPart_000_0025_01C06ADC.70621780--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
