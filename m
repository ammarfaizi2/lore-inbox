Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272473AbRIVXRg>; Sat, 22 Sep 2001 19:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272484AbRIVXRZ>; Sat, 22 Sep 2001 19:17:25 -0400
Received: from mail.bgone.net ([62.176.110.20]:29452 "HELO mail.bgone.net")
	by vger.kernel.org with SMTP id <S272473AbRIVXRJ>;
	Sat, 22 Sep 2001 19:17:09 -0400
Date: Sun, 23 Sep 2001 02:16:23 +0300
From: Luben Karavelov <luben@bgone.net>
To: linux-kernel@vger.kernel.org
Subject: kernel can not scan partition table of hdd?
Message-ID: <20010923021623.A1201@bgone.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,
I have the following proble. After I have upgraded the=20
kernel from from 2.4.7 to 2.4.9 I have found that the new
kernel can not scan the partition table of the disk - it
freezes for a moment and than i continue but it can not
find the root device after that.
The situation with 2.4.10-pre14 and 2.4.9-ac14 is the same.
I haven't tried kernel 2.4.8 but with 2.4.7 and previous=20
kernels it works fine.

The partition table of the disk is:
Disk /dev/hda: 64 heads, 63 sectors, 621 cylinders
Units =3D cylinders of 4032 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
   /dev/hda1   *         1        39     78592+  83  Linux
   /dev/hda2            40       562   1054368    5  Extended
   /dev/hda3           563       621    118944   82  Linux swap
   /dev/hda5            40       354    635008+  83  Linux
   /dev/hda6           355       451    195520+  83  Linux
   /dev/hda7           452       562    223744+  83  Linux

the chipset of the ide controller is VIA82C59x. The disk is quantum
fireball_tm1280a ata.

Any ideas? If the partition table of the disk is not correct, how to
fix it?

Luben

P.S. Please cc me, because I'm not in the list.

--=20
_________________________________________________________
Luben Karavelov                    [phone] +359 2 9877088
Network Administrator                     [ICQ#] 34741625
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjutG8cACgkQ6e+ttke0ZA+OTwCgnSY4QrkdCzVskHmW65xcTOdN
Ul8An3dFFLkP2C0D8JMs01Q9+LCbZS5c
=n4It
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
