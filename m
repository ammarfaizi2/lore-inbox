Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262431AbSI2JiL>; Sun, 29 Sep 2002 05:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262434AbSI2JiL>; Sun, 29 Sep 2002 05:38:11 -0400
Received: from zeus.kernel.org ([204.152.189.113]:43956 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262431AbSI2JiK>;
	Sun, 29 Sep 2002 05:38:10 -0400
Subject: Re: Kernel BUG  at page_alloc.c:91!
From: Arjan van de Ven <arjanv@redhat.com>
To: Erik Ljungstroem <erik.ljungstrom@metalab.unc.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0209290203320.25035-100000@whatever.mjaha.org>
References: <Pine.LNX.4.44.0209290203320.25035-100000@whatever.mjaha.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-7w008dgtrty+0OhJisIJ"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Sep 2002 11:30:52 +0200
Message-Id: <1033291852.2419.0.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7w008dgtrty+0OhJisIJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2002-09-29 at 02:23, Erik Ljungstroem wrote:
> Hi!
>=20
> The following bug just appeared out of the blue.
>=20
> I will try and stick to the bug-reporting procedure from
> http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html
>=20
> I had just played a game which gave the following message in dmesg:
> Out of Memory: Killed process 24115 (fakk2).
> My harddrive just started working very intence, and I was thrown out to
> gnome within a second or two.
> Minutes later another process (xchat) just crashed, this time dmesg didn'=
t
> say anything about out of memory, but gave me this:
>=20
>  kernel BUG at page_alloc.c:91!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c012b86d>]    Tainted: P

typical nvidia oops. Are you using the nvidia binary only drivers?


--=-7w008dgtrty+0OhJisIJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9lshMxULwo51rQBIRAkuZAJ9Sd/0oAO15lRpkPxsAegmFhEiGhACfXIjM
xFES+3vzempEx+YRfH3Xb7E=
=3yw1
-----END PGP SIGNATURE-----

--=-7w008dgtrty+0OhJisIJ--

