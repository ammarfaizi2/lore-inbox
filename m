Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318643AbSHAHVL>; Thu, 1 Aug 2002 03:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318650AbSHAHVL>; Thu, 1 Aug 2002 03:21:11 -0400
Received: from [213.69.232.58] ([213.69.232.58]:45322 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S318643AbSHAHVK>;
	Thu, 1 Aug 2002 03:21:10 -0400
Date: Wed, 31 Jul 2002 23:58:06 +0200
From: Nico Schottelius <nico-mutt@schottelius.org>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bugs in 2.5.28 [scsi/framebuffer/devfs/floppy/ntfs/trident]
Message-ID: <20020731215806.GE3464@schottelius.org>
References: <20020731175743.GB1249@schottelius.org> <Pine.LNX.4.44.0207311020420.13905-100000@www.transvirtual.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wchHw8dVAp53YPj8"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207311020420.13905-100000@www.transvirtual.com>
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Mailer: Yam on Linux ?
X-Operating-System: Linux flapp 2.5.29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wchHw8dVAp53YPj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

James Simmons [Wed, Jul 31, 2002 at 10:22:05AM -0700]:
> > Just wanted to report of the following problems:
> >
> > Compile Problems when selecting the following:
> > - Selected PCMCIA-SCSI
>=20
> Been broken. A new driver is being worked on.

good to know. I don't use it anyways, just wanted to report.

> > - Selected Framebuffer -> Aty128fb

btw, this fb driver seems to be really experimental or beta, as it does
nothing when loading on a mobility chip.

> > Other bugs:
> > - devfs init is still missing -> /dev/vc/0 is the only console.
>=20
> Ug. That is partially fixed. I did get the other vc/X but only root can
> access them. I have to talk to linus about the best solution here.

What about the patch with con_init_devfs(); ? Isn't that simple and stupid
enough to use ? [this is the only way I can work with those kernels right
now..]

Nico

--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--wchHw8dVAp53YPj8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9SF1utnlUggLJsX0RAlYiAJ9Ycg5SakejZhwx50A02sun/JxKnACfQeXS
RLTkaVG0S6UozN3tbVpiLM0=
=LXM3
-----END PGP SIGNATURE-----

--wchHw8dVAp53YPj8--
