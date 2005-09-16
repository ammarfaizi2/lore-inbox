Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbVIPUzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVIPUzp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 16:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVIPUzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 16:55:45 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:28047 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S1750853AbVIPUzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 16:55:43 -0400
Date: Fri, 16 Sep 2005 22:55:41 +0200
From: Folkert van Heusden <folkert@vanheusden.com>
To: linux-kernel@vger.kernel.org
Subject: Re: printk timings stay weird, also waaay after 5 seconds
Message-ID: <20050916205541.GL17290@vanheusden.com>
References: <20050916204759.GK17290@vanheusden.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AQNmCumFClRcGgHG"
Content-Disposition: inline
In-Reply-To: <20050916204759.GK17290@vanheusden.com>
Organization: www.unixexpert.nl
X-Chameleon-Return-To: folkert@vanheusden.com
X-Xfmail-Return-To: folkert@vanheusden.com
X-Phonenumber: +31-6-41278122
X-URL: http://www.vanheusden.com/
X-PGP-KeyID: 1F28D8AE
X-GPG-fingerprint: AC89 09CE 41F2 00B4 FCF2  B174 3019 0E8C 1F28 D8AE
X-Key: http://pgp.surfnet.nl:11371/pks/lookup?op=get&search=0x1F28D8AE
Read-Receipt-To: <folkert@vanheusden.com>
Reply-By: Sat Sep 17 17:31:08 CEST 2005
X-MSMail-Priority: High
X-Message-Flag: PGP key-id: 0x1f28d8ae - consider encrypting your e-mail to me
	with PGP!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AQNmCumFClRcGgHG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

by the way: ALSO after a COLD boot these values are high:
[42949372.960000] Linux version 2.6.13.1 (root@thegate) (gcc version 4.0.1 =
(Debian 4.0.1-2)) #1 Wed Sep 14 11:56:45 CEST 2005
[42949372.960000] BIOS-provided physical RAM map:
[42949372.960000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
=2E..
[42949376.200000] Freeing unused kernel memory: 140k freed
[42949377.170000] NET: Registered protocol family 1
[42949379.080000] Adding 497972k swap on /dev/hda1.  Priority:-1 extents:1
[42949379.180000] EXT3 FS on hda2, internal journal
=2E..
[42949421.150000] pwc Dumping frame 39 (last message).
[42949421.220000] pwc Dumping frame 38 (last message).
[42949425.770000] eth1: no IPv6 routers present

apart from this the computer runs fine without any segfaults, sigs11 or
reboots.

On Fri, Sep 16, 2005 at 10:47:59PM +0200, Folkert van Heusden wrote:
> Hi,
>=20
> I have a pc with a VIA Nehemiah. It runs kernel 2.6.13.1.
> At boot of course the timings are high:
> thegate:/home/folkert/public_html# dmesg | more
> [42949372.960000] Linux version 2.6.13.1 (root@thegate) (gcc version 4.0.=
1 (Debian 4.0.1-2)) #1 Wed Sep 14 11:56:45 CEST 2005
> [42949372.960000] BIOS-provided physical RAM map:
> [42949372.960000]  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
> ...
> but stay high:
> [42949376.950000] NET: Registered protocol family 1
> [42949378.810000] Adding 497972k swap on /dev/hda1.  Priority:-1 extents:1
> [42949378.910000] EXT3 FS on hda2, internal journal
> [42949379.320000] Generic RTC Driver v1.07
> [42949383.180000] Probing IDE interface ide1...
> [42949385.100000] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 12
> [42949385.100000] PCI: setting IRQ 12 as level-triggered
> ...
> [42949626.430000] pwc Dumping frame 41 (last message).
> [43132475.940000] pwc Closing video device: 1829087 frames received, dump=
ed 554742 frames, 0 frames with errors.
> [43132482.400000] pwc set_video_mode(320x240 @ 10, palette 15).
> ...
> [43132483.920000] pwc Dumping frame 7.
> [43132484.120000] pwc Dumping frame 9.
>=20
> etc.
>=20
>=20
> Folkert van Heusden
>=20
> --=20
> Try MultiTail! Multiple windows with logfiles, filtered with regular
> expressions, colored output, etc. etc. www.vanheusden.com/multitail/
> ----------------------------------------------------------------------
> Get your PGP/GPG key signed at www.biglumber.com!
> ----------------------------------------------------------------------
> Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com




Folkert van Heusden

--=20
Try MultiTail! Multiple windows with logfiles, filtered with regular
expressions, colored output, etc. etc. www.vanheusden.com/multitail/
----------------------------------------------------------------------
Get your PGP/GPG key signed at www.biglumber.com!
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com

--AQNmCumFClRcGgHG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iIMEARECAEMFAkMrMU08Gmh0dHA6Ly93d3cudmFuaGV1c2Rlbi5jb20vZGF0YS1z
aWduaW5nLXdpdGgtcGdwLXBvbGljeS5odG1sAAoJEDAZDowfKNiuGOgAn2ApWRyo
k3LBIe7SpZotqO7DlaJ/AKCd7+ULzpxaMytN2CGvKA7KdJLs7A==
=uFpo
-----END PGP SIGNATURE-----

--AQNmCumFClRcGgHG--
