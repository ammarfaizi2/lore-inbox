Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266123AbUAUXh2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264283AbUAUXh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:37:28 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:47831 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S266198AbUAUXfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:35:03 -0500
Date: Thu, 22 Jan 2004 00:19:38 +0100
From: GCS <gcs@lsc.hu>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: 2.6.1-mm5 - oops during network initialization
Message-ID: <20040121231937.GA20618@lsc.hu>
References: <20040120000535.7fb8e683.akpm@osdl.org> <200401210638.i0L6cpeU003057@turing-police.cc.vt.edu> <Pine.LNX.4.58.0401211024520.28511@hosting.rdsbv.ro> <20040121154627.GB10508@lsc.hu> <200401211659.i0LGxqHX002960@turing-police.cc.vt.edu> <20040121105836.526c943b.akpm@osdl.org> <200401211935.i0LJZ7Qd003905@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <200401211935.i0LJZ7Qd003905@turing-police.cc.vt.edu>
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2004 at 02:35:07PM -0500, Valdis.Kletnieks@vt.edu <Valdis.K=
letnieks@vt.edu> wrote:
> On Wed, 21 Jan 2004 10:58:36 PST, you said:
> > Valdis.Kletnieks@vt.edu wrote:
> > >
> > > On Wed, 21 Jan 2004 16:46:27 +0100, GCS said:
> > >=20
> > > > > > CONFIG_IPV6_PRIVACY=3Dy
> > > >  Can you both try it without the above? At least it's solved my pro=
blem,=20
> and
> > > > I can have 'CONFIG_IPV6=3Dy' and ipv6 netfilter options as modules.
> > >=20
> > > Confirm on that.  Same config, turn off CONFIG_IPV6_PRIVACY, and the
> > > kernel boots just fine.  I'm willing to test patches if needed....
> > >=20
> >=20
> > Which kernel fails to boot?  There were ipv6 fixes applied to 2.6.2-rc1.
>=20
> 2.6.1-mm4 worked, 2.6.1-mm5 failed, haven't tried 2.6.2-rc1 (will do so t=
his evening).
 2.6.2-rc1 does _not_ have this problem, it is caused by a patch Andrew
applied between 2.6.1-mm4 and -mm5; only affects if CONFIG_IPV6_PRIVACY
is set.
GCS

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFADwkJaLTE7bG/hdERAkXQAJ9d+tLrLddd2+4IwtmbZNPOFWt25ACeJgJr
ropmUvCRhwpDsVaMd6G1Ya0=
=B+s1
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
