Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbUKFUTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUKFUTf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 15:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261466AbUKFUTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 15:19:34 -0500
Received: from 80-26-214-34.adsl.nuria.telefonica-data.net ([80.26.214.34]:49412
	"EHLO debbie") by vger.kernel.org with ESMTP id S261461AbUKFUSO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 15:18:14 -0500
Date: Sat, 6 Nov 2004 21:26:00 +0100
From: =?iso-8859-1?Q?Rams=E9s_Rodr=EDguez_Mart=EDnez?= <harpago@terra.es>
To: linux-kernel@vger.kernel.org
Subject: kernel panic while using netcat since linux-2.6.9
Message-ID: <20041106202600.GA1002@debbie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
Sorry i don't include any dump, but it seems kernel-patch-lkcd for 2.6.9 is
not available yet. I could handcopy the kernel-oops if you want. I think
it'll be something related with bind() as it fails with "netcat".

The problem is only present with 2.6.9 (or at least not with 2.6.8 nor
2.6.5)

------------------------
SCRIPT TO REPRODUCE:
 =20
su
apt-get install nc
exit
nc -p2000 127.0.0.1 2000        # kernel panic

------------------------

MORE INFO:

=2E/ver_linux:

Linux debbie 2.6.9 #1 Wed Nov 3 23:59:06 CET 2004 i686 GNU/Linux
 Gnu C                  3.4.2  =20
Gnu make               3.80   =20
binutils               2.15   =20
util-linux             2.12h  =20
mount                  2.12h  =20
module-init-tools      3.1-pre6
e2fsprogs              1.35 =20
reiserfsprogs          3.6.19
reiser4progs           1.0.0
quota-tools            3.12.
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.2.3
Net-tools              1.60=20
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         fuse usb_storage lm80 snd_ens1371 snd_rawmidi
snd_ac97_codec uhci_hcd usbcore i2c_sensor 8139too crc32 mii lp parport_pc
parport

---------------------------------

Please contact me if you need more information.


--=20
---
RAMSES
harpago@terra.es
---
Clave PGP en: http://pgp.rediris.es:11371/pks/lookup?op=3Dget&search=3D0xD1=
AF6D7E
MSN: harpagokafka@hotmail.com
Jabber: harpago@jabber.at
---
---


--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBjTNYxk91vNGvbX4RArlGAJ95PpHQYNFPrr+RAh5j/fGwjaXLcwCgkep7
ZBR9wsr8dA7WJnNuYqQ3f2c=
=ujNq
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
