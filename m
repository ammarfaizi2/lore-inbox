Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVHDUWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVHDUWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 16:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVHDUW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 16:22:28 -0400
Received: from donau.nordija.com ([217.157.49.52]:6563 "EHLO donau.nordija.com")
	by vger.kernel.org with ESMTP id S262673AbVHDUVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 16:21:51 -0400
Subject: Oops when shutting down laptop
From: Kristian =?ISO-8859-1?Q?Gr=F8nfeldt_S=F8rensen?= <kriller@vkr.dk>
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7f0YljH+AwCTOc1DBMc5"
Date: Thu, 04 Aug 2005 22:21:41 +0200
Message-Id: <1123186901.8831.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7f0YljH+AwCTOc1DBMc5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi.

My laptop oops'es in the final phase of shutdown. It started this
Monday. I don't remember having done anything particular with respect to
the kernel around that time. It only happens when going to runlevel 0 -
a reboot does not result in an oops.

Until yesterday i used kernel 2.6.13-rc3, but i have now compiled
2.6.13-rc5 with some debugging support. However the problem persists.

Since the oops happens so late in the shutdown-sequence, that all
filesystems has been unmounted, i am unable to capture the oops on the
disc, but a picture of the oops is available at
http://www.vkr.dk/~kriller/oops.jpg . (Sorry for not writing the oops in
this mail).

I tried to remove all modules except speedstep_centrino, freqtable,
processor and ipv6 (reported as being in use),  before calling poweroff,
but with no change.

I'm not subscribed to the list - Please CC' me.

regards=20
Kristian S=F8rensen


Environment:
Debian Unstable with self-compiled 2.6.13-rc5 kernel from kernel.org

Linux kriller 2.6.13-rc5-x300 #1 Wed Aug 3 22:16:03 CEST 2005 i686
GNU/Linux

Gnu C                  4.0.2
Gnu make               3.80
binutils               2.16.1
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre8
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
xfsprogs               2.6.36
pcmcia-cs              3.2.8
PPP                    2.4.3
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.5
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
udev                   065
Modules Loaded         nls_cp437 vfat fat usb_storage ub bnep rfcomm
hidp l2cap irda crc_ccitt binfmt_misc ipv6 pcmcia firm
ware_class af_packet rtc snd_intel8x0m snd_intel8x0 snd_ac97_codec
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcor
e snd_page_alloc i2c_i801 i2c_core ehci_hcd hci_usb pl2303 usbserial
eth1394 uhci_hcd tg3 ohci1394 yenta_socket rsrc_nonsta
tic pcmcia_core nls_iso8859_1 ntfs dm_mod sermouse hci_vhci hci_uart
bluetooth wbsd mmc_block mmc_core tun msr cpuid cpufre
q_stats container video hotkey fan button speedstep_lib ndiswrapper
usbcore thermal battery ac speedstep_centrino freq_tabl
e processor sr_mod sbp2 scsi_mod ieee1394 ide_cd cdrom bcm5700 mousedev
evdev

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 9
model name      : Intel(R) Pentium(R) M processor 1200MHz
stepping        : 5
cpu MHz         : 599.548
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov
pat clflush dts acpi mmx fxsr sse sse2 tm pbe est tm2
bogomips        : 1200.63

$ cat /proc/ioports
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
01f0-01f7 : ide0
02f8-02ff : serial
03c0-03df : vesafb
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-107f : 0000:00:1f.0
  1000-107f : motherboard
    1000-1003 : PM1a_EVT_BLK
    1004-1005 : PM1a_CNT_BLK
    1008-100b : PM_TMR
    1010-1015 : ACPI CPU throttle
    1020-1020 : PM2_CNT_BLK
    1028-102f : GPE0_BLK
1180-11bf : 0000:00:1f.0
  1180-11bf : motherboard
1800-1807 : 0000:00:02.0
1810-181f : 0000:00:1f.1
  1810-1817 : ide0
1820-183f : 0000:00:1d.0
  1820-183f : uhci_hcd
1840-185f : 0000:00:1d.1
  1840-185f : uhci_hcd
1860-187f : 0000:00:1d.2
  1860-187f : uhci_hcd
1880-189f : 0000:00:1f.3
  1880-188f : i801-smbus
18c0-18ff : 0000:00:1f.5
  18c0-18ff : Intel 82801DB-ICH4
1c00-1cff : 0000:00:1f.5
  1c00-1cff : Intel 82801DB-ICH4
2000-207f : 0000:00:1f.6
  2000-207f : Intel 82801DB-ICH4 Modem
2400-24ff : 0000:00:1f.6
  2400-24ff : Intel 82801DB-ICH4 Modem
3000-6fff : PCI Bus #02
  3000-3fff : PCI CardBus #03
  4000-4fff : PCI CardBus #03
  5000-5fff : PCI CardBus #07
  6000-6fff : PCI CardBus #07

$ cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cc7ff : Video ROM
000cc800-000cd7ff : Adapter ROM
000cd800-000cf7ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-4767dfff : System RAM
  00100000-0037ba5e : Kernel code
  0037ba5f-00459ca7 : Kernel data
4767e000-476dffff : ACPI Non-volatile Storage
476e0000-476eafff : ACPI Tables
476eb000-476fffff : ACPI Non-volatile Storage
47700000-47ffffff : reserved
48000000-4bffffff : PCI Bus #02
  48000000-49ffffff : PCI CardBus #03
  4a000000-4bffffff : PCI CardBus #07
4c000000-4c0003ff : 0000:00:1f.1
4e000000-4fffffff : PCI CardBus #03
50000000-51ffffff : PCI CardBus #07
e0000000-e007ffff : 0000:00:02.0
e0080000-e00fffff : 0000:00:02.1
e0100000-e01003ff : 0000:00:1d.7
  e0100000-e01003ff : ehci_hcd
e0100800-e01008ff : 0000:00:1f.5
  e0100800-e01008ff : Intel 82801DB-ICH4
e0100c00-e0100dff : 0000:00:1f.5
  e0100c00-e0100dff : Intel 82801DB-ICH4
e0200000-e02fffff : PCI Bus #02
  e0200000-e020ffff : 0000:02:05.0
    e0200000-e020ffff : bcm5700
  e0210000-e0211fff : 0000:02:04.0
    e0210000-e0211fff : ndiswrapper
  e0212000-e02127ff : 0000:02:03.2
    e0212000-e02127ff : ohci1394
  e0213000-e0213fff : 0000:02:03.0
    e0213000-e0213fff : yenta_socket
  e0214000-e0214fff : 0000:02:03.1
    e0214000-e0214fff : yenta_socket
  e0220000-e0220fff : pcmcia_socket0
e8000000-efffffff : 0000:00:02.0
  e8000000-e87cffff : vesafb
f0000000-f7ffffff : 0000:00:02.1
fec10000-fec1ffff : reserved
ff800000-ffbfffff : reserved
fffffc00-ffffffff : reserved



--=-7f0YljH+AwCTOc1DBMc5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC8njVfHDihydQNssRAoe9AJ96bSyQxa4wm+9TamuKx2IfAz84hgCdHkWH
UgI0z78NWnkNhOo5HgyMTgM=
=ScyX
-----END PGP SIGNATURE-----

--=-7f0YljH+AwCTOc1DBMc5--

