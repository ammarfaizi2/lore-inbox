Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262577AbTCMVwZ>; Thu, 13 Mar 2003 16:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262579AbTCMVwY>; Thu, 13 Mar 2003 16:52:24 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:47542 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262577AbTCMVwV>; Thu, 13 Mar 2003 16:52:21 -0500
Date: Thu, 13 Mar 2003 19:02:32 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow to compile IDE as module
Message-ID: <20030313220232.GF23024@duckman.distro.conectiva>
References: <20030313200804.GE23024@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Content-Disposition: inline
In-Reply-To: <20030313200804.GE23024@duckman.distro.conectiva>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Oops. Don't apply it.
I've not tested it before, and noticed that it is not so
simple. There are other parts that are being included on
vmlinux that need symbols from the ide module.

On Thu, Mar 13, 2003 at 05:08:04PM -0300, Eduardo Pereira Habkost wrote:
> Marcelo, the following patch fixes drivers/ide/Makefile
> to allow to use CONFIG_BLK_DEV_IDE=3Dm.
>=20
> --=20
> Eduardo
>=20
<snip>
> +
> +obj-$(CONFIG_BLK_DEV)			+=3D ide-obj-y

Ouch, it would not work, anyway.
I promise that I will test the changes, next time.  :-)

--=20
Eduardo

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+cP/4caRJ66w1lWgRAvOsAJ4kxrGKIydNmyC4hZqnJZ2T6WfJQQCfTSdx
guJuirUlFKt0MM6SyRno5w8=
=NbXG
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--
