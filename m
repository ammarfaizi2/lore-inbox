Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312388AbSCUQvW>; Thu, 21 Mar 2002 11:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312390AbSCUQvN>; Thu, 21 Mar 2002 11:51:13 -0500
Received: from tabaluga.ipe.uni-stuttgart.de ([129.69.22.180]:30361 "EHLO
	tabaluga.ipe.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S312389AbSCUQvJ>; Thu, 21 Mar 2002 11:51:09 -0500
From: Nils Rennebarth <nils@ipe.uni-stuttgart.de>
Date: Thu, 21 Mar 2002 17:51:07 +0100
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: linker error in kernel-2.4.19-pre3-ac4
Message-ID: <20020321165107.GN19783@ipe.uni-stuttgart.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PZYVFYZbFYjzBslI"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PZYVFYZbFYjzBslI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Compiling the kernel stops with:

find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
/data/src/v2.4/linux/debian/tmp-image -r 2.4.19-pre3-ac4; fi
depmod: *** Unresolved symbols in
/data/src/v2.4/linux/debian/tmp-image/lib/modules/2.4.19-pre3-ac4/kernel/dr=
ivers/char/drm/sis.o
depmod:         sis_malloc_Ra3329ed5
depmod:         sis_free_Rced25333
make[2]: *** [_modinst_post] Error 1
make[2]: Leaving directory `/data/src/v2.4/linux'
make[1]: *** [real_stamp_image] Error 2
make[1]: Leaving directory `/data/src/v2.4/linux'

Does anyone know a fix?

Nils

--
                                     ______
                                    (Muuuhh)
Global Village Sau  =3D=3D>        ^..^ |/=AF=AF=AF=AF=AF
(Kann Fremdsprache) =3D=3D>        (oo)

--PZYVFYZbFYjzBslI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8mg97qgAZ+sZlgs4RAr+wAJ9+p221MiAWx4CFBN30GH+dd60kCQCgx6+N
4MNcZekyjszsIsSNGS1X1Lk=
=QYVB
-----END PGP SIGNATURE-----

--PZYVFYZbFYjzBslI--
