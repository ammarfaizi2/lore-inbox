Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129636AbQLGRdi>; Thu, 7 Dec 2000 12:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129959AbQLGRd2>; Thu, 7 Dec 2000 12:33:28 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:40693 "EHLO
	morcego.distro.conectiva") by vger.kernel.org with ESMTP
	id <S129784AbQLGRdP>; Thu, 7 Dec 2000 12:33:15 -0500
Date: Thu, 7 Dec 2000 15:02:47 -0200
From: "Rodrigo Barbosa (aka morcego)" <rodrigob@conectiva.com.br>
To: linux-kernel@vger.kernel.org, riel@conectiva.com.br
Subject: [whitevampire@MINDLESS.COM: Naptha - New DoS]
Message-ID: <20001207150247.G24723@conectiva.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="O8XZ+2Hy8Kj8wLPZ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-GeekCode-Version: 3.1
X-GeekCode: CS/IT$ d- s+: a-->- C++++(++) UL++++ P--- L+++(++++)$ E--- W+(++) N+(++) o K? w--- O- M- V PS+ PE++ Y+(++) PGP++(+++) t+>++ 5+(++) X+ R++(*) tv+ b+++ DI++++ D+ G++ e h* r++ y+++
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O8XZ+2Hy8Kj8wLPZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm just forwarding it. I know nothing about it. I don't know how it works.
I don't know how to protect agains it. I don't know what is a Kernel.
I don't know what is Linux. I don't know what is e-mail. Who am I ?=20
Where am I ? What are all those green dots in the sky ? Ahhhhhhhhhhhh :-)

Anyway, I talked to Riel before sending this bug here, and he acknoledged
that it's really something new:

<riel> hummmm
<riel> indeed, this is a new one
<riel> which hits in the tcp ESTABLISHED phase

----- Forwarded message from White Vampire <whitevampire@MINDLESS.COM> -----

Date:         Wed, 6 Dec 2000 23:34:39 -0500
From: White Vampire <whitevampire@MINDLESS.COM>
Subject:      Naptha - New DoS

Greetings,

[ Misc Info ]

	I find it rather odd that this has yet to be mentioned on
Bugtraq.  I know of more than one person besides myself who has
experienced some problems with this DoS since this advisory was
released.  I delayed mentioning it on this list because I figured
someone from Razor would release it, or someone who was involved with
the discovery.  Various vendors are no doubt already coding like mad.

	I have disabled Keepalive in Apache (via 'Keepalive Off' in the
configuration file) and changed the kernel timeouts, as recommended by
the advisory.  This will help some, but not enough.  I hope to see
complete fixes available soon, perhaps this will help kick-start
it.  Limiting public access to TCP daemons is also a way to help prevent
attacks.

[ Quick Summary ]

	Basically, it will leave a TCP connection on the target machine
in a "certain state."  The method discovered will exhaust resources on
the target machine, whereas the originating machine will not be=20
affected that greatly.  Before such attacks were infeasible because the
originating machine would also be affected.  The target machine can be
starved of resources to the point of failure.

Some affected operating systems:

* Novell's Netware 5.0 with sp1 (Will not recover)
* Linux (2.2.x .. others ?) (Unknown.. can recover sometimes?)
* FreeBSD 4.0-REL (Can recover in short period)
* Possibly others.. it is a rather widespread problem.

Unaffected operating systems:

* OpenBSD seems to be unaffected
* Windows 2000 seems to be unaffected

For more information on NAPTHA visit:
http://razor.bindview.com/publish/advisories/adv_NAPTHA.html

[ Credit and Disclaimer ]

	An advisory was released by Razor on November 30th.  I had not
involvement with the discovery or release of this advisory.  This e-Mail
is simply a summary to help system administrators and other individuals
who are interested or are experiencing problems learn about the
attack.  I shared my experiences and summarized some information from
the advisory.

	I am just sharing the information.  Good luck to the vendors,
and good luck to the rest of the world.  I sure have not had a fun time
resulting these attacks.

Regards,
--=20
    __      ______   ____
   /  \    /  \   \ /   / White Vampire\Rem
   \   \/\/   /\   Y   /  http://www.gammagear.com/ (Gear for the BOFH)
    \        /  \     /   http://www.webfringe.com/
     \__/\  /    \___/    http://www.gammaforce.org/
          \/ "Silly hacker, root is for administrators."



----- End forwarded message -----

--=20
 Rodrigo Barbosa (morcego)  - rodrigob@conectiva.com.br
 Conectiva R&D Team         - http://distro.conectiva.com.br
 "Quis custodiet custodes?" - http://www.conectiva.com


--O8XZ+2Hy8Kj8wLPZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6L8K3n5NdOMMM/nERAgRnAKDT7u5TC3yOicohTBDzJyLBzBDgQQCg5S6D
xt9xJxsUED1RlNse7ogrHtc=
=4wJd
-----END PGP SIGNATURE-----

--O8XZ+2Hy8Kj8wLPZ--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
