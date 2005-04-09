Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVDIIcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVDIIcd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 04:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVDIIcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 04:32:33 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:24042 "EHLO vagabond.light.src")
	by vger.kernel.org with ESMTP id S261315AbVDIIcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 04:32:11 -0400
Date: Sat, 9 Apr 2005 10:32:00 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Marcin Dalecki <martin@dalecki.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
Message-ID: <20050409083200.GA30521@vagabond>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050407074407.GA25194@vagabond> <f74102c2ddfe02b2d98d28e1a25a0634@dalecki.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <f74102c2ddfe02b2d98d28e1a25a0634@dalecki.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 09, 2005 at 03:01:29 +0200, Marcin Dalecki wrote:
>=20
> On 2005-04-07, at 09:44, Jan Hudec wrote:
> >
> >I have looked at most systems currently available. I would suggest
> >following for closer look on:
> >
> >1) GNU Arch/Bazaar. They use the same archive format, simple, have the
> >   concepts right. It may need some scripts or add ons. When Bazaar-NG
> >   is ready, it will be able to read the GNU Arch/Bazaar archives so
> >   switching should be easy.
>=20
> Arch isn't a sound example of software design. Quite contrary to the=20

I actually _do_ agree with you. I like Arch, but it's user interface
certainly is broken and some parts of it would sure needs some redesign.

> random notes posted by it's author the following issues did strike me=20
> the time I did evaluate it:
>=20
> The application (tla) claims to have "intuitive" command names. However
> I didn't see that as given. Most of them where difficult to remember
> and appeared to be just infantile. I stopped looking further after I=20
> saw:
>=20
> tla my-id instead of: tla user-id or oeven tla set id ...
>=20
> tla make-archive instead of tla init

In this case, tla init would be a lot *worse*, because there are two
different things to initialize -- the archive and the tree. But
init-archive would be a little better, for consistency.

> tla my-default-archive john@dole.com--2005-VersionPatrol

This one is kinda broken. Even in concept it is.

> No more "My Compuer" please...
>=20
> Repository addressing requires you to use informally defined
> very elaborated and typing error prone conventions:
>=20
> mkdir ~/{archives}

*NO*. Usng this is name is STRONGLY recommended *AGAINST*. Tom once used
it in the example or in some of his archive and people started doing it,
but it's a compelete bogosity and it is not required anywhere.

> tla make-archive john@dole.com--20005-VersionPatrol=20
> ~/{archives}/2005-VersionPatrol
>=20
> You notice the requirement for two commands to accomplish a single task=
=20
> already well denoted by the second command? There is more of the same
> at quite a few places when you try to use it. You notice the triple
> zero it didn't catch?

I sure do. But the folks writing Bazaar are gradually fixing these.
There is a lot of them and it's not that long since they started, so
they did not fix all of them yey, but I think they eventually will.

> As an added bonus it relies on the applications named by accident
> patch and diff and installed on the host in question as well as few=20
> other as well to
> operate.

No. The build process actually checks that the diff and patch
applications are actually the GNU Diff and GNU Patch in sufficiently
recent version. It's was not always the case, but now it does.

> Better don't waste your time with looking at Arch. Stick with patches
> you maintain by hand combined with some scripts containing a list of=20
> apply commands
> and you should be still more productive then when using Arch.

I don't agree with you. Using Arch is more productive (eg. because it
does merges), but certainly one could do a lot better than Arch does.

---------------------------------------------------------------------------=
----
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCV5MARel1vVwhjGURAsYjAJ9FHtlyHbAKFteF9lEUrfF8vLF+ygCgoIJf
XUZGsIFPYDVKe74NYYgh5L4=
=mcXM
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
