Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273569AbRIUOwN>; Fri, 21 Sep 2001 10:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273577AbRIUOwE>; Fri, 21 Sep 2001 10:52:04 -0400
Received: from discord.ws.crane.stargate.net ([216.151.124.71]:60829 "EHLO
	discord") by vger.kernel.org with ESMTP id <S273569AbRIUOvx>;
	Fri, 21 Sep 2001 10:51:53 -0400
Subject: Re: encrypted swap on loop in 2.4.10-pre12?
From: "steve j. kondik" <shade@chemlab.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: "Michael H. Warfield" <mhw@wittsend.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3BAB0547.9F36DBA5@pp.inet.fi>
In-Reply-To: <1000912739.17522.2.camel@discord>
	<3BA907F6.3586811C@pp.inet.fi> <20010920081353.H588@suse.de>
	<3BA9DC30.DA46A008@pp.inet.fi> <20010920142555.B588@suse.de>
	<1000991848.569.1.camel@discord> <3BAA21B1.B579D368@pp.inet.fi>
	<1001006425.1498.9.camel@discord> <3BAA2D7F.DBBCFC8C@pp.inet.fi> 
	<20010920145950.I16647@alcove.wittsend.com> <1001032613.31730.3.camel@eris>
	 <3BAB0547.9F36DBA5@pp.inet.fi>
X-Mailer: Evolution/0.13 (Preview Release)
Date: 21 Sep 2001 10:52:17 -0400
Message-Id: <1001083937.13868.1.camel@discord>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_discord-26610-1001083938-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_discord-26610-1001083938-0001-2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

i am successfully running 2.4.10-pre13 with kpreempt, grsec, and ext3
with encrypted swap now.


On Fri, 2001-09-21 at 05:15, Jari Ruusu wrote:
> "steve j. kondik" wrote:
> > agreed.  i've had this problem on two seperate systems, however i _am_
> > running a few other patches- notably the kpreempt patch.  but again, no
> > problems at all until 2.4.10-pre12.  i'll try some things in the mornin=
g
> > and see what i can come up with.  i see you are doing swapon, however
> > have you tried mkswap over your loopdev?  i can actually swapon just
> > fine, its mkswap that causes the panic.
>=20
> I losetup the encrypted swap loop with a random key every time the box
> boots, so mkswap is done before swapon. I used the example script in the
> loop-AES README file.
>=20
> For testing purposes, can you back out the kpreempt patch, and let me kno=
w
> if that cures the problem.
>=20
> Regards,
> Jari Ruusu <jari.ruusu@pp.inet.fi>
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
--=20
http://chemlab.org  -  email shade-pgpkey@chemlab.org for pgp public key
  chemlab radio!    -  drop out @ http://mp3.chemlab.org:8000   24-7-365

"i could build anything if i could just find my tools.."=09

--=_discord-26610-1001083938-0001-2
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA7q1Qhq7nxKnD1kxkRAg6/AKCZQaAn3+aQR/oLxl2w90mnCWRv3QCgncQq
JeOqTpo2ta4WJcNe1WSUgrA=
=5zAc
-----END PGP SIGNATURE-----

--=_discord-26610-1001083938-0001-2--
