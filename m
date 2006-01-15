Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751877AbWAOIx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbWAOIx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 03:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWAOIx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 03:53:29 -0500
Received: from zlynx.org ([199.45.143.209]:3602 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S1751877AbWAOIx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 03:53:29 -0500
Subject: Re: Dual core Athlons and unsynced TSCs
From: Zan Lynx <zlynx@acm.org>
To: David Lang <dlang@digitalinsight.com>
Cc: Andreas Steinmetz <ast@domdv.de>, Sven-Thorsten Dietrich <sven@mvista.com>,
       thockin@hockin.org, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0601131701590.9821@qynat.qvtvafvgr.pbz>
References: <1137178855.15108.42.camel@mindpipe>
	 <Pine.LNX.4.62.0601131315310.9821@qynat.qvtvafvgr.pbz>
	 <20060113215609.GA30634@hockin.org>
	 <Pine.LNX.4.62.0601131404311.9821@qynat.qvtvafvgr.pbz>
	 <1137190698.2536.65.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0601131448150.9821@qynat.qvtvafvgr.pbz>
	 <43C848C7.1070701@domdv.de>
	 <Pine.LNX.4.62.0601131701590.9821@qynat.qvtvafvgr.pbz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HHoGdJnW/FIubpIpvRWy"
Date: Sun, 15 Jan 2006 01:52:44 -0700
Message-Id: <1137315165.28041.12.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HHoGdJnW/FIubpIpvRWy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-01-13 at 17:04 -0800, David Lang wrote:=20
> On Sat, 14 Jan 2006, Andreas Steinmetz wrote:
>=20
> > David Lang wrote:
> > Well, wait until there's AMD based dual core x86_64 laptops out there
> > (this email being written on a single core x86_64 one). I can already
> > see the faces of the unhappy future owners being told "use idle=3Dpoll"
> > when on battery and anyway going deaf by fan noise.
> >
> > (/me ducks and runs)
>=20
> I'm not saying it's the right answer, but it's one of two workarounds=20
> currently available.
>=20
> idle=3Dpoll causes increased power useage
>=20
> timer source change (mentioned earlier in this thread) limits timer=20
> precision
>=20
> neither of these are fixes, but by understanding the different costs=20
> people can choose the work around they want to use while waiting for a=20
> better fix.

A laptop user could also bind a process to a single CPU, and use the
scaling min/max values to lock CPU speed to a single value.  The TSC may
still stop during HLT, but software must be handling that already.

Wouldn't that provide an accurate TSC?
--=20
Zan Lynx <zlynx@acm.org>

--=-HHoGdJnW/FIubpIpvRWy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDyg1bG8fHaOLTWwgRAvE9AJ0SHLJ9bHlm00UhMdbmC4ZjjqzkaACfcp+z
uqIuUmvE7HFMPDStnnR/nJw=
=bFpb
-----END PGP SIGNATURE-----

--=-HHoGdJnW/FIubpIpvRWy--

