Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263519AbTJWJfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 05:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbTJWJfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 05:35:16 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:17281 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263524AbTJWJfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 05:35:06 -0400
Date: Thu, 23 Oct 2003 11:35:05 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
Message-ID: <20031023093504.GP20846@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200310221855.15925.theman@josephdwagner.info> <200310221947.45996.theman@josephdwagner.info> <20031023012350.GI26476@redhat.com> <200310222135.22968.theman@josephdwagner.info>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eLzyubmMEGL80ZD1"
Content-Disposition: inline
In-Reply-To: <200310222135.22968.theman@josephdwagner.info>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eLzyubmMEGL80ZD1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-10-22 21:35:22 +0600, Joseph D. Wagner <theman@josephdwagner.i=
nfo>
wrote in message <200310222135.22968.theman@josephdwagner.info>:

> I respectivly disagree with those reasons.  -march is gcc flag.  If it=20
> creates any instability (doubtful), it's really a gcc problem.  Throwing =
it=20
> in will light a fire under their @$$ to get their act together.

It *may* happen that some things work a bit differently. This needn't be
an exact compiler error. It may be a Linux kernel source error. However,
these things are quite subtle so it might break things and you only see
it after a month or two, when you on-HDD data is already gone...

Changes like that need good tests and can't be done in a 2.4.x kernel
becase it may harm people's data or stability. These changes need to be
done in development kernels, hopefully when they start off, not when
they settle down to become the next stable release, though...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--eLzyubmMEGL80ZD1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/l6DIHb1edYOZ4bsRAgGAAJ0eziFctJ+mPt4WK/YWPS6XftCqYgCfW91v
mhr7gp2HwFrLpmD5deZ8CDk=
=Xgf4
-----END PGP SIGNATURE-----

--eLzyubmMEGL80ZD1--
