Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTJSNRR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 09:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTJSNRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 09:17:17 -0400
Received: from mail.gondor.com ([212.117.64.182]:9483 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S262130AbTJSNRO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 09:17:14 -0400
Date: Sun, 19 Oct 2003 15:17:02 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Promise IDE patches
Message-ID: <20031019131702.GA13067@gondor.com>
References: <20030826223158.GA25047@gondor.com> <200308270054.27375.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <200308270054.27375.bzolnier@elka.pw.edu.pl>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Bartolomeij, hi Marcelo!

Two months ago, I had problems with a >137GB drive on a promise
controller. These where fixed by a few patches, and the computer runs
fine since then with a patched 2.4.22 kernel.

Unfortunately, as far as I can see, none of the patches got applied to
2.4.23-pre7. I know that Alan had a few objections against the patches,
and they should be addressed, but as things are now, plain 2.4.23-pre7
would lead to severe data corruption if I used it on my computer.

For reference, here is the complete mail where Bartolomeij asked Marcelo
to apply the patches:

On Wed, Aug 27, 2003 at 12:54:27AM +0200, Bartlomiej Zolnierkiewicz wrote:
> Marcelo can you apply these patches?
>=20
> On Wednesday 27 of August 2003 00:31, Jan Niehusmann wrote:
> > Hi!
> >
> > Two weeks ago, I tried two patches against 2.4.21 regarding LBA48
> > support. One limits the size of a drive to 137GB if LBA48 is not
> > available. Without this patch, severe data corruption is possible.
> >
> > http://gondor.com/linux/patch-limit48-2.4.21
> >
> > The other one is making LBA48 support work with pdc 20265 controllers.
> >
> > http://gondor.com/linux/patch-pdc-lba48-2.4.22
> >
> > I think they should be candidates for inclusion in 2.4.23, as well as
> > a fix for hdparm -I (and other commands going directly to the drive) on
> > (some?) promise controllers:
> >
> > http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D104250818527780&w=3D2
> >
> > Jan

Alan mentioned problems with patches 1 and 3, but AFAIK nobody had
problems with patch 2. Consult the archives for details, it's all been
on linux-kernel.

Even though I could easily fix 2.4.23 for myself, I'd really like to
have the official kernel work without local patches. And I guess an
increasing number of people is using drives >137GB, so it can easily hit
other people as well.

Jan


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/ko7OnIUccvEtoGURAqqAAJwNGTLl7QrYvVdrMC+6oahrh4FnZQCfeCzD
su4PYWQsJmrR0tx7T4itbGo=
=4sxv
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
