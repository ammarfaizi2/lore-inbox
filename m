Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132530AbRBECuq>; Sun, 4 Feb 2001 21:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132608AbRBECuf>; Sun, 4 Feb 2001 21:50:35 -0500
Received: from ironsides.terrabox.com ([64.242.77.131]:43665 "EHLO
	ironsides.terrabox.com") by vger.kernel.org with ESMTP
	id <S132530AbRBECua>; Sun, 4 Feb 2001 21:50:30 -0500
From: Brian Wolfe <ahzz@terrabox.com>
Date: Sun, 4 Feb 2001 20:50:13 -0600
To: Hans Reiser <reiser@namesys.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink related)
Message-ID: <20010204205013.D23921@ironsides.terrabox.com>
In-Reply-To: <E14OoD8-0007GI-00@the-village.bc.nu> <3A7B2F7C.52AA6AFA@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A7B2F7C.52AA6AFA@namesys.com>; from reiser@namesys.com on Sat, Feb 03, 2001 at 01:06:52AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

	I hate to say it but I think Hans might have the right answer here. As an =
administrator that has worked in large multi hundred million dollar compani=
es where 1 hour of downtime =3D=3D $75,000 in lost income proactive prevent=
ion IS the right answer. If the gcc people need to compile with the .96 rh =
version then they can apply a removal patch hans provides in the crash mess=
age. This makes it easy to remove the safeguard and blow yourself up at wil=
l after being suitibly called a dumbass.

	I do understand your desire to keep things simple and not put a safetynet =
out for every single moron out there. Personaly I despise them. But I also =
understand the evil necessity of doign this for somet hings that are this s=
erious of a risk.

	From the debate raging here is what I gathered is acceptable....

make it blow up fataly and immediatly if it detects Red Hat + gcc 2.96-red_=
hat_broken(forgot version num)
make it provide a URL to get the patch to remove this safeguard if you real=
ly want this.

	The fatal crash should be VERY carefull to only trigger on a redhat system=
 with the broken compiler. And to satisfy your agument that people may need=
 to be able to use it, provide a reverse patch to remove this safeguard in =
one easy cat file | patch.

	Brian Wolfe

On Sat, Feb 03, 2001 at 01:06:52AM +0300, Hans Reiser wrote:
> Alan Cox wrote:
> >=20
> > > As it stands, there is no way to determine programatically whether
> > > gcc-2.96 is broken or now. The only way to do it is to check the RPM
> > > version -- which, needless to say, is a bit difficult to do from the
> > > C code about to be compiled. So I can't really blame Hans if he decid=
es
> > > to outlaw gcc-2.96[.0] for reiserfs compiles.
> >=20
> > Oh I can see why Hans wants to cut down his bug reporting load. I can a=
lso
> > say from experience it wont work. If you put #error in then everyone wi=
ll
> > mail him and complain it doesnt build, if you put #warning in nobody wi=
ll
> > read it and if you dont put anything in you get the odd bug report anyw=
ay.
> >=20
> > Basically you can't win and unfortunately a shrink wrap forcing the user
> > to read the README file for the kernel violates the GPL ..
> >=20
> > Jaded, me ?
> >=20
> > Alan
>=20
> I fear that you are speaking from experience about the complaints it does=
n't
> build, and that there is a strong element of truth in what you say.
>=20
> That said, my opinion is that bug reporting load is not as important as b=
ug
> avoidance, but I understand your position has merit to it also.
>=20
> Hans

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQIeBAEUAwAGBQI6fhTkAAoJEFL4hQRn2yBckWcH/AoI03crlE9fVYzFmrna8v0s
pBGbv5wujTlvJK/+QqEh2kdfD0ownTxM9T9RZbucDYkEfsZecm9if6dSSgWwlD8G
gHDGNYmYduS3zPPC+dEPZzYFNAcqh7uxOM9f1GGbc2TJzWSCQOfLYBSeh6ZF+qZe
dPHSLHdkyauaycZVWw7fIDDjKFivbn5j33Y0+Y3mKos1BaxWaoowteEot/2PvU2Q
+oSaJzNL1rbNheJi4WF+aXRv3kVuvNhvCBwGj33OXmvRhbnCfqJCNd1NucuTqdvu
iXeUcPuCF/2Z8p2+Nex0avmgFDHTV1ZDSEtkHwq1OENz4y1sSTx7i3EX2Oxxi00H
/11m3fhm5xMRDGInb6+mZ21o8y372WNqxsv2jvtFvKbOvZLjmrbaJWw17nEzKeXy
7aaJqsrI7w4lors92ilb/nRw/CtkyYAg97/Fqe1HX9Gpu9xIvjMZlHnK9OWucD5C
oqm31lrx0bP9o4EEJOAaVToC2hqkGio1cNEQIG0uc7bsxIHI1hhVeck4cYprlPQD
iXV/P1b8ImSjFt8FIUULORZtpBJPfNH6aTlkdhT6IGOIg6WWbWa7+Sp5RGh9ScYW
NhGB3uzN904foYnzUoGgN3XTEiTSE4NmRi2UXvLVpWMVW3ZieSxZUPp5ArIlOetn
0qoq2NqtiqHKGMVSRGNSse4=
=IA8W
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
