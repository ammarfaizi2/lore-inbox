Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVDEO2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVDEO2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 10:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVDEO2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 10:28:46 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:44989 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261759AbVDEO2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 10:28:38 -0400
Date: Tue, 5 Apr 2005 10:28:36 -0400
From: John M Flinchbaugh <john@hjsoft.com>
To: linux-kernel@vger.kernel.org
Subject: debug: sleeping function...slab.c:2090
Message-ID: <20050405142836.GA25571@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I got the debug statement below during boot.

Environment:
    Pentium M, Thinkpad R40
    Debian unstable
    Linux 2.6.12-rc2
    Gnu C 3.3.5
    binutils 2.15

Debug: sleeping function called from invalid context at mm/slab.c:2090
in_atomic():1, irqs_disabled():0
 [<c0103707>] dump_stack+0x17/0x20
 [<c0114e6c>] __might_sleep+0xac/0xc0
 [<c014394e>] kmem_cache_alloc+0x5e/0x60
 [<c0142aa3>] kmem_cache_create+0xe3/0x570
 [<c0268d39>] proto_register+0x99/0xc0
 [<e0bea096>] inet6_init+0x16/0x1d0 [ipv6]
 [<c0132902>] sys_init_module+0x172/0x230
 [<c01030e5>] syscall_call+0x7/0xb

--=20
John M Flinchbaugh
john@hjsoft.com

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCUqCUCGPRljI8080RAnhwAJ9jyPTAU2EBThFfc9ci2cuesJn5VwCdGYfi
HGKXItQIWncfDeg5Z4pIuhs=
=av18
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
