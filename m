Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135173AbQLOAt2>; Thu, 14 Dec 2000 19:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135356AbQLOAtS>; Thu, 14 Dec 2000 19:49:18 -0500
Received: from ns.snowman.net ([63.80.4.34]:4619 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S135173AbQLOAtF>;
	Thu, 14 Dec 2000 19:49:05 -0500
Date: Thu, 14 Dec 2000 19:17:25 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Netfilter <netfilter@us5.samba.org>
Subject: Re: test13-pre1 changelog
Message-ID: <20001214191725.R26953@ns>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Netfilter <netfilter@us5.samba.org>
In-Reply-To: <20001214185620.P26953@ns> <Pine.LNX.4.10.10012141603100.12695-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1Rp7a2AgasIge6Lv"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012141603100.12695-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Dec 14, 2000 at 04:06:01PM -0800
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.2.16 (i686)
X-Uptime: 8:28am  up 89 days, 12:22,  4 users,  load average: 2.00, 2.00, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1Rp7a2AgasIge6Lv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Linus Torvalds (torvalds@transmeta.com) wrote:
>=20
>=20
> On Thu, 14 Dec 2000, Stephen Frost wrote:
> >=20
> > 	This go around I compiled everything into the kernel, actually.
> > If it would be useful I can compile them as modules reboot and then see
> > what happens...
>=20
> Even when compiled into the kernel, you might just ifdown/ifup the device.
> That will re-initialize most of the driver state.

	I'll give that a shot...  ifdown -a/ifup -a, no change in behaviour.

> Is this ppp over serial.c, or what?

	There is a ppp connection, but the slowdown is on *all* interfaces,
of which there are a total of 4; eth0, eth1, eth2, ppp0.

		Stephen

--1Rp7a2AgasIge6Lv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6OWMVrzgMPqB3kigRApAoAJ4/l7UpA15FlXvQvgO0QsnV9dlz3ACeLY/H
R4cJNM1xZrSqUiDDx2eB6Nk=
=Yusd
-----END PGP SIGNATURE-----

--1Rp7a2AgasIge6Lv--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
