Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946724AbWKJQKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946724AbWKJQKc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946727AbWKJQKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:10:32 -0500
Received: from systemlinux.org ([83.151.29.59]:14032 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1946724AbWKJQKb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:10:31 -0500
Date: Fri, 10 Nov 2006 17:10:05 +0100
From: Andre Noll <maan@systemlinux.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: Bad page state in process 'swapper'
Message-ID: <20061110161005.GF29040@skl-net.de>
References: <20061110121151.GC29040@skl-net.de> <200611101340.56161.ak@suse.de> <20061110133633.GE29040@skl-net.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SWTRyWv/ijrBap1m"
Content-Disposition: inline
In-Reply-To: <20061110133633.GE29040@skl-net.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SWTRyWv/ijrBap1m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14:36, Andre Noll wrote:

> > Does it help when you apply=20
> >=20
> > ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/e820-small-entries=
 ?=20
>=20
> OK I will try this. Can't promise if I will be able to do so today, as I
> have to wait until the currently running jobs are finished.

I could check it already today: Your patch doesn't help unfortunately,
i.e. I get the same "Bad page state in process 'swapper'" messages also
with this patch. Again, nothing containing "e820" in the log.

Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--SWTRyWv/ijrBap1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFVKRcWto1QDEAkw8RAtB5AKCIX+NAajAlWZb1a7CiWHhPlaEQuwCgnBRY
24lKukSlUdwwAvQmfyGGMU0=
=MNNi
-----END PGP SIGNATURE-----

--SWTRyWv/ijrBap1m--
