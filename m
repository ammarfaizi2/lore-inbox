Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282799AbRLOQpX>; Sat, 15 Dec 2001 11:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282812AbRLOQpN>; Sat, 15 Dec 2001 11:45:13 -0500
Received: from fep01-mail.bloor.is.net.cable.rogers.com ([66.185.86.71]:58933
	"EHLO fep01-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S282799AbRLOQo5>; Sat, 15 Dec 2001 11:44:57 -0500
Date: Sat, 15 Dec 2001 11:45:05 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: can't compile 2.4.16
Message-ID: <20011215164505.GF4961@tigger>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011215045446.GB4961@tigger> <3C1AD9F3.3090207@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TdkiTnkLhLQllcMS"
Content-Disposition: inline
In-Reply-To: <3C1AD9F3.3090207@xmission.com>
User-Agent: Mutt/1.3.24i
X-Mailer: Mutt-1.3.23i (Debian Linux 2.2.18, i686)
From: "Michael P. Soulier" <michael.soulier@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TdkiTnkLhLQllcMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 14/12/01 Ben Carrell did speaketh:

> If you look at the 2.4.17-pre6 changelog you will see:
>=20
> - Create __devexit_p() function and use that on=20
>  drivers which need it to make it possible to=20
>  use newer binutils				(Keith Owens)=20
>=20
> It comes from using the latest binutils, let me guess - you run debian=20
> sid? :)  If you wish to compile 2.4.16, you need to downgrade binutils=20
> ...or try a pre-patch starting with 2.4.17-pre6

    Someone on the Debian list mentioned that enabling CONFIG_HOTPLUG work =
fix
the problem too, and it did. So, the kernel is a little bigger than desired,
but no biggy.=20

    Mike

--TdkiTnkLhLQllcMS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8G34RKGqCc1vIvggRAsziAKCim8xmCsjxIiQ2yh5A/690M8gGuQCeJxns
Rh7adzhH68dQw+1lDjc1r2E=
=DSVX
-----END PGP SIGNATURE-----

--TdkiTnkLhLQllcMS--
