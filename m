Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbUAIT73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 14:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUAIT72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 14:59:28 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:15277 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263424AbUAIT7L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 14:59:11 -0500
Date: Sat, 10 Jan 2004 08:43:55 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: PATCH 1/2: Make gotoxy & siblings use unsigned variables
In-reply-to: <Pine.LNX.4.53.0401091415430.571@chaos>
To: root@chaos.analogic.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1073677435.2069.23.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-RFafQXNWU1uJdvY+ioUZ";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1073672901.2069.15.camel@laptop-linux>
 <Pine.LNX.4.53.0401091415430.571@chaos>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RFafQXNWU1uJdvY+ioUZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

You might be right. I was just being consistent with the other
definitions. Andrew? Benjamin?

Regards,

Nigel

On Sat, 2004-01-10 at 08:22, Richard B. Johnson wrote:
> On Sat, 10 Jan 2004, Nigel Cunningham wrote:
>=20
> > This patch makes console X and Y coordinates unsigned, rather than
> > signed. Issues with wide (> 128 char?) consoles, seen when developing
> > Software Suspend's 'nice display' are thus fixed. A brief examination o=
f
> > related code showed that this use of signed variables was the exception
> > rather than the rule.
> >
> > Regards,
> >
> > Nigel
> [SNIPPED...]
>=20
> Question: Shouldn't we be using "size_t" for unsigned int, and
> "ssize_t" for signed? If the "ints" are going to be changed,
> they probably should be changed only once. As I recall, size_t
> was the largest unsigned int that would fit into a register and
> ssize_t was the largest signed int that would fit.
>=20
> Cheers,
>=20
> Dick Johnson
> Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
>             Note 96.31% of all statistics are fiction.
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-RFafQXNWU1uJdvY+ioUZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA//wR6VfpQGcyBBWkRAmqTAJ9bNqun67g6dfhzqfuoGMNL1epdWACdGIXg
aABwb3EralXeWrC6KvphRKY=
=Fb7D
-----END PGP SIGNATURE-----

--=-RFafQXNWU1uJdvY+ioUZ--

