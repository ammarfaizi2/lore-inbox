Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267021AbSKWM6v>; Sat, 23 Nov 2002 07:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbSKWM6v>; Sat, 23 Nov 2002 07:58:51 -0500
Received: from port326.ds1-brh.adsl.cybercity.dk ([217.157.160.207]:3127 "EHLO
	mail.jaquet.dk") by vger.kernel.org with ESMTP id <S267021AbSKWM6u>;
	Sat, 23 Nov 2002 07:58:50 -0500
Date: Sat, 23 Nov 2002 14:05:55 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.49
Message-ID: <20021123140555.B1933@jaquet.dk>
References: <Pine.LNX.4.44.0211221351040.1763-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211221351040.1763-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Nov 22, 2002 at 01:55:08PM -0800
X-PGP-Key: http://www.jaquet.dk/rasmus/pubkey.asc
X-PGP-Fingerprint: 925A 8E4B 6D63 1C22 BFB9  29CF 9592 4049 9E9E 26CE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2002 at 01:55:08PM -0800, Linus Torvalds wrote:
>=20
> Ok, I appear to be without network connectivity at home at least over the=
=20
> weekend, and master.kernel.org is going down for some maintenance this=20
> afternoon, so here's my current tree.

This (and -mm1) does not boot for me. Or rather, the kernel boots
but the systems hangs hard when kdm starts. No numlock, no sysrq.
Only hard reboot helps.=20

I can boot single-user fine. And I can boot X fine from a
single-user root login. KDE then hangs, but X definitely starts.
I can terminate X at this point with crtl-alt-backspace.

My system is a Debian testing, X is 4.2.1. The kernel has no DRI
support configured, no SMP, has preempt. Machine is P3-450, 128MB=20
RAM.

2.5.47mm1 works fine. My 2.5.49 .config is at=20
www.jaquet.dk/kernel/config-2.5.49

Regards,
  Rasmus

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9330zlZJASZ6eJs4RAkd3AJwPISjZAY3pRKyDZmpcLRnQjUU5zwCdGver
iuNGSioMiZ8+8Vu7pMx1VOg=
=XSYS
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
