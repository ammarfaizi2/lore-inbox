Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264959AbRGNWvN>; Sat, 14 Jul 2001 18:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264976AbRGNWvD>; Sat, 14 Jul 2001 18:51:03 -0400
Received: from femail19.sdc1.sfba.home.com ([24.0.95.128]:1709 "EHLO
	femail19.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S264959AbRGNWuu>; Sat, 14 Jul 2001 18:50:50 -0400
From: Josh McKinney <forming@home.com>
Date: Sat, 14 Jul 2001 17:50:51 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [Problem] Linux 2.4.5-ac17 ipt_unclean 'fixes'
Message-ID: <20010714175051.A8325@home.com>
Mail-Followup-To: josh, linux-kernel@vger.kernel.org
In-Reply-To: <20010714170021.B1391@dok.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
In-Reply-To: <20010714170021.B1391@dok.org>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Me too.

On approximately Sat, Jul 14, 2001 at 05:00:21PM -0500, J Troy Piper wrote:
>=20
> > 2.4.5-ac17
> > o	First set of ipt_unclean fixes			(Rusty Russell)
>=20
> Alan,=20
>=20
> I apologise for having taken so long to write this (I have known about=20
> this problem since 2.4.5ac17 and have not had a chance to document til=20
> today) but there seems to be a problem with the ipt_unclean fixes by Rust=
y=20
> Russell.  ANY incoming packets from any interface (ppp0 and eth0) are=20
> marked as 'unclean' with some variation on the following syslog entry:
>=20
> Jul  8 23:16:04 paranoia kernel: ipt_unclean: TCP option 3 at 37 too long
> Jul  8 23:16:05 paranoia kernel: ipt_unclean: TCP option 3 at 37 too long
> Jul  8 23:16:16 paranoia kernel: ipt_unclean: TCP option 3 at 37 too long
> Jul  8 23:16:18 paranoia kernel: ipt_unclean: TCP option 3 at 37 too long
>=20
> and thus are blocked by my 'unclean packet dropping' firewall (iptables).
>=20
> I haven't seen any mention of this on the list, nor have I seen any more=
=20
> ipt_unclean patches to address this problem, so here's your heads-up=20
> (albeit a bit late).
>=20
> Thanks,
>=20
> J Troy Piper
> jtp@dok.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7UMzKNkH04TEdiy8RAnyHAJ90Oycc0XJ8IbjKMdWzW563E+ygUgCgoz1l
SCVX2CjELbB86EusQCamkcU=
=tpYu
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
