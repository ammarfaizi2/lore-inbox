Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424184AbWKISIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424184AbWKISIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 13:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424183AbWKISIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 13:08:42 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:37602 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S1424184AbWKISIl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 13:08:41 -0500
Subject: Re: XFS filesystem performance drop in kernels 2.6.16+
From: Russell Cattelan <cattelan@thebarn.com>
To: "Igor A. Valcov" <viaprog@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>
References: <bde600590611090930g3ab97aq3c76d7bca4ec267f@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JuSEL1a0MCem7VzSRDyt"
Date: Thu, 09 Nov 2006 12:08:35 -0600
Message-Id: <1163095715.5632.102.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JuSEL1a0MCem7VzSRDyt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-11-09 at 20:30 +0300, Igor A. Valcov wrote:
> Hello,
>=20
> For one of our projects we have a test program that measures file
> system performance by writing up to 1000 files simultaneously. After
> installing kernel v2.6.16 we noticed that XFS performance dropped by a
> factor of 5 (tests that took around 4 minutes on kernel 2.6.15 now
> take around 20 minutes to complete). We then checked all kernels
> starting from 2.6.16 up to 2.6.19-rc5 with the same unpleasant result.
> The funny thing about all this is that we chose XFS for that
> particular project specifically because it was about 5 times faster
> with the tests than the other file systems. Now they all take about
> the same time.
>=20
> I also noticed that I/O barriers were introduced in v2.6.16 and
> thought they may be the cause, but mounting the file system with
> 'nobarrier' doesn't seem to affect the performance in any way.
>=20
> Any thoughts on the matter are appreciated.
I would try verifying the problem on a non ide disk just
to confirm the write barrier theory.

Also file a bug.
http://oss/sgi.com/bugzilla
include test case and hard description if possible.


>=20
> Thanks in advance,

--=20
Russell Cattelan <cattelan@thebarn.com>

--=-JuSEL1a0MCem7VzSRDyt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFU26jNRmM+OaGhBgRAv3EAJoD46oZI7tAel8SFTVxfYRbC8gXXACff0ge
/N33Dq1iluQOkxKfZWacUIw=
=PPqj
-----END PGP SIGNATURE-----

--=-JuSEL1a0MCem7VzSRDyt--

