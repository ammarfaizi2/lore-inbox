Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbVKHWKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbVKHWKX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbVKHWKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:10:22 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:45805 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1030324AbVKHWKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:10:21 -0500
Date: Wed, 9 Nov 2005 00:10:17 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, p_gortmaker@yahoo.com,
       linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, rc@rc0.org.uk,
       linuxsh-shmedia-dev@lists.sourceforge.net
Subject: Re: [2.6 patch] move rtc_interrupt() prototype to rtc.h
Message-ID: <20051108221017.GA17797@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	p_gortmaker@yahoo.com, linux-kernel@vger.kernel.org,
	rmk@arm.linux.org.uk, rc@rc0.org.uk,
	linuxsh-shmedia-dev@lists.sourceforge.net
References: <20051107200357.GN3847@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20051107200357.GN3847@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2005 at 09:03:57PM +0100, Adrian Bunk wrote:
> This patch moves the rtc_interrupt() prototype to rtc.h and removes the=
=20
> prototypes from C files.
>=20
> It also renames static rtc_interrupt() functions in=20
> arch/arm/mach-integrator/time.c and arch/sh64/kernel/time.c to avoid=20
> compile problems.
>=20
>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> Signed-off-by: Paul Gortmaker <p_gortmaker@yahoo.com>
>=20
> ---
>=20
> This patch was already sent on:
> - 3 Nov 2005
>=20
>  arch/arm/mach-integrator/time.c |    5 +++--
>  arch/i386/kernel/time_hpet.c    |    2 --
>  arch/sh64/kernel/time.c         |    7 ++++---
>  arch/x86_64/kernel/time.c       |    2 --
>  include/linux/rtc.h             |    3 +++
>  5 files changed, 10 insertions(+), 9 deletions(-)
>=20
It's fine with me if Andrew wants it. There's no functional changes for
sh64 anyways, and this doesn't break anything there either.

Acked-by: Paul Mundt <lethal@linux-sh.org>

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDcSJJ1K+teJFxZ9wRAtM3AJ92KS/SnubrtnfYKJqBu0wd8DfDNQCfZdkJ
tK/sRvqx8qka0+e+Ufte5M4=
=ymQH
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
