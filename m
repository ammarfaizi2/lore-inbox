Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVAaK6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVAaK6a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 05:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVAaK63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 05:58:29 -0500
Received: from mout0.freenet.de ([194.97.50.131]:63201 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261854AbVAaK5f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 05:57:35 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
Subject: Re: My System doesn't use swap!
Date: Mon, 31 Jan 2005 11:57:05 +0100
User-Agent: KMail/1.7.2
References: <41FE1B4B.2060305@tiscali.de>
In-Reply-To: <41FE1B4B.2060305@tiscali.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart22147631.Balebo5A2E";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501311157.10932.mbuesch@freenet.de>
X-Warning: freenet.de is listed at abuse.rfc-ignorant.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart22147631.Balebo5A2E
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Quoting Matthias-Christian Ott <matthias.christian@tiscali.de>:
> Hi!
> I have mysterious Problem:
> 90 % of my Ram are used (340 MB), but 0 Byte of my Swap (2GB) is used=20
> and about about 150 MB are swappable.
>=20
> [matthias-christian@iceowl ~]$ free
>              total       used       free     shared    buffers     cached
> Mem:        383868     362176      21692          0         12     208956
> -/+ buffers/cache:     153208     230660
                                    ^^^^^^
You have ~230M of 380M free.
Nothing mysterious here.

> Swap:      2097136          0    2097136
>=20
> [matthias-christian@iceowl ~]$ cat /kernel-2.6.10-rc2-ott/config
> [..]
> CONFIG_SWAP=3Dy
> [..]
> CONFIG_X86_BSWAP=3Dy
> [..]
>=20
> [matthias-christian@iceowl ~]$ dmesg
> [..]
> Adding 2097136k swap on /dev/discs/disc0/part2.  Priority:-1 extents:1
> [..]
>=20
> Matthias-Christian Ott
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
>=20

=2D-=20
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]



--nextPart22147631.Balebo5A2E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB/g8GFGK1OIvVOP4RAhPLAKDDadxxU/QX4etzr+PCJvOqcJcYZQCdHToq
h7IO5+tEok4aKTuitaQMH6E=
=WFbj
-----END PGP SIGNATURE-----

--nextPart22147631.Balebo5A2E--
