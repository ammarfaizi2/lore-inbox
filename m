Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbVJKTP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVJKTP4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 15:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVJKTP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 15:15:56 -0400
Received: from t51.1paket.com ([83.133.127.51]:60391 "EHLO t51.1paket.com")
	by vger.kernel.org with ESMTP id S932331AbVJKTPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 15:15:55 -0400
Date: Tue, 11 Oct 2005 21:16:03 +0200
From: Savar <savar@schuldeigen.de>
To: linux-kernel@vger.kernel.org
Subject: "sync" option with usb storage makes it real slow since 2.6.13
Message-Id: <20051011211603.8aff1cee.savar@schuldeigen.de>
X-Mailer: Sylpheed version 2.1.3 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__11_Oct_2005_21_16_03_+0200_PhJ27b2PNaHs4tWc"
X-Bogosity: Ham, tests=bogofilter, spamicity=0.150498, version=0.94.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__11_Oct_2005_21_16_03_+0200_PhJ27b2PNaHs4tWc
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

When I mount an usb stick with the option "sync" (USB 2.0) I got a
writing speed about 15 kbyte/s. Reading is ok (ca. 1 s for 2,3 MB).=20
It doesn't matter if trying as root or normal user. I only have to
unmount the stick and remount it without "sync" and writing is fast.
That means I write something on the stick (ok it's buffered) and=20
then I type "sync" as command and after 1 s it's done (LED from
usb stick turned off and data were written).

All this starts with kernel 2.6.13, 2.6.12 was ok.

I'm using 2.6.13 (not >)!
If it's solved in an newer Kernel, please ignore this email.

Keywords: usb (maybe storage)


Greetz
Simon



processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 9
model name	: Intel(R) Pentium(R) M processor 1500MHz
stepping	: 5
cpu MHz		: 798.217
cache size	: 1024 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 sep mtrr pge mca cmov pat clflush d=
ts acpi mmx fxsr sse sse2 tm pbe est tm2
bogomips	: 1597.18





af_packet 12680 2 - Live 0xe0f91000
ipt_mac 1664 0 - Live 0xe0f65000
ipt_state 1664 0 - Live 0xe0f63000
iptable_filter 2304 0 - Live 0xe0f00000
ip_conntrack_ftp 71568 0 - Live 0xe0f4c000
irtty_sir 5120 0 - Live 0xe0f1c000
sir_dev 13100 1 irtty_sir, Live 0xe0f47000
irda 110520 1 sir_dev, Live 0xe0f6a000
crc_ccitt 1920 1 irda, Live 0xe0f02000
lp 9284 0 - Live 0xe0f15000
pcmcia 30760 2 - Live 0xe0f3e000
joydev 8000 0 - Live 0xe0f12000
parport_pc 24772 1 - Live 0xe0f36000
parport 32584 2 lp,parport_pc, Live 0xe0f2d000
rtc 9528 0 - Live 0xe0f05000
usb_storage 39172 1 - Live 0xe0f22000
usbhid 28548 0 - Live 0xe0f0a000
yenta_socket 21900 2 - Live 0xe0e24000
rsrc_nonstatic 11392 1 yenta_socket, Live 0xe0ecf000
ipw2100 131328 0 - Live 0xe0e2f000
ieee80211 50244 1 ipw2100, Live 0xe0e14000
ieee80211_crypt 4612 1 ieee80211, Live 0xe0e2c000
ohci1394 31156 0 - Live 0xe0e05000
ieee1394 284728 1 ohci1394, Live 0xe0e53000
snd_intel8x0m 14916 0 - Live 0xe0dca000
ehci_hcd 27784 0 - Live 0xe0d77000
uhci_hcd 29072 0 - Live 0xe0dc1000
usbcore 101628 5 usb_storage,usbhid,ehci_hcd,uhci_hcd, Live 0xe0de0000
intel_agp 20252 1 - Live 0xe0d68000
eeprom 5776 0 - Live 0xe0b86000
lm90 10660 0 - Live 0xe0c03000
i2c_sensor 2944 2 eeprom,lm90, Live 0xe0b89000
i2c_i801 7820 0 - Live 0xe0b81000
i2c_core 16784 4 eeprom,lm90,i2c_sensor,i2c_i801, Live 0xe0bf2000
cryptoloop 3200 0 - Live 0xe0b84000
ip_conntrack 38552 2 ipt_state,ip_conntrack_ftp, Live 0xe0bf8000
ip_tables 20096 3 ipt_mac,ipt_state,iptable_filter, Live 0xe0be5000
nvidia 3692744 12 - Live 0xe0fa1000
agpgart 27976 2 intel_agp,nvidia, Live 0xe0b8b000
smbfs 60024 0 - Live 0xe0b93000




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
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
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
10ac-10ac : motherboard
1100-111f : 0000:00:1f.3
  1100-111f : motherboard
    1100-110f : i801-smbus
1180-11bf : 0000:00:1f.0
  1180-11bf : motherboard
1800-181f : 0000:00:1d.0
  1800-181f : uhci_hcd
1820-183f : 0000:00:1d.1
  1820-183f : uhci_hcd
1840-184f : 0000:00:1f.1
  1840-1847 : ide0
  1848-184f : ide1
1880-18bf : 0000:00:1f.5
  1880-18bf : Intel 82801DB-ICH4
1c00-1cff : 0000:00:1f.5
  1c00-1cff : Intel 82801DB-ICH4
2000-207f : 0000:00:1f.6
2400-24ff : 0000:00:1f.6
3000-3fff : PCI Bus #02
  3000-303f : 0000:02:08.0
    3000-303f : e100
  3400-34ff : PCI CardBus #03
  3800-38ff : PCI CardBus #03
e000-e07f : motherboard
e080-e0ff : motherboard
e400-e47f : motherboard
e480-e4ff : motherboard
e800-e87f : motherboard
e880-e8ff : motherboard
ec00-ec7f : motherboard
ec80-ecff : motherboard




00000000-0009f7ff : System RAM
  00000000-00000000 : Crash kernel
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d3fff : reserved
000d4000-000d57ff : Adapter ROM
000e3000-000e3fff : Adapter ROM
000f0000-000fffff : System ROM
00100000-1ff5ffff : System RAM
  00100000-0044b72e : Kernel code
  0044b72f-0057bc87 : Kernel data
1ff60000-1ff69fff : ACPI Tables
1ff6a000-1ff6afff : reserved
1ff6b000-1ff6ffff : ACPI Non-volatile Storage
1ff70000-1fffffff : reserved
20000000-21ffffff : PCI Bus #02
  20000000-21ffffff : PCI CardBus #03
22000000-220003ff : 0000:00:1f.1
24000000-25ffffff : PCI CardBus #03
c0000000-c00003ff : 0000:00:1d.7
  c0000000-c00003ff : ehci_hcd
c0000800-c00008ff : 0000:00:1f.5
  c0000800-c00008ff : Intel 82801DB-ICH4
c0000c00-c0000dff : 0000:00:1f.5
  c0000c00-c0000dff : Intel 82801DB-ICH4
c1000000-c1ffffff : PCI Bus #01
  c1000000-c1ffffff : 0000:01:00.0
    c1000000-c1ffffff : nvidia
c2000000-c20fffff : PCI Bus #02
  c2000000-c2003fff : 0000:02:07.0
  c2004000-c2004fff : 0000:02:08.0
    c2004000-c2004fff : e100
  c2005000-c2005fff : 0000:02:0a.0
    c2005000-c2005fff : ipw2100
  c2006000-c20067ff : 0000:02:07.0
    c2006000-c20067ff : ohci1394
  c2006800-c20069ff : 0000:02:0d.0
  c2007000-c2007fff : 0000:02:0b.0
    c2007000-c2007fff : yenta_socket
d0000000-dfffffff : 0000:00:00.0
e0000000-efffffff : PCI Bus #01
  e0000000-efffffff : 0000:01:00.0
    e0000000-e3ffffff : vesafb
ffb80000-ffbfffff : reserved
fff80000-ffffffff : reserved

--=20
GnuPG: 5755FB64

--Signature=_Tue__11_Oct_2005_21_16_03_+0200_PhJ27b2PNaHs4tWc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDTA9622GXeldV+2QRApHlAJ4vyrCQQ/JEtD7dYIidGnEzdmHwjwCeJ2Yt
DkbJ0gh6ZFRzpuryOhEkBzo=
=iyFD
-----END PGP SIGNATURE-----

--Signature=_Tue__11_Oct_2005_21_16_03_+0200_PhJ27b2PNaHs4tWc--
