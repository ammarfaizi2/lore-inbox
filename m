Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTEEGKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 02:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbTEEGKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 02:10:40 -0400
Received: from dsl-62-3-122-162.zen.co.uk ([62.3.122.162]:25772 "EHLO
	marx.trudheim.com") by vger.kernel.org with ESMTP id S261944AbTEEGKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 02:10:39 -0400
Subject: Re: Latest GCC-3.3 is much quieter about sign/unsigned comparisons
From: Anders Karlsson <anders@trudheim.com>
To: Art Haas <ahaas@airmail.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030504212256.GE24907@debian>
References: <20030504212256.GE24907@debian>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aXXJALgwliVdCahz98Uv"
Organization: Trudheim Technology Limited
Message-Id: <1052115781.25951.43.camel@marx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 05 May 2003 07:23:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aXXJALgwliVdCahz98Uv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello there, :-)

On Sun, 2003-05-04 at 22:22, Art Haas wrote:
> Hi.
>=20
> This change ...
>=20
> 2003-05-02  Zack Weinberg  <zack@codesourcery.com>
>=20
> 	PR c/10604
> 	* c-opts.c (c_common_decode_option <OPT_Wall>): Set
> 	warn_sign_compare for C++ only.
> 	* doc/invoke.texi: Clarify documentation of -Wsign-compare.
>=20
> ... has eliminated all the warnings that GCC-3.3 by default printed
> with regards to signed/unsigned comparisons. A build of today's BK
> with this compiler is much quieter than those previously done
> with the 3.3 snapshots.

Yes, it means the warnings are not printed, it doesn't mean the problem
has gone away though.

I'd still like for someone to tell me if there is a specific reason to
use signed numbers in for example inode.c in one of the filesystems
(can't remember which one of the top of my head). I for one would get
rather surprised if some of my data started getting stored with negative
inodes...

Regards,

/Anders


--=-aXXJALgwliVdCahz98Uv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+tgNFLYywqksgYBoRAoBtAKDc/4MDoQGHP+hIuBNKwJ1P6hqn9gCfTvzi
ZFNcEWi3ztpKJMGGWozROlc=
=mCAt
-----END PGP SIGNATURE-----

--=-aXXJALgwliVdCahz98Uv--

