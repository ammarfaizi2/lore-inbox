Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUBWNf1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbUBWNf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:35:27 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:36764 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S261849AbUBWNfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:35:12 -0500
Date: Mon, 23 Feb 2004 14:35:04 +0100
From: Pavol Luptak <P.Luptak@sh.cvut.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: SW RAID5 + high memory support freezes 2.6.3 kernel
Message-ID: <20040223133503.GA1671@psilocybus>
References: <20040223024124.GA1590@psilocybus> <16441.33071.218049.163976@notabene.cse.unsw.edu.au> <20040222213011.7e1b8bbf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20040222213011.7e1b8bbf.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2004 at 09:30:11PM -0800, Andrew Morton wrote:
> Neil Brown <neilb@cse.unsw.edu.au> wrote:
> >
> > > Hello,
> >  > issue http://www.spinics.net/lists/lvm/msg10322.html could be still =
present
> >  > in the current 2.6.3 kernel. I am able to repeat the conditions to h=
alt the=20
> >  > 2.6.3 kernel (using mkfs.ext3 on RAID device):
> >=20
> >  To be fair, your subject should say that=20
> >     SW RAID5 + high memory + loop device freezes 2.6.3 kernel
> >                            ^^^^^^^^^^^^^^
>=20
> hm, yes.  And the loop code which was involved here was removed from the
> kernel last week, so it's a bit academic.
>=20
> Retest on current 2.6.3-bk or 2.6.3-mm3 please.

I tried 2.6.3-bk4 and seems it works without problems :)
I'm going to copy about 300 GB data to this cryptoloop/RAID5 and report the
eventual bugs....

Pavol
--=20
___________________________________________________________________________=
__
[wilder@hq.sk] [http://trip.sk/wilder/] [talker: ttt.sk 5678] [ICQ: 1334035=
56]

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAOgGHhL+8XxdK5TIRAqQXAJ9DPHUaP5W1f1p3B3Ga0O4JF0lhWwCeJtw9
vOre8PRuJVzkmt5pN10zX64=
=7zcd
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
