Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbTLKRws (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 12:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbTLKRwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 12:52:47 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:46984
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S264884AbTLKRwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 12:52:45 -0500
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
From: Ian Kumlien <pomac@vapor.com>
To: ross@datscreative.com.au
Cc: macro@ds2.pg.gda.pl, linux-kernel@vger.kernel.org, AMartin@nvidia.com,
       kernel@kolivas.org
In-Reply-To: <200312111912.27811.ross@datscreative.com.au>
References: <200312072312.01013.ross@datscreative.com.au>
	 <200312111655.25456.ross@datscreative.com.au>
	 <1071143274.2272.4.camel@big.pomac.com>
	 <200312111912.27811.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2q/hrQUtJ1hO8GaLYyAB"
Message-Id: <1071165161.2271.22.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Dec 2003 18:52:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2q/hrQUtJ1hO8GaLYyAB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-12-11 at 10:12, Ross Dickson wrote:
> On Thursday 11 December 2003 21:47, Ian Kumlien wrote:
> Thanks Ian
>=20
> Also many thanks for pointing out the relevant section to look in with th=
e AMD
> cpu link that you sent - Credit where credit is due (assuming we are both=
 on the
> right track).

Heh, thanks, feels nice to have someone who agrees with you =3D).

> I had a read and refined your surmisings. I think the=20
> problem appears synchronous with the apic timer because of two reasons.
> 1) any apic irq can cause re-connection of the system bus after disconnec=
t.
> 2) the apic timer irq in my examinations has the shortest path to an ack.

http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/244=
16.pdf
Page 42 and 94 might help as well. I haven't grasped it all or had any
food yet but i hope i'm right =3D)

> I also had a look back through the athlon cooler and power management=20
> postings and web site articles. I was blissfully ignorant of these issues=
 when I
> started and now I wonder what I have stepped into... Yuk

Heh, yeah, the need for disconnect is somewhat dodgy, i haven't read up
on th rest.

> I submitted a support request to AMD, apologies for not cc'ing you, I kep=
t
> the cc's down to just nvidia and the mailing list. If you have not seen i=
t yet
> then it is here

Thanks

> We hope....

Yup...

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-2q/hrQUtJ1hO8GaLYyAB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/2K7p7F3Euyc51N8RAi6BAJ9M5s8tZQDokBT7VgyW4jYZAME/+QCfRvH6
HDb6q0c8vDggB+vELGzVgio=
=KOBF
-----END PGP SIGNATURE-----

--=-2q/hrQUtJ1hO8GaLYyAB--

