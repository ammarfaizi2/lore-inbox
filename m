Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbTBCA1U>; Sun, 2 Feb 2003 19:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265854AbTBCA1U>; Sun, 2 Feb 2003 19:27:20 -0500
Received: from B5b18.pppool.de ([213.7.91.24]:44432 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S265843AbTBCA1T>; Sun, 2 Feb 2003 19:27:19 -0500
Subject: Re: Compactflash cards dying?
From: Daniel Egger <degger@fhm.edu>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20030202223009.GA344@elf.ucw.cz>
References: <20030202223009.GA344@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nd+AD57FJhjfeIxG6Gwy"
Organization: 
Message-Id: <1044232591.545.8.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 03 Feb 2003 01:36:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nd+AD57FJhjfeIxG6Gwy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Son, 2003-02-02 um 23.30 schrieb Pavel Machek:

> First time I repartitioned it; now I only did mke2fs, and data
> corruption can be seen by something as simple as

> cat /mnt/cf/mp3/* > /mnt/cf/delme; md5sum /mnt/cf/delme.

> Anyone seen something similar? Are there some known-good
> compactflash-es?

CF has limited write cycles. A few hundred if you're lucky.
And depending on the type of flash it's quite likely that every
changed byte will result in a whole block being written back.

I'm running dotzends of CF cards and due to some care not a single
one has developped bad blocks as of yet.

--=20
Servus,
       Daniel

--=-nd+AD57FJhjfeIxG6Gwy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+PbmPchlzsq9KoIYRAtigAKDkYnDnCE5O8Gp4jOT0xLUli3daxwCg0ns3
cXWyisZpuJtwSoI+X8O3L5s=
=3xiW
-----END PGP SIGNATURE-----

--=-nd+AD57FJhjfeIxG6Gwy--

