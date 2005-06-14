Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVFNFjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVFNFjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 01:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVFNFjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 01:39:54 -0400
Received: from relay.rost.ru ([80.254.111.11]:58305 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S261223AbVFNFjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 01:39:24 -0400
Date: Tue, 14 Jun 2005 09:39:18 +0400
To: Andre <andre@rocklandocean.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ZFx86 support broken?
Message-ID: <20050614053918.GC2460@pazke>
Mail-Followup-To: Andre <andre@rocklandocean.com>,
	linux-kernel@vger.kernel.org
References: <00fb01c56dec$91f0e440$6702a8c0@niro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <00fb01c56dec$91f0e440$6702a8c0@niro>
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.9i
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 161, 06 10, 2005 at 11:45:27AM -0700, Andre wrote:
> I am trying to boot LFS6.0.1 livecd which has 2.6.8.1, but the kernel han=
gs
> at:
> Freeing unused kernel memory: 456k freed
>=20
> My system is a pc/104 board based on ZFx86 with 64M ram
> I also found this posting:
> http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-03/5939.html
> Looking at the console output, the cpu gets recognized as 486, whereas
> 2.4.22 detects the cpu as Cyrix Cx486DX4
>=20
> Looking at the kernel source, it seems to get stuck after the call to
> free_initmem and when I tried to specify init=3D/bin/sh it still got stuc=
k at
> the same place so I figured it doesn't even get to the run_init_process
> calls in ..../init/main.c. Could the call to unlock_kernel get stuck?

Are you sure that userspace on livecd is not compiled for 586+ CPU ?

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCrm2GR2OTnxNuAyMRAtoCAJ411koG0YtdV9bDneQ+Nt58XjzrHwCcDRbW
jej93D6jDMnlHzsci88ES6Y=
=wwSG
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
