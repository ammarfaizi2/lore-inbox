Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbSL1ETy>; Fri, 27 Dec 2002 23:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbSL1ETy>; Fri, 27 Dec 2002 23:19:54 -0500
Received: from [68.96.149.130] ([68.96.149.130]:58572 "EHLO resonant.org")
	by vger.kernel.org with ESMTP id <S265446AbSL1ETx>;
	Fri, 27 Dec 2002 23:19:53 -0500
Date: Fri, 27 Dec 2002 22:28:11 -0600
From: Zed Pobre <zed@resonant.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Complete freeze with 2.4.20 on 4-proc IBM xSeries 350
Message-ID: <20021228042811.GA27793@resonant.org>
Mail-Followup-To: Zed Pobre <zed@resonant.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E8EE16A19D69D611B40000D0B73EBB250F06BE@exchange.intern.eproduction.ch> <11930000.1039565421@flay> <20021226214338.GA1285@resonant.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20021226214338.GA1285@resonant.org>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
X-GPG-Fingerprint: FF 75 8D 70 57 8D A4 7D  3A DE 6D 2F 25 C3 E6 E7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 26, 2002 at 03:43:38PM -0600, Zed Pobre wrote:
>=20
>     I'm running off a Soyo Dragon KT400 board, single AMD 2400+
> processor, 1GB ram (4GB limit set in kernel), and was also having
> freezes, apparently related to having software raid 1 in use (on two
> drives sitting on the on-board Highpoint controller).  If I started a
> large data transfer over the net, the machine would freeze after some
> time ranging from a few minutes to an hour, with either 2.4.20-ac2 or
> 2.4.21-pre2.

    As a followup to this, taking it off RAID has greatly helped
stability, but not completely cured it, as I've managed to get another
hard lock while doing a 2GB or so rsync.  It seems to be fine for
normal use, though, and I'm now contemplating turning RAID back on to
see if it stays stable for anything except large file transfers.

--=20
Zed Pobre <zed@debian.org> a.k.a. Zed Pobre <zed@resonant.org>
PGP key and fingerprint available on finger; encrypted mail welcomed.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQEVAwUBPg0oWx0207zoJUw5AQHoBQf+OdRm4c1PL87QSVZMcy2pE1Ej953jK3He
C+H+Ocdsf3Q0N/uMzIu9GHt8DO1eSA8aVJ2Cnic+xPfUoDMZW9ogjbR8agf7sw47
x5v0bNnbzEAtGp9lfnA2CjIZWHyy1DT8jFAms6XiZiWnfrp3/VQP0woa3hLbvyk7
/i7vDlT8iCQspzhm3Tar2l0uSRnXKJzkcNJPZKeNY95WYZ6s9QP3yzwr0OdJJfH9
AB8Ea2Z6Qva88ef+nZ104t0rmQeVI/gdNP1hRblF8LsST5yTXrS27ygiV65iSKy9
gLKxfg+4OYgQpFe9c+aSaj4JS/XlstC+81wFfHGETZVBj223q8WY/w==
=/uxv
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
