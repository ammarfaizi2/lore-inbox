Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSLLOy4>; Thu, 12 Dec 2002 09:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264673AbSLLOy4>; Thu, 12 Dec 2002 09:54:56 -0500
Received: from dsl-64-192-31-41.telocity.com ([64.192.31.41]:15848 "EHLO
	butterfly.hjsoft.com") by vger.kernel.org with ESMTP
	id <S264666AbSLLOyz>; Thu, 12 Dec 2002 09:54:55 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Date: Thu, 12 Dec 2002 10:02:38 -0500
To: Thomas Molina <tmolina@copper.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: orinoco_cs not working in 2.5.51
Message-ID: <20021212150238.GB20924@butterfly.hjsoft.com>
References: <1039654621.1410.4.camel@lap>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline
In-Reply-To: <1039654621.1410.4.camel@lap>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2002 at 06:56:44PM -0600, Thomas Molina wrote:
> cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff=20
0xe0000-0xfffff
> orinoco_cs: RequestIRQ: Resource in use

i haven't completely tested my orinoco card with 2.5.51 yet, but i
know i've caused myself the same problems in previous kernels.

make sure you have ISA bus enabled.  those 16-bit cards apparently use
ISA.  that solved the problem for me before.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE9+KUOCGPRljI8080RAoUzAJ9ShQZIEx60BVl2Myd0fT25oZ10NgCfTn8F
mwP22uAnRv1rl3HQ7tFJrck=
=ixMt
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--
