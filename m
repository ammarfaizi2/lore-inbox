Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbTDWMKZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 08:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264011AbTDWMKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 08:10:24 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:2738 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263156AbTDWMKX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 08:10:23 -0400
Date: Wed, 23 Apr 2003 15:22:26 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Nir Livni <nir_l3@netvision.net.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FileSystem Filter Driver
Message-ID: <20030423122226.GL11931@actcom.co.il>
References: <000501c30983$1ffb8950$ade1db3e@pinguin> <20030423010518.GA6009@wind.cocodriloo.com> <000d01c30992$c35e7ad0$4ee1db3e@pinguin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tDYGg60iReQ7u8wj"
Content-Disposition: inline
In-Reply-To: <000d01c30992$c35e7ad0$4ee1db3e@pinguin>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tDYGg60iReQ7u8wj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2003 at 02:20:38PM +0200, Nir Livni wrote:

> My goal is to write a driver that runs above the filesystem driver, and
> filters calls to this driver.
> Actually, it should pass all calls to the filesystem driver, except very =
few
> that it should fail for "Access Denied". Are there any simple examples for
> that matter ?

A. Sounds like it could be implemented using the LSM (linux security
modules) framework, assuming the appropriate hooks are in place.=20

B. The May 2003 Linux Journal issue has an article on "Writing
Stackable Filesystems" by Erez Zadok, which might fit your needs
better.

Hope this helps,=20
Muli.=20
--=20
Muli Ben-Yehuda
http://www.mulix.org


--tDYGg60iReQ7u8wj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+poWBKRs727/VN8sRAsDIAJ9phsaklpa53TXZI2Ky4+y5fqjvvQCeLGEl
hJQoojHVnmdMD4wEg7fvPLo=
=qlG2
-----END PGP SIGNATURE-----

--tDYGg60iReQ7u8wj--
