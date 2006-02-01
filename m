Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422883AbWBATR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422883AbWBATR0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 14:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422885AbWBATR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 14:17:26 -0500
Received: from bender.bawue.de ([193.7.176.20]:10221 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S1422883AbWBATRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 14:17:24 -0500
Date: Wed, 1 Feb 2006 20:13:18 +0100
From: Joerg Sommrey <jo@sommrey.de>
To: "Brown, Len" <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, arjan@infradead.org,
       Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Message-ID: <20060201191318.GC17225@sommrey.de>
Mail-Followup-To: "Brown, Len" <len.brown@intel.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, arjan@infradead.org,
	Tony Lindgren <tony@atomide.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005E907CA@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005E907CA@hdsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2006 at 01:11:36PM -0500, Brown, Len wrote:
> =20
> >>  This patch can also be found at
> >>  http://www.sommrey.de/amd76x_pm/amd76x_pm-2.6.15-4.patch
> >>=20
> >>  In this version more locking was added to make sure all or=20
> >>  no CPU enter C3 mode.
> >>=20
> >>  Signed-off-by: Joerg Sommrey <jo@sommrey.de>
> >
> >Thanks.  I'll merge this into -mm and shall plague the ACPI=20
> >guys with it.=20
> >They have said discouraging things about board-specific drivers in the
> >past.  We shall see.
>=20
> Linux/ACPI has had generic supported SMP deep (> C1) C-states
> for a few months now and AFAIK it is working fine.
> Why is a platform specific driver needed for these boards?

I didn't get the ACPI C3 states working.

-jo

--=20
-rw-r--r--  1 jo users 63 2006-02-01 19:10 /home/jo/.signature

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD4QhOfR1xMzp2KuERAgmrAKCdi4RbKrjwo7qHp1InH58d6F71TQCfULId
ZqT2y4OnC9k1Jn+Vz9AEdQI=
=vKcl
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
