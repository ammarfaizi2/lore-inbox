Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318652AbSHAH25>; Thu, 1 Aug 2002 03:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318657AbSHAH25>; Thu, 1 Aug 2002 03:28:57 -0400
Received: from [213.69.232.58] ([213.69.232.58]:46091 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S318652AbSHAH24>;
	Thu, 1 Aug 2002 03:28:56 -0400
Date: Thu, 1 Aug 2002 08:56:31 +0200
From: Nico Schottelius <nico-mutt@schottelius.org>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUGS] 2.5.29: scsi/pcmcia|sound/trident|devfs
Message-ID: <20020801065631.GA754@schottelius.org>
References: <20020731171517.GA818@schottelius.org> <Pine.LNX.4.44.0207311037570.13905-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207311037570.13905-100000@www.transvirtual.com>
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

James Simmons [Wed, Jul 31, 2002 at 10:41:16AM -0700]:
> > #######################################################################=
####
> > ### Hangup/Kernel Panics:
> > #######################################################################=
####
> >
> >    - devfs: drivers/char/console.c:2527: con_init_devfs(); is missing.
> >      Hey guys, this bug exists in at least 3 kernel versions!
>=20
> I'm working on a proper fix. BTW how do you get a kernel panic?

In fact it's 'only' a hangup, because getties are unable to open /dev/vc/* =
[>0].

> I'm
> running devfs plus con_init_devfs is not called. tty_register_devfs is
> called by tty_register_driver. It is a issue of different flags being
> passed to devfs by either tty functions. As soon a linus gives me a answer
> to the problem I will post a patch for people to try and then push it to
> BK.

sounds good. When you've finished the patch and Linux said it's fine,
please send a copy of it to me.

Nico

--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9SNuetnlUggLJsX0RAnBhAJ9Ib/BGOjIhzDKBX0Pe16ouQrUd4ACgmx6B
iqpQzinFxAH1ffXmggIYvSQ=
=iDMA
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
