Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265885AbTAJVKd>; Fri, 10 Jan 2003 16:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbTAJVKd>; Fri, 10 Jan 2003 16:10:33 -0500
Received: from dialin-145-254-144-100.arcor-ip.net ([145.254.144.100]:1664
	"HELO schottelius.net") by vger.kernel.org with SMTP
	id <S265885AbTAJVKc>; Fri, 10 Jan 2003 16:10:32 -0500
Date: Thu, 9 Jan 2003 22:02:26 +0100
From: Nico Schottelius <schottelius@wdt.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.55] unresolved symbols
Message-ID: <20030109210226.GA11535@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.5.55
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I am wondering how soundcore.ko can contain errno. Is it possible that=20
sound_core.c includes it with linux/errno.h ?
But why does only soundcore.ko has the unknown symbol ?

Greetings,

Nico

p.s.: output of depmod from modules_install:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.55; fi
WARNING: /lib/modules/2.5.55/kernel/sound/soundcore.ko needs unknown symbol=
 errno
WARNING: /lib/modules/2.5.55/kernel/drivers/message/i2o/i2o_pci.ko needs un=
known symbol i2o_sys_init
WARNING: /lib/modules/2.5.55/kernel/security/root_plug.ko needs unknown sym=
bol usb_bus_list_lock
WARNING: /lib/modules/2.5.55/kernel/security/root_plug.ko needs unknown sym=
bol usb_bus_list
WARNING: /lib/modules/2.5.55/kernel/fs/nfsd/nfsd.ko needs unknown symbol ha=
sh_mem
WARNING: /lib/modules/2.5.55/kernel/arch/i386/kernel/microcode.ko needs unk=
nown
symbol devfs_set_file_size


--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+HeNitnlUggLJsX0RAsy7AJ9ejT2qG0dC0kFOM+GJQmD4SUCnpQCaAyGB
FsZZ9I/TN4nV1wj71AhaEJ8=
=FgLI
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
