Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267835AbUHXNdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267835AbUHXNdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 09:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267799AbUHXNdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 09:33:37 -0400
Received: from trantor.org.uk ([213.146.130.142]:17590 "EHLO trantor.org.uk")
	by vger.kernel.org with ESMTP id S267810AbUHXNal (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 09:30:41 -0400
Subject: Re: setpeuid(pid_t, uid_t) proposal
From: Gianni Tedesco <gianni@scaramanga.co.uk>
To: Jerry Haltom <wasabi@larvalstage.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1093323005.1248.21.camel@localhost>
References: <1093323005.1248.21.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BJIWyxLpsgkZhSoRYBps"
Date: Tue, 24 Aug 2004 14:30:02 +0100
Message-Id: <1093354202.22729.15.camel@sherbert>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BJIWyxLpsgkZhSoRYBps
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-08-23 at 23:50 -0500, Jerry Haltom wrote:
> I want to propose a new base system function (and cooresponding
> syscall). I am tentivly calling this function setpeuid(). The function
> will be fairly simple:
>=20
> Only a process with uid 0 may call it. The first argument is a process
> id. The second argument is a uid. The function is effictivly the exact
> same as seteuid() except that it operates on another process. Very
> simple explanation, now here's why.

LOL pid_t? What if task calling the server dies before the server calls
setpeuid()? Some other users task may now get new credentials.

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/scaramanga.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-BJIWyxLpsgkZhSoRYBps
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBK0LZkbV2aYZGvn0RAkTZAJ9idtDbKQqxHbXtffCXT3SKZQ7mlACeJW9y
TWcFd+IqP2yEMcVU1vZTR4c=
=ro9f
-----END PGP SIGNATURE-----

--=-BJIWyxLpsgkZhSoRYBps--

