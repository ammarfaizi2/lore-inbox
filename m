Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261963AbUK3Cm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261963AbUK3Cm1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbUK3CmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:42:08 -0500
Received: from grendel.firewall.com ([66.28.58.176]:29896 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S261947AbUK3Cj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 21:39:56 -0500
Date: Tue, 30 Nov 2004 03:39:47 +0100
From: Marek Habersack <grendel@caudium.net>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org
Subject: Re: user- vs kernel-level resource sandbox for Linux?
Message-ID: <20041130023947.GI5378@beowulf.thanes.org>
Reply-To: grendel@caudium.net
References: <20041129101919.GB9419@beowulf.thanes.org> <200411292000.iATK0qOF004026@ccure.user-mode-linux.org> <16811.40687.892939.304185@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cYtjc4pxslFTELvY"
Content-Disposition: inline
In-Reply-To: <16811.40687.892939.304185@wombat.chubb.wattle.id.au>
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cYtjc4pxslFTELvY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 30, 2004 at 09:13:03AM +1100, Peter Chubb scribbled:
> >>>>> "Jeff" =3D=3D Jeff Dike <jdike@addtoit.com> writes:
>=20
> Jeff> grendel@caudium.net said:
> >> I would appreciate any pointers to the userland solutions for that
> >> problem (if any exist) before I resort to Xen/UML.
>=20
> Jeff> UML would be exactly what you're looking for.
>=20
> Jeff> 				Jeff
>=20
> apart from the performance hit :-(
that's the problem...

>=20
> There have been a number of different approaches proposed in the past
> to limit real memory usage per-process; search for RSS limit in the
> archives.
per-process isn't enough. I specifically need something to limit the memory
usage on a more global scale - per user ID or per process group or a similar
way of grouping related processes. That's the only way to tame processes
like apache. At this point the option I'm considering is Xen, unless I can
find a userland solution to the problem...

regards,

marek

--cYtjc4pxslFTELvY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBq91zq3909GIf5uoRAi+tAJ0Qxn0uYComiZkCGmDueksSiYkieACbBczK
S2vpKgk5e0uOJw3IoonuSUE=
=hFGG
-----END PGP SIGNATURE-----

--cYtjc4pxslFTELvY--
