Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131413AbRABSnn>; Tue, 2 Jan 2001 13:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbRABSne>; Tue, 2 Jan 2001 13:43:34 -0500
Received: from p3EE3CA49.dip.t-dialin.net ([62.227.202.73]:11524 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S131199AbRABSnW>; Tue, 2 Jan 2001 13:43:22 -0500
Date: Tue, 2 Jan 2001 19:12:49 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.3.24 is available
Message-ID: <20010102191249.A4299@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <6246.978331086@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <6246.978331086@ocs3.ocs-net>; from kaos@ocs.com.au on Mon, Jan 01, 2001 at 17:38:06 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 01 Jan 2001, Keith Owens wrote:

> ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/modutils/v2.3
>=20
> modutils-2.3.24-1.src.rpm       As above, in SRPM format

There's a problem. depmod should not try to do anything besides giving
its version when --version is used, should it? I'd rather expect exit(0)
or _exit(0); for --version and --help.

(modprobe shows the same behaviour as depmod, insmod throws its version
number and the usage information, I did not bother to check the other
tools.)

$ /sbin/depmod --version
depmod version 2.3.24
Warning: You do not need a link from /etc/conf.modules to
         /etc/modules.conf.  The use of /etc/conf.modules is deprecated,
         please remove /etc/conf.modules as soon as possible.  Command
           rm /etc/conf.modules
depmod: Can't open /lib/modules/2.2.18-ma2/modules.dep for writing

--=20
Matthias Andree

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iQCVAwUBOlIaISdEoB0mv1ypAQFlrgP+JMtSsWdR8IIKTQRB9GX2DT6mJgWkD/RD
hK6zS6AmmNo3skpIIyRWqenu2IPFwqpUayR0ut0/H5iXpTnYOIFWhMy8OSJfDPOn
tdeF1wq4gnUSxl553ESxHD2CjGFyfGCftMxi9ZzGC66cqleK7Bj0HQjti0d5Vt6E
02abbyXCnXs=
=sLiI
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
