Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbVDEVoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbVDEVoN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVDEVmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:42:51 -0400
Received: from rzlab.ucr.edu ([138.23.92.77]:14997 "EHLO
	epsilon.donarmstrong.com") by vger.kernel.org with ESMTP
	id S261872AbVDEVhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:37:21 -0400
Date: Tue, 5 Apr 2005 14:37:16 -0700
From: Don Armstrong <don@debian.org>
To: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050405213716.GT5814@archimedes.ucr.edu>
Mail-Followup-To: debian-legal@lists.debian.org
References: <87ekdq1xlp.fsf@sanosuke.troilus.org> <20050404141647.GA28649@pegasos> <20050404175130.GA11257@kroah.com> <20050404182753.GC31055@pegasos> <20050404191745.GB12141@kroah.com> <20050404192945.GB1829@pegasos> <20050404205527.GB8619@thunk.org> <20050404211931.GB3421@pegasos> <1112689164.3086.100.camel@icampbell-debian> <20050405152159.GB25311@pegasos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AGZzQgpsuUlWC1xT"
Content-Disposition: inline
In-Reply-To: <20050405152159.GB25311@pegasos>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AGZzQgpsuUlWC1xT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[MFT set to -legal, as this is becoming legal arcana probably not
particularly interesting to any other list.]

On Tue, 05 Apr 2005, Sven Luther wrote:
> There are two solutions to this issue, either you abide by the GPL
> and provide also the source code of those firmware binaries (the
> prefered solution :), or you modify the copyright statement of these
> files, to indicate that even thought the file per se is under the
> GPL, the firmware binary code is not, and give us a licence to
> distribute it. Something akin to :
>=20
> /* This program, except the firmware binary code,  is free software; you =
can  */
> /* redistribute it and/or modify it under the terms of the GNU General Pu=
blic */
> /* License as published by the Free Software Foundation, located in the f=
ile  */
> /* LICENSE.                                                              =
     */
> /* Distribution, either as is or modified syntactically to adapt to the  =
     */
> /* layout of the surrounding GPLed code is allowed, provided this copyrig=
ht   */
> /* notice is acompanying it                                              =
     */

Just a word of warning: The wording above fails to make it clear what
the second clause is applying to. Additionally it has the following
restrictions that are probably not intended:

   1) Does not specifically allow this firware to be sold as part of an
      aggregate

   2) The range of modifications allowed is rather vague, and implies
      that the firmware can't be extracted

I'd instead suggest applying a pre-existing license like MIT[1] to the
firmware portion of the code file, rather than inventing your own
licensing text that only partially deals with the problem(s) at issue.
(Inventing licensing text is quite often very hazardous to your
health.)


Don Armstrong

1: http://www.opensource.org/licenses/mit-license.php
--=20
Build a fire for a man, an he'll be warm for a day.  Set a man on  =20
fire, and he'll be warm for the rest of his life.
 -- Jules Bean

http://www.donarmstrong.com              http://rzlab.ucr.edu

--AGZzQgpsuUlWC1xT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCUwUMgcCJIoCND9ARAuj1AJ9DOrunY0ZEBefQlPc3aehTDBt65QCeLjA2
EWwdMLkDUBP+s4pDSd4YQto=
=stDb
-----END PGP SIGNATURE-----

--AGZzQgpsuUlWC1xT--
