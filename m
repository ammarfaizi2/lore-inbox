Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSIITag>; Mon, 9 Sep 2002 15:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318794AbSIITag>; Mon, 9 Sep 2002 15:30:36 -0400
Received: from florin.dsl.visi.com ([209.98.146.184]:44901 "EHLO
	bird.iucha.org") by vger.kernel.org with ESMTP id <S318139AbSIITaf>;
	Mon, 9 Sep 2002 15:30:35 -0400
Date: Mon, 9 Sep 2002 14:35:19 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.34
Message-ID: <20020909193519.GD7683@iucha.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0209091049180.11925-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209091049180.11925-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook: Where do you want [your files] to go today?
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It compiled fine but make modules_install failed with:
if [ -r System.map ]; then /sbin/depmod -ae -F System.map 2.5.34-my; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.34-my-xfs/kernel/fs/auto=
fs4/autofs4.o
depmod:         recalc_sigpending
depmod: *** Unresolved symbols in /lib/modules/2.5.34-my-xfs/kernel/fs/lock=
d/lockd.o
depmod:         recalc_sigpending
depmod: *** Unresolved symbols in /lib/modules/2.5.34-my-xfs/kernel/fs/nfsd=
/nfsd.o
depmod:         recalc_sigpending
depmod: *** Unresolved symbols in
/lib/modules/2.5.34-my-xfs/kernel/fs/smbfs/smbfs.o
depmod:         recalc_sigpending
depmod: *** Unresolved symbols in /lib/modules/2.5.34-my-xfs/kernel/net/sun=
rpc/sunrpc.o
depmod:         recalc_sigpending
bear:/usr/local/src/linux-my-34# grep SUN .config
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_SUNLANCE is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNGEM is not set
# CONFIG_SUNDANCE is not set
# CONFIG_KEYBOARD_SUNKBD is not set
CONFIG_SUNRPC=3Dm
bear:/usr/local/src/linux-my-34# grep -i autofs .config
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=3Dm

Of course, the same config yielded a working kernel with 2.5.33 .

Cheers,
florin

--=20

"If it's not broken, let's fix it till it is."

41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9fPf2NLPgdTuQ3+QRAuwKAJ0S+vFhlhZW8xDOYPhtrbtTPWdZVACfT/Bk
DvyCUrrTOf55XGsmgEitI2Y=
=R6FC
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
