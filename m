Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbTJTQBD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 12:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbTJTQBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 12:01:03 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:57674 "HELO
	ash.lnxi.com") by vger.kernel.org with SMTP id S262690AbTJTQA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 12:00:59 -0400
Subject: Re: Blockbusting news, results are in
From: Thayne Harbaugh <tharbaugh@lnxi.com>
Reply-To: tharbaugh@lnxi.com
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Hans Reiser <reiser@namesys.com>, "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Norman Diamond '" <ndiamond@wta.att.ne.jp>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'John Bradford '" <john@grabjohn.com>,
       "\"'linux-kernel@vger.kernel.org \" '" <linux-kernel@vger.kernel.org>,
       "'nikita@namesys.com '" <nikita@namesys.com>,
       "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
In-Reply-To: <20031019084113.GC21346@bitwizard.nl>
References: <785F348679A4D5119A0C009027DE33C105CDB300@mcoexc04.mlm.maxtor.com>
	 <3F92488C.6030808@namesys.com>  <20031019084113.GC21346@bitwizard.nl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4HwB7aRCVBbAG6Sc5pAC"
Organization: Linux Networx
Message-Id: <1066665374.6281.73.camel@tubarao>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 20 Oct 2003 09:56:14 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4HwB7aRCVBbAG6Sc5pAC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-10-19 at 02:41, Rogier Wolff wrote:
> On Sun, Oct 19, 2003 at 12:17:16PM +0400, Hans Reiser wrote:
> > What are the common sources of data corruption, is one of them that the=
=20
> > drive head starts bumping the media more and more often because a=20
> > bearing (or something) has started to show signs of wear?
>=20
> I'm not sure if the manufacturer knows. Datarecovery companies
> know.=20
>=20
> Sources of dataloss are:=20
>=20
> 	- Software
> 	- crooked platters (especially on laptop drives)
> 	- heads bouncing on platter
> 	- broken electronics.=20

I experienced a fun problem where high-CFM fans in a 1u chassis caused
extreme vibration.  This vibration caused errors in the drive and
resulted in large numbers of failures using badblocks as a testing
tool.  When the vibration was removed the failures disappeared.  Another
symptom of the vibration was _very_ low disk performance <10% normal.

I couldn't get a straight answer from the drive manufacturer about how
the reallocation table worked.  The short answer was that they were the
only ones that could reset the reallocation table.

--=20
Thayne Harbaugh
Linux Networx

--=-4HwB7aRCVBbAG6Sc5pAC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/lAWefsBPTKE6HMkRApm2AJ4vNAFbKtB12wCeKwEwM3yifmLeUQCeJCdb
7NIV4TPRiNVba7jbPFkc/Nw=
=kbrv
-----END PGP SIGNATURE-----

--=-4HwB7aRCVBbAG6Sc5pAC--

