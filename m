Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270291AbTGMQqI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270292AbTGMQqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:46:08 -0400
Received: from daffy.hulpsystems.net ([64.246.21.252]:48347 "EHLO
	daffy.hulpsystems.net") by vger.kernel.org with ESMTP
	id S270291AbTGMQqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:46:01 -0400
Subject: Re: Could not open debufiles.list on Redhat 9 kernel compile
From: Martin List-Petersen <martin@list-petersen.dk>
To: Jay Denebeim <denebeim@deepthot.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <slrnbh2vlf.ia6.denebeim@hotblack.deepthot.org>
References: <slrnbh2vlf.ia6.denebeim@hotblack.deepthot.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-BD5ycnS6A7Mxd/7erxk9"
Organization: 
Message-Id: <1058115633.15138.17.camel@loke>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Jul 2003 19:00:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BD5ycnS6A7Mxd/7erxk9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Yep .. all -b switches have been moved from rpm to rpmbuild.

So if you edit the Makefile, replacing call of "rpm" with "rpmbuild" it
works.

Regards,
Martin List-Petersen
martin at list-petersen dot dk
--
Twas FORTRAN as the doloop goes
        Did logzerneg the ifthen block
All kludgy were the function flows
        And subroutines adhoc.
=20
Beware the runtime-bug my friend
        squrooneg, the false goto
Beware the infiniteloop
        And shun the inprectoo.
                -- "OUTCONERR," to the scheme of "Jabberwocky"


On Sun, 2003-07-13 at 17:45, Jay Denebeim wrote:
> I've seen quite a few references to this with google, I haven't seen a
> solution.  The problem is making a stock kernel with 'make rpm' on a
> redhat 9 system.  Redhat has done something to rpm with version 9 that
> is causing it to create a debug package for every package you make.
> Unfortunately whatever it's doing is busted for stock kernels.
>=20
> I've been unable to find a way to turn off this generation.  There is
> a variable %_enable_debug_packages 1 in the redhat macros, I've turned
> it off, but that hasn't helped.
>=20
> So, how do I disable this 'feature'?  Does anyone know?
>=20
> Jay

--=-BD5ycnS6A7Mxd/7erxk9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EZAxzAGaxP8W1ugRAmtOAKDsL1kwX2Ka8KoabxXPein3O4SqrwCgzGDJ
1u1GMOQHFGSvna4AJAUmF78=
=yTpx
-----END PGP SIGNATURE-----

--=-BD5ycnS6A7Mxd/7erxk9--

