Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271729AbTG2N5J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271721AbTG2N5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:57:09 -0400
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:44445 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S271729AbTG2N47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:56:59 -0400
Subject: [v2.6.0-test2] hda: dma_timer_expiry: dma status == 0x60
From: =?ISO-8859-1?Q?Ram=F3n?= Rey =?UTF-8?Q?Vicente?=
	 =?UTF-8?Q?=F3=AE=A0=92?= <ramon.rey@hispalinux.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-80cQ+yCJmwe2SF24tn4V"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1059486614.12370.8.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 29 Jul 2003 15:50:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-80cQ+yCJmwe2SF24tn4V
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi

Using hdparm with this options

hdparm -k1 -d1 -u1 -c1 -a8 -m16 -X udma2 /dev/hda

I obtain this

blk: queue c02fb11c, I/O limit 4095Mb (mask 0xffffffff)
hda: channel busy
hda: dma_timer_expiry: dma status =3D=3D 0x60
hda: DMA timeout retry
hda: timeout waiting for DMA
hda: status error: status=3D0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: status timeout: status=3D0xd0 { Busy }

hdb: DMA disabled
hda: no DRQ after issuing MULTWRITE
ide0: reset: success
blk: queue c02fb11c, I/O limit 4095Mb (mask 0xffffffff)
hda: CHECK for good STATUS


Some information of my system

Linux debian 2.6.0-test2 #2 Sun Jul 27 21:18:34 CEST 2003 i586 GNU/Linux
=20
Gnu C                  3.3.1
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
e2fsprogs              1.34
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.11
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         r128 snd_seq_midi snd_seq_oss snd_seq_midi_event
snd_seq snd_pcm_oss snd_mixer_oss snd_ens1371 snd_rawmidi snd_seq_device
snd_pcm snd_page_alloc snd_timer snd_ac97_codec snd ipt_REDIRECT
iptable_nat ipt_state ip_conntrack iptable_filter ip_tables uhci_hcd
usbcore 8139too mii crc32 ide_cd cdrom

And my hardware

cat /proc/via:
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.37
South Bridge:                       VIA vt82c586b
Revision:                           ISA 0x47 IDE 0x6
Highest DMA rate:                   UDMA33
BM-DMA base:                        0xe000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       DMA      UDMA
Address Setup:       30ns      30ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns      90ns      90ns      90ns
Data Recovery:       30ns      30ns      30ns      30ns
Cycle Time:          60ns     120ns     120ns      60ns
Transfer Rate:   33.3MB/s  16.6MB/s  16.6MB/s  33.3MB/s




Processor
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 451.191
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow
k6_mtrr
bogomips        : 888.83

/proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
4000-40ff : VIA Technologies, In VT82C586B ACPI
d000-dfff : PCI Bus #01
  d000-d0ff : ATI Technologies Inc Rage 128 PF/PRO AGP=20
e000-e00f : VIA Technologies, In VT82C586/B/686A/B PI
  e000-e007 : ide0
  e008-e00f : ide1
e400-e41f : VIA Technologies, In USB
  e400-e41f : uhci-hcd
e800-e8ff : Realtek Semiconducto RTL-8139/8139C/8139C
  e800-e8ff : 8139too
ec00-ec3f : Ensoniq ES1371 [AudioPCI-97]
  ec00-ec3f : Ensoniq AudioPCI

--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
------------------------------------------------------------
gpg public key ID 0xBEBD71D5 # http://pgp.escomposlinux.org/

--=-80cQ+yCJmwe2SF24tn4V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/JnuWRGk68b69cdURAsr9AKCDmcmqEPwpaC6HFcNmAurS7TeK/gCghk/u
py6voruZggoUd9ZJHjfITcc=
=ZOy7
-----END PGP SIGNATURE-----

--=-80cQ+yCJmwe2SF24tn4V--

