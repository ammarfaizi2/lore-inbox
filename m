Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTELJRs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 05:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbTELJRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 05:17:48 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:56816 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S262015AbTELJRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 05:17:47 -0400
Subject: Re: [OT] Two RAID1 mirrors are faster than three
From: Anders Karlsson <anders@trudheim.com>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3EBF5DF2.2080204@tequila.co.jp>
References: <200305112212_MC3-1-386B-32BF@compuserve.com>
	 <3EBF24A8.1050100@tequila.co.jp>
	 <1052716203.4100.10.camel@tor.trudheim.com>
	 <3EBF5DF2.2080204@tequila.co.jp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NgSuHPZHX3s99N9fG3pG"
Organization: Trudheim Technology Limited
Message-Id: <1052731825.3522.23.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 12 May 2003 10:30:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NgSuHPZHX3s99N9fG3pG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-05-12 at 09:40, Clemens Schwaighofer wrote:

> [db raid1 with 3 discs]
>=20
> that sounds like a super special featuer never needed in Software (!!)
> Raid thing (IMvHO).

I think it depends greatly on your needs. For small companies running
commercial unices, this might be the best solution based upon need and
cost. For even smaller outfits running Linux, the snapshot feature in
Linux LVM will do the job.

For large operations where money is not really the issue, a SAN with
some SAN Volume Controllers is probably the answer.

Then there is the issue of people that are just simple ultra-paranoid
about their data or where the 2nd copy is in fact off-site (using SCSI
extenders).

> I can only image a Hotspare Disc, thats all.

In the tradition of Unix, there are more than one way to skin a cat. ;-)

/Anders

--=-NgSuHPZHX3s99N9fG3pG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+v2mwLYywqksgYBoRAkAzAJ4kJ9CTh8ihMc/ZVcxcF6cIMB2cIgCdFPc4
MPyX5AUNMTgABfQhH/wxcmM=
=8mh6
-----END PGP SIGNATURE-----

--=-NgSuHPZHX3s99N9fG3pG--

