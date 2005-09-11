Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbVIKLxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVIKLxF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 07:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVIKLxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 07:53:05 -0400
Received: from ns.snowman.net ([66.92.160.21]:6099 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id S964773AbVIKLxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 07:53:04 -0400
Date: Sun, 11 Sep 2005 07:53:27 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Andi Kleen <ak@suse.de>
Cc: Jim Gifford <maillist@jg555.com>, linux-kernel@vger.kernel.org
Subject: Re: Pure 64 bootloaders
Message-ID: <20050911115327.GZ6026@ns.snowman.net>
Mail-Followup-To: Andi Kleen <ak@suse.de>, Jim Gifford <maillist@jg555.com>,
	linux-kernel@vger.kernel.org
References: <43228E4E.4050103@jg555.com> <p73k6hp2up7.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VZGTJogoWKdbG5sF"
Content-Disposition: inline
In-Reply-To: <p73k6hp2up7.fsf@verdi.suse.de>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 07:50:33 up 92 days,  4:07,  9 users,  load average: 0.00, 0.03, 0.01
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VZGTJogoWKdbG5sF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Andi Kleen (ak@suse.de) wrote:
> Jim Gifford <maillist@jg555.com> writes:
> > I have been working on a project to create a Pure 64 bit distro of
> > linux, nothing 32 bit in the system. I can accomplish that with no
>=20
> Hopefully you're using /lib64 for that, otherwise your
> packages will be incompatible to everybody else and not=20
> FHS compliant. If you don't please don't submit any=20
> patches to hardcode this to upstream packages.

/lib64 sucks, as mentioned, and I thought FHS only required that the
linker be in /lib64.  Thus, the actual libraries could be pretty much
anywhere (as it should be, really).  Debian-amd64 uses a symlink from
/lib64 to /lib and provides the 64bit libraries and linker in /lib (but
when actually compiling does link binaries through /lib64 for FHS
compliance).

Hopefully /lib64, et al, will die and multiarch will happen soon.

	Thanks,

		Stephen

--VZGTJogoWKdbG5sF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDJBq3rzgMPqB3kigRAuq9AJ48K14XgoRkzeZNsj/8EZOmomXIbgCgk5fz
/KiyBAP9l/yUfCphuAfiq9I=
=TTMO
-----END PGP SIGNATURE-----

--VZGTJogoWKdbG5sF--
