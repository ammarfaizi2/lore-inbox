Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVA1R4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVA1R4E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 12:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbVA1Rxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 12:53:54 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:5268 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S261508AbVA1Rsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 12:48:31 -0500
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <20050128174046.GR28047@stusta.de>
References: <1106932637.3778.92.camel@localhost.localdomain>
	 <20050128174046.GR28047@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-W0FPT+M7ldwIoKd8asTn"
Date: Fri, 28 Jan 2005 18:47:55 +0100
Message-Id: <1106934475.3778.98.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-W0FPT+M7ldwIoKd8asTn
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El vie, 28-01-2005 a las 18:40 +0100, Adrian Bunk escribi=F3:
> On Fri, Jan 28, 2005 at 06:17:17PM +0100, Lorenzo Hern=E1ndez Garc=EDa-Hi=
erro wrote:
> >...
> > As it's impact is minimal (in performance and development/maintenance
> > terms), I recommend to merge it, as it gives a basic prevention for the
> > so-called system fingerprinting (which is used most by "kids" to know
> > how old and insecure could be a target system, many time used as the
> > first, even only-one, data to decide if attack or not the target host)
> > among other things.
> >...
>=20
> "basic prevention"?
> I hardly see how this patch makes OS fingerprinting by e.g. Nmap=20
> impossible.

That's an example, as you can find at the grsecurity handbook [1]:

"The default Linux TCP/IP-stack has some properties that make it more
vulnerable to prediction-based hacks. By randomizing several items,
predicting the behaviour will be a lot more difficult."

"Randomized IP IDs hinders OS fingerprinting and will keep your machine
from being a bounce for an untraceable portscan."

References:
 [1]: http://www.gentoo.org/proj/en/hardened/grsecurity.xml

Cheers,
PS: Thanks for CC'ing me, I forgot to mention that I'm not subscribed to
the list, I just read the archives and reply by getting the original
mbox-formatted messages.=20
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-W0FPT+M7ldwIoKd8asTn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB+nrLDcEopW8rLewRAqCpAJ90SC3E+qh5YMa8FwJg1uDhjlJMAQCgsYmN
D/m5RnsQux/TtLsYKaCXIKs=
=r6iM
-----END PGP SIGNATURE-----

--=-W0FPT+M7ldwIoKd8asTn--

