Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbTLLW6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 17:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTLLW6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 17:58:40 -0500
Received: from smtp1.USherbrooke.ca ([132.210.244.17]:30414 "EHLO
	courrier3.usherbrooke.ca") by vger.kernel.org with ESMTP
	id S262603AbTLLW5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 17:57:50 -0500
Subject: Re: Increasing HZ (patch for HZ > 1000)
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031212220853.GA314@elf.ucw.cz>
References: <1071126929.5149.24.camel@idefix.homelinux.org>
	 <1293500000.1071127099@[10.10.2.4]>  <20031212220853.GA314@elf.ucw.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WKeHwuEcONFhd/CXOjNx"
Organization: Universite de Sherbrooke
Message-Id: <1071269849.4182.14.camel@idefix.homelinux.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 12 Dec 2003 17:57:29 -0500
X-UdeS-MailScanner-Information: Veuillez consulter le http://www.usherbrooke.ca/vers/virus-courriel
X-UdeS-MailScanner: Aucun code suspect =?ISO-8859-1?Q?d=E9tect=E9?=
X-MailScanner-SpamCheck: n'est pas un polluriel, SpamAssassin (score=-4.9,
	requis 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WKeHwuEcONFhd/CXOjNx
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

> Every notebook from thinkpad 560X up has produced some kind of
> cpu-load-related-noise. You'd have to throw out quite a lot of
> notebooks...

You're right, I'm probably not the only one. It may be worth at least
having an option to change HZ to less annoying values. Otherwise there
are going to be lots of complaints when people try out 2.6 on their
laptops and hear that noise. On mine, I seriously could not stand the
noise more than 5 minutes. Not because it was that loud but 1 kHz is
really annoying.

> PS: Jean, can you try how high you can get it? You might want to go to
> 24kHz so that no human can hear it, or to 100kHz to be kind to
> cats. At ~1MHz you'd be even kind to bats :-), but it is probably
> impossible to get over 200kHz or so. Still it might be funny
> experiment.

For now, my patch only allows up to around 10 kHz. At that frequency, I
don't hear anything because the noise is not loud enough (ear is much
more sensitive at 1 kHz). Also, I have around 10% overhead on my
Pentium-M 1.6 GHz, so I guess it's not for everyone. Extrapolating from
there, I'd also say that at 100 kHz, it wouldn't do anything but handle
the interrupts, which is slightly annoying when you want to actually get
some work done :)

	Jean-Marc

--=20
Jean-Marc Valin, M.Sc.A., ing. jr.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada

--=-WKeHwuEcONFhd/CXOjNx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/2kfZdXwABdFiRMQRAt0WAJwJL7cv/f51N3oEOS8D9R63Ggaz7wCeLu9B
9/7ZtYolmAj8eVzX98+shXE=
=WEIh
-----END PGP SIGNATURE-----

--=-WKeHwuEcONFhd/CXOjNx--

