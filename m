Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUEFMpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUEFMpF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 08:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUEFMpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 08:45:05 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:19671 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S261358AbUEFMpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 08:45:00 -0400
Date: Thu, 6 May 2004 08:44:54 -0400
From: "Zephaniah E. Hull" <warp@babylon.d2dc.net>
To: Andrew Morton <akpm@osdl.org>
Cc: eric.valette@free.fr, linux-kernel@vger.kernel.org
Subject: Re: RE : 2.6.6-rc3-mm2 : REGPARAM forced => no external module with some object code only
Message-ID: <20040506124454.GA12921@babylon.d2dc.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	eric.valette@free.fr, linux-kernel@vger.kernel.org
References: <4098D65D.9010107@free.fr> <20040505131809.10bdcae6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20040505131809.10bdcae6.akpm@osdl.org>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 05, 2004 at 01:18:09PM -0700, Andrew Morton wrote:
> Eric Valette <eric.valette@free.fr> wrote:
> >
> > The Changelog says nothing really important but forcing REGPARAM is=20
> >  rather important : it breaks any external module using object only cod=
e=20
> >  that calls a kernel function.
>=20
> This is why we should remove the option - to reduce the number of ways in
> which the kernel might have been built.  Yes, there will be a bit of
> transition pain while these people catch up.

Any guess on when REGPARAM and 4KSTACKS will end up in Linus' tree?
(Of interest because people may not consider it that important until
they know it really is going to bite them.)

--=20
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

"Microsoft is a cross between the Borg and the Ferengi.  Unfortunately,
they use Borg to do their marketing and Ferengi to do their
programming."
  -- Simon Slavin in asr

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAmjNGRFMAi+ZaeAERAmzqAKCIaP3jMcwuWraPOG8qLnIJmICHVACfXez2
U3A06Du2lUIWVzdMyGyxQd0=
=xjRH
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
