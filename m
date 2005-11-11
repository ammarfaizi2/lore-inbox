Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVKKJBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVKKJBM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 04:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVKKJBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 04:01:12 -0500
Received: from smtp06.auna.com ([62.81.186.16]:2957 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S932299AbVKKJBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 04:01:11 -0500
Date: Fri, 11 Nov 2005 09:54:59 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-mm2
Message-ID: <20051111095459.6b353575@werewolf.auna.net>
In-Reply-To: <20051110203544.027e992c.akpm@osdl.org>
References: <20051110203544.027e992c.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 1.9.100cvs7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_xWzgnL/Za/9vIbez/3tRlqd";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
X-Auth-Info: Auth:LOGIN IP:[83.138.218.199] Login:jamagallon@able.es Fecha:Fri, 11 Nov 2005 09:55:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_xWzgnL/Za/9vIbez/3tRlqd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Nov 2005 20:35:44 -0800, Andrew Morton <akpm@osdl.org> wrote:

>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14/2.6.=
14-mm2/
>=20

The "Block layer" config option seems a bit out of place where it is now.
I would move it just before "Networking", but that requires touching
every architecture Kconfig file (just cloning the 'source net/Kconfig' line=
).

Is this the way to go ? Is it where it is for some reason apart from being
a fast way to let every arch load it ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like se=
x:
werewolf!able!es                         \         It's better when it's fr=
ee
Mandriva Linux release 2006.1 (Cooker) for i586
Linux 2.6.14-jam1 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))

--Sig_xWzgnL/Za/9vIbez/3tRlqd
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDdFxkRlIHNEGnKMMRAkvMAJ4y0pf0tIzC290KLpLGROsRcXlkKgCfTn4z
ZbA4gQx5wn85ABRb4VcLyvk=
=PQRi
-----END PGP SIGNATURE-----

--Sig_xWzgnL/Za/9vIbez/3tRlqd--
