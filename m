Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTLMVzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 16:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTLMVzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 16:55:24 -0500
Received: from mbox.serv4.servweb.de ([80.239.142.80]:37504 "EHLO
	serv4.servweb.de") by vger.kernel.org with ESMTP id S262805AbTLMVzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 16:55:22 -0500
Date: Sat, 13 Dec 2003 22:55:35 +0100
From: Patrick Plattes <patrick@erdbeere.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.23] kernel BUG at page_alloc.c:105!
Message-ID: <20031213215535.GC2422@erdbeere.net>
References: <20031213205231.GA2422@erdbeere.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <20031213205231.GA2422@erdbeere.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi ho :-),

actually it looks like a hardware problem. normaly the system has 32mr
ram. now i have removed the additional 16mb, so the system has only
16mb.

have a nice day,
patrick


On Sat, Dec 13, 2003 at 09:52:32PM +0100, Patrick Plattes wrote:
> hello,
>=20
> i try to use a ibm thinkpad 560e notebook and while booting the kernel
> <F9>stoped with this message (a screenshot from this notebook is here: [1=
])
>=20
> kernel BUG at page_alloc.c:105!
> invalid operand: 0000
> CPU:	0
> EIP	0010:[<c0128d07>]	Not tainted
> EFLAGS:	00010206
> eax: 00000000	ebx: c1000a6c	ecx: c1000a6c	edx: 00000000
> esi: 00000000	edi: c02af980	ebp: 00002000	esp: c0293f60
> ...
> ...
> ...
>=20
>=20
> i have to type this by hand from the notbook, so there may be typing
> errors. please have a look at the screenshot for the correct (and
> complete) errormessage. the page_alloc line (?) 105 changes sometimes=20
> from 105 to 103 or 106
>=20
> please send me an e-mail if you need to know more and i will send you
> the information as soon as i can.
>=20
> maybe anyone withe an idea? thanks,
> patrick
>=20
> [1] http://erdbeere.net/lkml1.jpeg



--=20
Das ggf. ang=E4ngende Attachment ist eine Signatur, erstellt mit GnuPG, die=
 es
erm=F6glicht die Korrektheit des Absenders zu best=E4tigen (www.gnupg.org).
Ich widerspreche der Nutzung oder =DCbermittling meiner Daten f=FCr Werbezw=
ecke=20
oder f=FCr die Markt- und Meinungsforschung. (=A728 Abs. 3 + 4 BDSG)

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/24rXQ7Xfys5M9aQRAsWNAKCVLcXkgIJylmQAaKuTTEWvSdDvpwCg7VYm
9MzPx/VoT3xkbewGxOyy6+4=
=TKD9
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
