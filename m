Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbUKWWgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUKWWgK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 17:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbUKWWdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 17:33:54 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:34004 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S261603AbUKWWd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 17:33:28 -0500
Date: Tue, 23 Nov 2004 10:55:29 -0700
From: Andreas Dilger <adilger@clusterfs.com>
To: tridge@samba.org
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
Message-ID: <20041123175529.GZ1974@schnapps.adilger.int>
Mail-Followup-To: tridge@samba.org, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <16797.41728.984065.479474@samba.org> <419E1297.4080400@namesys.com> <16798.31565.306237.930372@samba.org> <20041119162651.2d62a6a8.akpm@osdl.org> <16803.1243.69076.294925@samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cbvl/UgeRTPlujdB"
Content-Disposition: inline
In-Reply-To: <16803.1243.69076.294925@samba.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Cbvl/UgeRTPlujdB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 23, 2004  20:37 +1100, tridge@samba.org wrote:
>  > > Would anyone care to hazard a guess as to what aspect of -mm2 is
>  > > gaining us 10% in overall Samba4 performance?
>  >=20
>  > Is it reproducible with your tricked-up dbench?
>  >=20
>  > If so, please send me a machine description and the relevant command l=
ine
>  > and I'll do a bsearch.
>=20
> I've now confirmed that the new dbench does indeed show a significant
> improvement in 2.6.10-rc2-mm2 as compared to 2.6.10-rc2. Interestingly,
> the improvement seems to be only in ext3, which confused me for a while.

Might it be the reservation patches?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/


--Cbvl/UgeRTPlujdB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFBo3mRpIg59Q01vtYRAlqDAKCATEKOasqalE3Y+iq0RTju70cn4ACg0tlu
3Nuc0WuY+/8ex598WFAjcD4=
=vRS3
-----END PGP SIGNATURE-----

--Cbvl/UgeRTPlujdB--
