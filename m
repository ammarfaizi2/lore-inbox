Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUEQT5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUEQT5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUEQT5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:57:21 -0400
Received: from legolas.restena.lu ([158.64.1.34]:58083 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S262476AbUEQT5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:57:10 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Craig Bradney <cbradney@zip.com.au>
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Jesse Allen <the3dfxdude@hotmail.com>,
       Ross Dickson <ross@datscreative.com.au>,
       Len Brown <len.brown@intel.com>, a.verweij@student.tudelft.nl,
       christian.kroener@tu-harburg.de, linux-kernel@vger.kernel.org,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>, Daniel Drake <dan@reactivated.net>,
       Ian Kumlien <pomac@vapor.com>, Allen Martin <AMartin@nvidia.com>
In-Reply-To: <40A91467.9060501@gmx.de>
References: <Pine.GHP.4.44.0404271807470.6154-100000@elektron.its.tudelft.nl>
	 <200404282133.34887.ross@datscreative.com.au>
	 <20040428205938.GA1995@tesore.local>
	 <200404292144.37479.ross@datscreative.com.au>
	 <20040429202413.GA1982@tesore.local> <40916638.2040202@gmx.de>
	 <20040503204520.GA1994@tesore.local>  <40A8D9C2.7070608@gmx.de>
	 <1084822323.9714.0.camel@amilo.bradney.info>  <40A91467.9060501@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YnZcDctey4fcxu4SdUFY"
Message-Id: <1084823823.9640.6.camel@amilo.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 17 May 2004 21:57:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YnZcDctey4fcxu4SdUFY
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-05-17 at 21:37, Prakash K. Cheemplavam wrote:
> Craig Bradney wrote:
> > On Mon, 2004-05-17 at 17:26, Prakash K. Cheemplavam wrote:
> >=20
> >>Hi all,
> >>
> >>I just made an interesting finding and would like to have comments from=
=20
> >>NVidia:
> >>
> >>Chip   Current Value   New Value
> >>C17       1F0FFF01     1F01FF01
> >>C18D      9F0FFF01     9F01FF01
> >>
> >>In fact I have the newer chip revision (lspci says c1), but due to a=20
> >>post at Abit Forums I tried to use the value for the older revision on=20
> >>my board, and guess what: I never had such low idle temps! I am=20
> >>currently even using nvidia binary graphics driver and usually I would=20
> >>be having around 49-51=B0C idle temp, but now it is around 45=B0C, and =
it=20
> >>was not the first boot (then the mobo usually shows 5=B0C less). Instea=
d=20
> >>the temp steadily fell from >50=B0C to 45=B0C.
> >>
> >>(esp @nvidia:) Is there anything evil using the old chip's value for th=
e=20
> >>new chip? So far I haven't noticed any bad thing about it. Perhaps some=
=20
> >>daring nforce2 user with the new revision should try as well.
> >>
> >=20
> >=20
> > Isnt it the case that that change is the one that brings about
> > stability? Was indicated before to be the main causing c1halt crashes.
>=20
> Nope, I am changing the 9F to 1F. The "stability byte" was changing the=20
> 0F to 01. I am no using 1F01FF01 instead of 9F01FF01. I guess I wasn't=20
> clear enough.

And I wasnt looking hard enough at those characters. :) Interesting
find.. Allen.. any comments?

Craig

--=-YnZcDctey4fcxu4SdUFY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAqRkPi+pIEYrr7mQRAr84AJ453lTeiUOdskiF1J3MhhUpkTxmDACggmvz
3MicVboIHm8oRFmd7d/Ovn0=
=OwmE
-----END PGP SIGNATURE-----

--=-YnZcDctey4fcxu4SdUFY--

