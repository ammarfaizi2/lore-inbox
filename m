Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbTL2S6Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 13:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTL2S6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 13:58:23 -0500
Received: from smtp2.actcom.co.il ([192.114.47.15]:26861 "EHLO
	smtp2.actcom.co.il") by vger.kernel.org with ESMTP id S263645AbTL2S4i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 13:56:38 -0500
Date: Mon, 29 Dec 2003 20:56:27 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [CFT/PATCH] give sound/oss/trident a holiday cleanup for 2.6
Message-ID: <20031229185627.GJ13481@actcom.co.il>
References: <20031229183846.GI13481@actcom.co.il> <Pine.LNX.4.58.0312291049020.2113@home.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pP0ycGQONqsnqIMP"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312291049020.2113@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pP0ycGQONqsnqIMP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2003 at 10:50:46AM -0800, Linus Torvalds wrote:

> > - run the code through Lindent, and then fix it manually (this is the
> > bulk of the patch)=20
>=20
> When doing things like this, can you split up the patches into two=20
> separate things: one that _only_ does whitespace changes, and that is=20
> guaranteed not to change anything else, and another that does the
> rest.

You're 100% right. Internally, the patch I sent is composed of 30
different patches. The reason I didn't seperate it into two patches is
that the changes were interleaved and inter-dependant and seperating
them was a b*tch. If Andrew wishes to include it in -mm or you wish to
include it in -vanilla and would like it in two seperate patches, I'll
go back and redo it that way.=20

Thanks and cheers,=20
Muli=20
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

"the nucleus of linux oscillates my world" - gccbot@#offtopic


--pP0ycGQONqsnqIMP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/8HjbKRs727/VN8sRAuKgAJ9mBVTM1nn16kOl16+Fh8hhKxpn6wCgqySQ
tHYEduh0vMdgsQdGDxsKHF8=
=1sDU
-----END PGP SIGNATURE-----

--pP0ycGQONqsnqIMP--
