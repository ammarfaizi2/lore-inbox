Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263108AbTJUNwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 09:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbTJUNwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 09:52:30 -0400
Received: from trantor.org.uk ([213.146.130.142]:21435 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S263108AbTJUNw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 09:52:28 -0400
Subject: Re: [patch] updated exec-shield patch, 2.4/2.6 -G4
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.56.0310211330290.6034@earth>
References: <Pine.LNX.4.56.0310211330290.6034@earth>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3cbCtLfn1EUEzRculPSE"
Message-Id: <1066744326.661.4.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 21 Oct 2003 15:52:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3cbCtLfn1EUEzRculPSE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-10-21 at 13:37, Ingo Molnar wrote:
> Changes in -G4:
>=20
>  - bugfix in the 2.6 patches, certain applications segfaulted when the=20
>    stack limit was set to unlimited. (Roland McGrath)
>=20
>  - PIE bugfix: for certain ELF layouts the kernel loader ended up=20
>    overmapping ld.so resulting in broken applications. (Jakub Jelinek, me=
)
>=20
>  - port to 2.6.0-test8-mm1. (Valdis Kletnieks, me)
>=20
> reports, comments welcome. Enjoy it,

This seems to fix my problem with cp randomly segfaulting.

woohoo, thankyou! :)

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D


--=-3cbCtLfn1EUEzRculPSE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/lToGkbV2aYZGvn0RAljPAJ94lFu6yvYmScQ989EQeWU7ldKs+QCdHYCi
du7vbfPjs6qSaNqxBe2Duh8=
=x4B8
-----END PGP SIGNATURE-----

--=-3cbCtLfn1EUEzRculPSE--

