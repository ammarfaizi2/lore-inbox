Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135283AbRD3Ucc>; Mon, 30 Apr 2001 16:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135899AbRD3UcX>; Mon, 30 Apr 2001 16:32:23 -0400
Received: from smtp.xs4all.be ([195.144.67.21]:10259 "EHLO smtp.xs4all.be")
	by vger.kernel.org with ESMTP id <S135283AbRD3UcM>;
	Mon, 30 Apr 2001 16:32:12 -0400
Date: Sun, 29 Apr 2001 15:40:56 +0200
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: linux-kernel@vger.kernel.org
Subject: 2.4.4 + gcc 3 compile error
Message-ID: <20010429154056.A972@xs4all.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
X-Marks-The-Spot: xxxxxxxxxx
X-GPG-Fingerprint: 1024D/8E950E00 CAC1 0932 B6B9 8768 40DB  C6AA 1239 F709 8E95 0E00
X-Machine-info: Linux lucretia 2.4.3 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I tried compiling the 2.4.4 release with a gcc 3 snapshot and it failed with
following error:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fo=
mit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=3D2=
 -march=3Di686    -DEXPORT_SYMTAB -c sys.c
sys.c: In function `sys_gethostname':
/usr/src/linux/include/asm/rwsem.h:152: inconsistent operand constraints in=
 an `asm'
make[3]: *** [sys.o] Error 1
make[3]: Leaving directory `/usr/src/linux/kernel'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/kernel'
make[1]: *** [_dir_kernel] Error 2
make[1]: Leaving directory `/usr/src/linux'
make: *** [stamp-build] Error 2
lucretia:/usr/src/linux$


Regards,

Filip

--=20
My opinions may have changed, but not the fact that I am right
	-- Daniel Vogel

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE67BnoEjn3CY6VDgARAk8oAJ9y2/afaKNeNMa1bQc38Whfri3NCQCgiZ1b
l78ZsSncBHWTw8aczamYyFk=
=ETbm
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
