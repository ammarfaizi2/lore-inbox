Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbUBFMvM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 07:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUBFMvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 07:51:12 -0500
Received: from legolas.restena.lu ([158.64.1.34]:24735 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264887AbUBFMvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 07:51:08 -0500
Subject: Re: [ACPI] acpi problem with nforce motherboards and ethernet
From: Craig Bradney <cbradney@zip.com.au>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Daniel Drake <dan@reactivated.net>,
       Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech@wanadoo.es>,
       david+challenge-response@blue-labs.org, linux-kernel@vger.kernel.org,
       a.verweij@student.tudelft.nl
In-Reply-To: <40237765.6080602@gmx.de>
References: <402298C7.5050405@wanadoo.es> <40229D2C.20701@blue-labs.org>
	 <4022B55B.1090309@wanadoo.es>  <20040205154059.6649dd74.akpm@osdl.org>
	 <1076026496.16107.23.camel@athlonxp.bradney.info>
	 <4022DE3C.1080905@wanadoo.es> <4022E209.3040909@gmx.de>
	 <4022E3C8.4020704@wanadoo.es>  <4022E69B.5070606@gmx.de>
	 <1076029281.23586.36.camel@athlonxp.bradney.info> <40235DBA.4030408@gmx.de>
	 <1076062051.16107.49.camel@athlonxp.bradney.info> <40236F06.5050103@gmx.de>
	 <40236207.7050104@reactivated.net> <402374B0.8080907@gmx.de>
	 <40237765.6080602@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-K3JYy4HhW+MoPUULqWur"
Message-Id: <1076071864.1036.3.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 06 Feb 2004 13:51:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-K3JYy4HhW+MoPUULqWur
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-06 at 12:15, Prakash K. Cheemplavam wrote:
> Prakash K. Cheemplavam wrote:
> > Daniel Drake wrote:
> >=20
> >> Prakash K. Cheemplavam wrote:
> >>
> >>> Ok, then it makes sense, so you are using APIc with CPU Disconnect=20
> >>> and Ross' patch. This explains your low idle temps. As I said this=20
> >>> config doesn't work for me.
> >>
> >>
> >>
> >> Have you experimented with the new apic_tack boot options in Ross's=20
> >> latest patches?
> >> apic_tack=3D2 seems to work best for me.
> >=20
> >=20
> > Stupid me. I haven't thoruoughly read the text. I have not activated th=
e=20
> > patch, so I'll try this. thx for pointing out..
>=20
> OK, I appended apic_tack=3D2 and yes, it survives several hdparms! Great,=
=20
> so gonna try if it is really stable.Then I can try =3D1. CPU cooling down=
.=20
> Already at 46=B0C. :-)
>=20
> Not bad,not bad, though I saw a small performace degration: hdparm gives=20
> me 60-61mb/s instead of >62mb/s, but I won't complain. :-)
>=20

Ahh yes.. missing the kernel line argument will make a difference. I'm
running apic_tack=3D2 as well. From what I remember =3D2 was the "better"
patch option if it made your system stable.

Craig

--=-K3JYy4HhW+MoPUULqWur
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAI424i+pIEYrr7mQRAvHuAJ9M4+fq68daj12hCpIdWN+vtH0ezQCggYhU
giIoPSX92+xXTYz7SmDUNlE=
=ZXXp
-----END PGP SIGNATURE-----

--=-K3JYy4HhW+MoPUULqWur--

