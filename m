Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265369AbUADLK6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 06:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265376AbUADLK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 06:10:58 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:36264 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265369AbUADLK4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 06:10:56 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Con Kolivas <kernel@kolivas.org>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Willy Tarreau <willy@w.ods.org>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
In-Reply-To: <200401041949.27408.kernel@kolivas.org>
References: <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>
	 <200401041242.47410.kernel@kolivas.org>
	 <1073203762.9851.394.camel@localhost>
	 <200401041949.27408.kernel@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xRbmMezueOpdyL+nI4qt"
Message-Id: <1073214820.6075.254.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 04 Jan 2004 13:13:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xRbmMezueOpdyL+nI4qt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-01-04 at 10:49, Con Kolivas wrote:

> > I added a fprintf(stderr, "%d\n", amount); to that code and indeed
> > amount was *always* 1 no matter what I did (it even was 1 when the
> > (dmesg/...) output came in fast). And jump scrolling would take place i=
f
> > amount > 59 in my case... can this still be not a schedulers issue ?
> >
>=20
> > Looking at that how can it not be a scheduling problem ....
>=20
> Scheduling problem, yes; of a sort.
>=20
> Solution by altering the scheduler, no.=20
>=20
> My guess is that turning the xterm graphic candy up or down will change t=
he=20
> balance. Trying to be both gui intensive and a console is where it's=20
> happening. On some hardware you are falling on both sides of the fence wi=
th=20
> 2.6 where previously you would be on one side.
>=20

So its Ok for 'eye candy' to 'lag', but xmms should not skip?  Anyhow,
its xterm that he have issues with, not gnome-terminal or such with
transparency.  I smell something ...


--=20
Martin Schlemmer

--=-xRbmMezueOpdyL+nI4qt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/9/VkqburzKaJYLYRAiqUAJ9vZsZ3Pl+wvKr3QvzM5dlCf4yqigCgl/2K
Fs7FUoUCh29OEx7mn0qQrTI=
=UcjM
-----END PGP SIGNATURE-----

--=-xRbmMezueOpdyL+nI4qt--

