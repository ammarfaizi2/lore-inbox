Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUFQQJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUFQQJS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 12:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUFQQJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 12:09:18 -0400
Received: from cpe-66-1-88-111.az.sprintbbd.net ([66.1.88.111]:16351 "EHLO
	pointless.epfarms.net") by vger.kernel.org with ESMTP
	id S264857AbUFQQJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 12:09:16 -0400
Date: Thu, 17 Jun 2004 12:08:56 -0400
From: Josh Myer <josh@joshisanerd.com>
To: linux-kernel@vger.kernel.org
Subject: Finalized FPU Crash Fix?
Message-ID: <20040617160856.GA1470@brevity>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello everybody,

Is there a general concensus that the one-liner in 2.6.7 is an
appropriate fix for the FPU hang/crash bug?  I have several machines
running 2.4.x which require that outside people have shell access.
Needless to say, I'm somewhat nervous about this problem =3D)

I'm trying to find a nice balance between potential downtime due to=20
malicious users and loss of functionality/b0rkedness due to unforeseen
bugs in quick fixes.  I've seen at least three different solutions to=20
this problem; two of them have confirmed negative side-effects.  Noone
seems to have complained about the one-liner.  Does anyone foresee=20
problems here, or should this be the correct fix (it seems right to me,
but my CPU-level voodoo is weak).

Thanks in advance,
--=20
/jbm, but you can call me Josh. Really, you can.

 "People shouldn't see man-made global disasters as a bad thing, they
  should see them as scientific breakthroughs waiting to happen."
   -- The Onion

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0cIYUoQYZUBPGMMRArIiAJ9LHYt7NXI6Xr8cxrI1g/9hSdmrfwCcCwIa
UQPkSzMlUWDm4AeDjLIc/To=
=WRBj
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
