Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270111AbTGNQOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270133AbTGNQOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:14:04 -0400
Received: from ce.fis.unam.mx ([132.248.33.1]:31192 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S270111AbTGNQOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:14:01 -0400
Subject: Re: no sound on 2.5.75-mm1 (emu10k1 loaded)
From: Max Valdez <maxvalde@fis.unam.mx>
To: kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0307131931160.29044@montezuma.mastecende.com>
References: <1058115661.6491.6.camel@garaged.homeip.net>
	 <Pine.LNX.4.53.0307131931160.29044@montezuma.mastecende.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1cVu8ry2Qj3xlcS9q0//"
Message-Id: <1058182153.3913.6.camel@garaged.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 14 Jul 2003 06:29:13 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1cVu8ry2Qj3xlcS9q0//
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The problem is solved taking off the CONFIG_DEVFS_MOUNT from config

Thanks Zwane, i think is the 3 time (at least)that you help me to solve
a problem with devel kernels.

The problems seems to be that gento tries to mount devfs, and it was
already mounted, I took off the CONFIG_DEVFS_DEBUG too, but I dont think
that has nothing to do with the problem, i just dont think i will use it

BTW, taking off DEVFS at all, i cannot mount SCSI disks, that seems to
be the only problem, I still have a problem with NFS daemon, but at leas
I have my NFS mounts working well, I think its a init script problem, i
will try to correct that.

Max
On Sun, 2003-07-13 at 18:32, Zwane Mwaikambo wrote:
> On Sun, 13 Jul 2003, Max Valdez wrote:
>=20
> > Hi all
> >=20
> > Im very plessed to see my first 2.5 kernel running almos completly !!,
> > this time I dont have sound system running, I might be missing somethin=
g
> > fool, but I just can't find it, here is my config attached, a dmesg and
> > lsmod. There is no /dev/dsp device, no /dev/sound either.
>=20
> Seems like a devfs thing, try removing it.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
Linux garaged 2.4.22-pre3-ac1 #5 SMP Wed Jul 9 07:01:52 CDT 2003 i686 Penti=
um III (Coppermine) GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GS/ d-s:a-28C++ILHA+++P+L++>+++E---W++N*o--K-w++++O-M--V--PS+PEY--PGP++t5XR=
tv++b++DI--D-G++e++h-r+y**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt

--=-1cVu8ry2Qj3xlcS9q0//
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/EpQJsrSE6THXcZwRAh78AJ9qRBJxxAO/CweRHl6tU8JkT0xQSACg1QEO
SENGX9FTVhYjAjg1LvHi9+U=
=g8mV
-----END PGP SIGNATURE-----

--=-1cVu8ry2Qj3xlcS9q0//--

