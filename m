Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbULaTmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbULaTmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 14:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbULaTmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 14:42:42 -0500
Received: from smtp3.pp.htv.fi ([213.243.153.36]:28367 "EHLO smtp3.pp.htv.fi")
	by vger.kernel.org with ESMTP id S262149AbULaTmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 14:42:39 -0500
Date: Fri, 31 Dec 2004 21:42:38 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: pmarques@grupopie.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: sh: inconsistent kallsyms data
Message-ID: <20041231194238.GC19049@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	pmarques@grupopie.com, linux-kernel@vger.kernel.org
References: <20041231172549.GA18211@linux-sh.org> <1104515971.41d593835721f@webmail.grupopie.com> <20041231182234.GB18211@linux-sh.org> <1104521356.41d5a88c041ff@webmail.grupopie.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
In-Reply-To: <1104521356.41d5a88c041ff@webmail.grupopie.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 31, 2004 at 07:29:16PM +0000, pmarques@grupopie.com wrote:
> You mis-read the 'if'. The symbol is not used it is of 'U' type *or*
> is_arm_mapping_symbol. This means that is_arm_mapping_symbol will be
> called for all the symbols that are not of type 'U'.
>=20
Yeah, I noticed that after I had modified the if and commented out the
is_arm_mapping_symbol and replied already. It made no difference
anyways.

> I was the one who wrote the algorithm, so I'm probably in the best
> position to debug it. If you send Keith the info he requested, send it
> to me too, so that I have some more data to look at.
>=20
Keith already replied to this privately so I'll leave it at that. Let me
know if you need anything else.

--48TaNjbzBVislYPb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFB1auu1K+teJFxZ9wRAo0BAJ9KAzVH2dYX76oEeRM6BC3yQ83TFACfXSxz
i/JriIvA3NEEw2rBPiG55F4=
=T8Wj
-----END PGP SIGNATURE-----

--48TaNjbzBVislYPb--
