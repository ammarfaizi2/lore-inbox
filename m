Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRAFAQ1>; Fri, 5 Jan 2001 19:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbRAFAQS>; Fri, 5 Jan 2001 19:16:18 -0500
Received: from mgate2.uni-hannover.de ([130.75.2.5]:64406 "EHLO
	mgate2.uni-hannover.de") by vger.kernel.org with ESMTP
	id <S129267AbRAFAQF>; Fri, 5 Jan 2001 19:16:05 -0500
Date: Sat, 6 Jan 2001 01:15:33 +0100
From: Lukas Dobrek <dobrek@itp.uni-hannover.de>
To: linux-kernel@vger.kernel.org
Subject: Problem with compiling 2.2.18 on AXP
Message-ID: <20010106011533.A1344@alya.uni-hannover.de>
Mail-Followup-To: Lukas Dobrek <dobrek>, linux-kernel@vger.kernel.org
User-Agent: Mutt/1.2.5i
MIME-version: 1.0
Content-type: multipart/signed; boundary="fdj2RfSjLxBAspz7"; micalg="pgp-md5"; protocol="application/pgp-signature"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,
I've following problem with compiling kernel-2.2.18 on AXP machine:

make -C  arch/alpha/lib
make[1]: Entering directory `/home/users/builder/rpm/BUILD/linux/arch/alpha=
/lib'
/usr/bin/kgcc -D__KERNEL__ -I/home/users/builder/rpm/BUILD/linux/include -D=
__ASSEMBLY__  -c -o stxcpy.o stxcpy.S
stxcpy.S:22: alpha/regdef.h: No such file or directory
make[1]: *** [stxcpy.o] Error 1

Surprisingly this is true, this file exist only in asm-mips.=20

Best Regards
Lukasz Dobrek


--=20
=A3ukasz Dobrek
Institut f=FCr Theoretische Physik
Appelstra=DFe 2, 30167 Hannover, Germany
e-mail:dobrek@itp.uni-hannover.de

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6VmOkEMOMSYY3nYoRAo9dAJ4v1Y5U8hFHJtmT1pa908WKzdV3YACcDh9B
FdPwuN9xp7qaNxZlXD5kykQ=
=avAa
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
