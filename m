Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbTJEMnb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 08:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263096AbTJEMnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 08:43:31 -0400
Received: from chello080108023209.34.11.vie.surfer.at ([80.108.23.209]:14979
	"HELO leto2.endorphin.org") by vger.kernel.org with SMTP
	id S263095AbTJEMn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 08:43:28 -0400
Date: Sun, 5 Oct 2003 14:43:21 +0200
To: Christian Kujau <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
Subject: Re: crypto benchmark results with 2.6.0-test6
Message-ID: <20031005124321.GA2529@leto2.endorphin.org>
References: <20031004104131.GA1533@leto2.endorphin.org> <3F800BF8.3020800@g-house.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <3F800BF8.3020800@g-house.de>
User-Agent: Mutt/1.3.28i
From: Fruhwirth Clemens <clemens-dated-1066221801.48ed@endorphin.org>
X-Delivery-Agent: TMDA/0.51 (Python 2.1.3 on Linux/i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 05, 2003 at 02:18:00PM +0200, Christian Kujau wrote:
> Sorry, took me a while to retest.

Thanks :)

> Fruhwirth Clemens schrieb:
> >would you like to benchmark
> >http://clemens.endorphin.org/patches/aes-i586-asm-2.6.0-test5.diff
>
> yes, i did so, results on:
> http://www.nerdbynature.de/bench/prinz/

Looks promising. But it's not going to be merged because of objections by
the cryptoapi maintainer.

> >http://clemens.endorphin.org/twofish-i586/ (experimential)=20
>=20
> uh, i guess this masm/windoze/elf32 stuff is too much for me, i could=20
> try, but don't have time to dig into this. but you could try my script,=
=20
> and run benchmarks on your machine too.
> but: how is this twofish optimization supposed to go into mainline=20
> anyway? one had to use a special compiling environment to compile a kerne=
l?

It's not a patch, it's an add-on. I'm working on a gas version of the
assembler code so it can be merged, but it's far from being complete
(although it works).

> i set up these benchmarks for me too, because i needed to know what=20
> cipher is fast enough for my own use. usually i sticked to serpent, now=
=20
> aes-i586 looks quite good on this PC. i wonder if it will compile and so=
=20
> something on ppc32 too, but probably not. which is a pity, because my=20
> primary use of the cryptoloop is a ppc :-(

Well that's the cost of an assembler implementation ;) it's not portable.=
=20
Probably you can one of IBM's compilers to compile the cipher of your
choice. http://www-3.ibm.com/software/awdtools/ccompilers/ ... Rumours say
they're fast than gcc.

Regards, Clemens
--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/gBHpW7sr9DEJLk4RAiijAJ9n12Wmd4Jr+9n0dd9MYYu8KPCKLwCcDk62
S1te3gHaiQ58Jg24rUXvgtE=
=nhp/
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
