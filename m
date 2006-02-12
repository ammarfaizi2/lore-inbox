Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750906AbWBLLWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWBLLWv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 06:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWBLLWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 06:22:51 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:34007 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S1750836AbWBLLWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 06:22:50 -0500
Date: Sun, 12 Feb 2006 12:22:34 +0100
From: Harald Welte <laforge@netfilter.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Marc Boucher <marc@mbsi.ca>, James Morris <jmorris@namei.org>,
       Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, coreteam@netfilter.org,
       netfilter@lists.netfilter.org, netfilter-devel@lists.netfilter.org
Subject: Re: [PATCH] netfilter: fix build error due to missing has_bridge_parent macro
Message-ID: <20060212112234.GC5336@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Marc Boucher <marc@mbsi.ca>,
	James Morris <jmorris@namei.org>,
	Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>, coreteam@netfilter.org,
	netfilter@lists.netfilter.org, netfilter-devel@lists.netfilter.org
References: <200602120320.37042.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <200602120320.37042.jesper.juhl@gmail.com>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 12, 2006 at 03:20:36AM +0100, Jesper Juhl wrote:
> Hi,
>=20
> I just did an allyesconfig test build of 2.6.16-rc2-git10 and found a bui=
ld
> problem.

thanks, I'll push this via davem and to stable ASAP.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD7xp6XaXGVTD0i/8RAnGDAJ4rmmx9/1mKnvq8R2Qte7jA0vi3zwCggbfi
wadcN0BjfD3zF2loDA0nXDw=
=6Ix+
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
