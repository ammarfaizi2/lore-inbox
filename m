Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVJOUii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVJOUii (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 16:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVJOUii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 16:38:38 -0400
Received: from wg.technophil.ch ([213.189.149.230]:32444 "HELO
	hydrogenium.schottelius.org") by vger.kernel.org with SMTP
	id S1751226AbVJOUii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 16:38:38 -0400
Date: Sat, 15 Oct 2005 22:38:24 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Nico Schottelius <nico-kernel@schottelius.org>,
       Christian Kujau <evil@g-house.de>, LKML <linux-kernel@vger.kernel.org>,
       Daniel Aubry <kernel-obri@chaostreff.ch>
Subject: Re: Some problems with 2.6.13.4
Message-ID: <20051015203824.GN12774@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Christian Kujau <evil@g-house.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Aubry <kernel-obri@chaostreff.ch>
References: <20051015122131.GG8609@schottelius.org> <43511AB1.3010608@g-house.de> <20051015154048.GK8609@schottelius.org> <20051015200245.GM12774@schottelius.org> <9a8748490510151322w25063287u567ecb698037fc4d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p1Od3smaOkJqivj4"
Content-Disposition: inline
In-Reply-To: <9a8748490510151322w25063287u567ecb698037fc4d@mail.gmail.com>
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.13.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p1Od3smaOkJqivj4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jesper Juhl [Sat, Oct 15, 2005 at 10:22:22PM +0200]:
> On 10/15/05, Nico Schottelius <nico-kernel@schottelius.org> wrote:
> [snip]
> > Could we somehow debug this differently or do I have to install
> > 2.6.13.2 and 2.6.13.1, too? It would take simply hours until it is
> > finished here.
> >
>=20
> If you have another, faster, machine available you could build the
> kernel(s) on that one.


Actually, one of my fastest machines is this one:

bruehe2# cat /proc/cpuinfo=20
[...]
model name      : Pentium III (Katmai)
cpu MHz         : 551.280
[...]

And one, which has a not-so-good connection to me.

> You don't have to build a kernel on the same
> machine that is later supposed to run it.

That's clear :-)

> Also, if you have more than one machine (even if they are not
> especially fast) then you can use distcc (http://distcc.samba.org/) to
> distribute the build over multiple machines which can speed up a build
> a great deal.

distcc will fail here, because of different gccs and different distributions
(ever tried to use gentoo and distcc in the same distcc-network? It's a real
pain).

Thanks for the hints anyway,

Nico

--=20
Latest project: cconfig (http://nico.schotteli.us/papers/linux/cconfig/)
Open Source nutures open minds and free, creative developers.

--p1Od3smaOkJqivj4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQIVAwUBQ1Fov7OTBMvCUbrlAQJJXxAAhKKGcYVzHaKeg5TZZ67zvu17CkLYfIsI
VYxJcxyljbJQo+ko18BHfyIiaguv9GFf3OYwq0bAqdOlIETrzt2gToYKUXhG1Ru1
VtBi1k+lXD1QgcL60O2o+X5uFVI9im9gY+3tiPAN+ziFckHl7L4PqqbgKqc2ZrCE
djeRn2OxvrwzEOMBd7gUBrknxLeoR6ddqjIUuZgGdosFmTZgf8q9hIUPYuX7XZ0s
/hmRiwYFIKgJ3adHbVjIxJMmNPg2oeHmGcMJFS8jrfv7KLxau5iRmtGY7Qa2Bb2R
KNFDQngBwZ8M+q+dJz3oUddZMKX1JB6QOxaHQSrPdK0qgWDlDgVB7tRenfOMp5u5
3+LG7O9nM2GUyi5hrF3/ZlDJ6cDEgsIpTuQz/COwGHQM8JqETnzIdGEU83oE0B/X
QsFx5v7wgqf0xYE3xSyIIoUBF0MHHeDOenzZa2imNgbsJgzaRRarSzcFEc5IuUmG
xmm0WANrlszokH6gkQbLO+Ij2zPb2VewtC6/pMxHjgjH4m+Yff8XOUvkHkSIrucV
U4qtAbOS2Xoo9n7kTRTsV4zY1UaRIrcPZRrwy14UH5aKqxmKlobBm5xWEyLAQL+v
i/oSRllmweqcGbQm7MtCDfAO3eP1tXE+xh0pn7nBD8G4NCjw/GCMspMEy0kQrNG/
24et1n+oHQM=
=P35P
-----END PGP SIGNATURE-----

--p1Od3smaOkJqivj4--
