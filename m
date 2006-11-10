Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946601AbWKJNYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946601AbWKJNYk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 08:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946602AbWKJNYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 08:24:40 -0500
Received: from systemlinux.org ([83.151.29.59]:57287 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1946601AbWKJNYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 08:24:39 -0500
Date: Fri, 10 Nov 2006 14:24:18 +0100
From: Andre Noll <maan@systemlinux.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: ak@suse.de, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: Bad page state in process 'swapper'
Message-ID: <20061110132418.GD29040@skl-net.de>
References: <20061110121151.GC29040@skl-net.de> <1163161474.3138.691.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <1163161474.3138.691.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13:24, Arjan van de Ven wrote:

> > just tried to boot 2.6.19-rc5 on a 2-way opteron 250 with 8G Ram:
>=20
>=20
> doest memtest86 pass?

It did pass some month ago.

>  which modules are in use?

no modules as this kernel does not have module support.

> (it looks like something splattered all over your memory)

The same machine is now running 2.6.18.2 + Nick Piggin's rmap-debug
patch with no problems so far. Prior to my test with 2.6.19-rc5 it was
running 2.6.18.1 + Nick's patch.

This is a cluster node btw, so it it stressed heavily.

Andre
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFVH2CWto1QDEAkw8RAsnHAKCESKsNA4GV7li8GUWx6ZU1rmRFOwCfbVD7
50gzmZe+Oic6uvQmgEpWJHE=
=Z9K3
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
