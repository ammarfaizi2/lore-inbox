Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbTIYNnY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 09:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbTIYNnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 09:43:24 -0400
Received: from 24-216-47-19.charter.com ([24.216.47.19]:14558 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id S261227AbTIYNnV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 09:43:21 -0400
Date: Thu, 25 Sep 2003 09:43:14 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: "Dave Gilbert (Home)" <gilbertd@treblig.org>
Cc: "Norris, Brent" <bnorris@Edmonson.k12.ky.us>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 128G Limit in Reiserfs? Or the Kernel? Or something else?
Message-ID: <20030925134314.GE32614@rdlg.net>
Mail-Followup-To: "Dave Gilbert (Home)" <gilbertd@treblig.org>,
	"Norris, Brent" <bnorris@Edmonson.k12.ky.us>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA86E@E151000N0> <3F72EC23.6070403@treblig.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <3F72EC23.6070403@treblig.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



I have about 2 filesystems currently at 600Gig.

Reiser has no inodes so I guarantee your out but it's irrelevant.
What does df -k actually show?  You sure you don't have a process with
an open log file that's been removed?

Thus spake Dave Gilbert (Home) (gilbertd@treblig.org):

> Norris, Brent wrote:
> >I seem to have hit an odd limit, that I didn't think existed.  I have a=
=20
> >250G
> >WD IDE hard drive that I have just installed.  Since I couldn't put a Ex=
t3
> >filesystem on it (mount wouldn't recognize it) I decided to put a Reiser=
FS
> >filesystem on it.  Since I have done that I have added 128G of data to t=
he
> >drive.  Now when I attempt to copy more data to it I get an error that=
=20
> >there
> >is no more space on the drive.
>=20
> Reiser can definitly do larger file systems than that (I have a Reiser=20
> file system with over 300GB on).
>=20
> Its worth trying a df -i to make sure you haven't run out of inodes -=20
> but then you say you can create empty files.
>=20
> Dave
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/cvDy8+1vMONE2jsRAvpeAKCKqeNRowmxqmvPGGdLDi0ZjTa5QgCghQhJ
VwvJtJSYmRRMmyxu2jLgMPE=
=z469
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
