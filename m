Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318262AbSG3NXw>; Tue, 30 Jul 2002 09:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318263AbSG3NXw>; Tue, 30 Jul 2002 09:23:52 -0400
Received: from [213.69.232.58] ([213.69.232.58]:51208 "HELO schottelius.org")
	by vger.kernel.org with SMTP id <S318262AbSG3NXu>;
	Tue, 30 Jul 2002 09:23:50 -0400
Date: Wed, 31 Jul 2002 19:57:43 +0200
From: Nico Schottelius <nico-mutt@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Bugs in 2.5.28 [scsi/framebuffer/devfs/floppy/ntfs/trident]
Message-ID: <20020731175743.GB1249@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MSMail-Priority: Is not really needed
X-Operating-System: Linux flapp 2.5.28
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

Just wanted to report of the following problems:

Compile Problems when selecting the following:
- Selected PCMCIA-SCSI
- Selected Framebuffer -> Aty128fb
- Sound / trident.c

Other bugs:
- devfs init is still missing -> /dev/vc/0 is the only console.
- floppy driver still broken
- ntfs sometimes crashes the system: working on a loopback file caused
  ntfs to report corruptions in the file system and this hangs system
  completly.

If you need more informations, just tell me. Currently I've some time
to debug parts of the kernel.

Nico

--=20
Changing mail address: please forget all known @pcsystems.de addresses.

Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9SCUXtnlUggLJsX0RAqM8AJ0VZf7QovVQXuZiQIteNMKcnLSouQCfU/MB
E/ywPTe7ZXxLn0HQNEZa1os=
=wsyi
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
