Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUHMLDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUHMLDc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUHMLDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:03:32 -0400
Received: from dea.vocord.ru ([194.220.215.4]:40866 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261500AbUHMLCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:02:37 -0400
Subject: Re: [2.6 patch] let W1 select NET
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0408131253000.20634@scrub.home>
References: <20040813101717.GS13377@fs.tum.de>
	 <Pine.LNX.4.58.0408131231480.20635@scrub.home>
	 <1092394019.12729.441.camel@uganda>
	 <Pine.LNX.4.58.0408131253000.20634@scrub.home>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hA6NsINGMIX8N+3hdZwl"
Organization: MIPT
Message-Id: <1092395189.12729.448.camel@uganda>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 15:06:29 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hA6NsINGMIX8N+3hdZwl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-08-13 at 14:54, Roman Zippel wrote:
> Hi,
>=20
> On Fri, 13 Aug 2004, Evgeniy Polyakov wrote:
>=20
> > On Fri, 2004-08-13 at 14:32, Roman Zippel wrote:
> > > Hi,
> > >=20
> > > On Fri, 13 Aug 2004, Adrian Bunk wrote:
> > >=20
> > > >  config W1
> > > >  	tristate "Dallas's 1-wire support"
> > > > +	select NET
> > >=20
> > > What's wrong with a simple dependency?
> >=20
> > W1 requires NET, and thus depends on it.
> > If you _do_ want W1 then you _do_ need network and then NET must be
> > selected.
>=20
> A simple "depends on NET" does this as well, I see no reason to abuse=20
> select.

I think it does it in reverse order:
if we have NET then we _may_ select W1, but if we _need_ W1 and do not
know upon what it depends?

> bye, Roman
--=20
	Evgeniy Polyakov ( s0mbre )

Crash is better than data corruption. -- Art Grabowski

--=-hA6NsINGMIX8N+3hdZwl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBHKC1IKTPhE+8wY0RAmgJAKCDVe8ENWBLHGOHSH4isuwaHA1X5gCeL4uK
/4H1fLJ6FN2yfW1M4pAdUts=
=eEMu
-----END PGP SIGNATURE-----

--=-hA6NsINGMIX8N+3hdZwl--

