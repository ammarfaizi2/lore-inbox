Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTEMH2b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 03:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263444AbTEMH2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 03:28:31 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:41261 "EHLO
	tor.trudheim.com") by vger.kernel.org with ESMTP id S263441AbTEMH22
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 03:28:28 -0400
Subject: Re: [OT] Two RAID1 mirrors are faster than three
From: Anders Karlsson <anders@trudheim.com>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3EC05746.1070307@tequila.co.jp>
References: <200305112212_MC3-1-386B-32BF@compuserve.com>
	 <3EBF24A8.1050100@tequila.co.jp>
	 <1052716203.4100.10.camel@tor.trudheim.com>
	 <3EBF5DF2.2080204@tequila.co.jp>
	 <1052731825.3522.23.camel@tor.trudheim.com>
	 <3EC05746.1070307@tequila.co.jp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VHyNMaMN79cumcgU3tgN"
Organization: Trudheim Technology Limited
Message-Id: <1052811667.3599.4.camel@tor.trudheim.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 13 May 2003 08:41:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VHyNMaMN79cumcgU3tgN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-05-13 at 03:24, Clemens Schwaighofer wrote:

> > I think it depends greatly on your needs. For small companies running
> > commercial unices, this might be the best solution based upon need and
> > cost. For even smaller outfits running Linux, the snapshot feature in
> > Linux LVM will do the job.
>=20
> well, for private yes, but even as a small company I would invest in a
> rother more solid hardware RAID system than into software. I saw so many
> horrible data losses due software raid or IDE HDs (which where in a
> external hardware box actually), that I don't trust this much anymore.

SSA does quite happily mirroring with two copies and has done for many
years now. There are still instances where read performance outweighs
the cost of having to get three times the storage you require to use.

And for the record, I was never talking about IDE storage... ;-)

Regards,

/Anders

--=-VHyNMaMN79cumcgU3tgN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+wKGTLYywqksgYBoRArsXAJ0TbNboJEfpeq2k17NDPlR/26KObQCdHLjf
16ZMtXAgzRF1+bpbqHobYcI=
=1fKW
-----END PGP SIGNATURE-----

--=-VHyNMaMN79cumcgU3tgN--

