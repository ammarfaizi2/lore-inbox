Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030313AbWGSVJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030313AbWGSVJT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 17:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWGSVJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 17:09:19 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:12795 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030313AbWGSVJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 17:09:18 -0400
Date: Wed, 19 Jul 2006 23:09:14 +0200
From: Torsten Landschoff <torsten@debian.org>
To: Mattias Hedenskog <ml@magog.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS breakage in 2.6.18-rc1
Message-ID: <20060719210913.GA1072@stargate.galaxy>
References: <67dc30140607190717r57ed2fe5w719dcca896110d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <67dc30140607190717r57ed2fe5w719dcca896110d8@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:d638a0eb9c9fbc21c426336ab6dfa19b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2006 at 04:17:50PM +0200, Mattias Hedenskog wrote:
=20
> reproducible in 2.6.17 and 2.6.18-rc1 as well. When I tried to repair
> the fs I got the same error as in the previous post, running xfsprogs
> 2.8.4. I haven't had the time to debug this issue further because the
> box is quite critical but I'll keep an eye on the other disks on the
> system still running xfs.
=20
I would not try running xfs_repair without cause as well. My /home did
survive the XFS problems but I ran xfs_repair "just to be sure". Now the=20
same problem on that partition, mostly unreadable. :( So, do not run=20
xfs_repair without a cause ;-)

For reference, I think it was xfsprogs 2.7.14 that I was using, the=20
latest in Debian.

FYI: Nothing important on /home, I think - I can not be sure since I
backup only selectively since I do not have proper backup mediums :(

Greetings

	Torsten

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEvp95dQgHtVUb5EcRAteuAJ97SFqV62V+ybDeeQUJdrtsRoUNGwCfWyCe
1qVe/LqzJ5Oi9NuSrgfBE1s=
=Fckd
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
