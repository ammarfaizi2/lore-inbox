Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263608AbTIBIIS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 04:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263603AbTIBIIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 04:08:18 -0400
Received: from main.gmane.org ([80.91.224.249]:30669 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263608AbTIBIIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 04:08:10 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Date: Tue, 02 Sep 2003 03:08:08 -0700
Message-ID: <m2bru3jyev.fsf@tnuctip.rychter.com>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@sea.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:IKC4T9r0290qYyA37+m6PNF042A=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

> I'd appreciate if folks would run the program below on various
> machines, especially those whose caches aren't automatically coherent
> at the hardware level.
>=20
> It searches for that address multiple which an application can use to
> get coherent multiple mappings of shared memory, with good performance.

From=20a Sharp Zaurus C-760. Not very interesting, I'm afraid:

Test separation: 4096 bytes: FAIL - too slow
Test separation: 8192 bytes: FAIL - too slow
Test separation: 16384 bytes: FAIL - too slow
Test separation: 32768 bytes: FAIL - too slow
Test separation: 65536 bytes: FAIL - too slow
Test separation: 131072 bytes: FAIL - too slow
Test separation: 262144 bytes: FAIL - too slow
Test separation: 524288 bytes: FAIL - too slow
Test separation: 1048576 bytes: FAIL - too slow
Test separation: 2097152 bytes: FAIL - too slow
Test separation: 4194304 bytes: FAIL - too slow
Test separation: 8388608 bytes: FAIL - too slow
Test separation: 16777216 bytes: FAIL - too slow
VM page alias coherency test: failed; will use copy buffers instead


Processor	: Intel XScale-PXA255 rev 6 (v5l)
BogoMIPS	: 397.31
Features	: swp half thumb fastmult edsp=20
CPU implementor	: 0x69
CPU architecture: 5TE
CPU variant	: 0x0
CPU part	: 0x2d0
CPU revision	: 6
Cache type	: undefined 5
Cache clean	: undefined 5
Cache lockdown	: undefined 5
Cache unified	: harvard
I size		: 16384
I assoc		: 16
I line length	: 32
I sets		: 32
D size		: 16384
D assoc		: 16
D line length	: 32
D sets		: 32

Hardware	: SHARP Shepherd
Revision	: 0000
Serial		: 0000000000000000

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/VGwMLth4/7/QhDoRAnT2AJ9OlOqqQbD122Ikx8DQ66ynwu01XwCeOPio
eFp1pINRUmpCisy1gDsJzZg=
=DpJ8
-----END PGP SIGNATURE-----
--=-=-=--

