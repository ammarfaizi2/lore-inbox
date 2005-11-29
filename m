Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVK2QtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVK2QtI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVK2QtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:49:08 -0500
Received: from ns.snowman.net ([66.92.160.21]:3469 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id S932155AbVK2QtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:49:05 -0500
Date: Tue, 29 Nov 2005 11:49:46 -0500
From: Stephen Frost <sfrost@snowman.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Michael Krufky <mkrufky@m1k.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc3
Message-ID: <20051129164946.GP6026@ns.snowman.net>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Michael Krufky <mkrufky@m1k.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <438C0124.3030700@m1k.net> <Pine.LNX.4.64.0511290808510.3177@g5.osdl.org> <438C80DD.7050809@m1k.net> <Pine.LNX.4.64.0511290835220.3177@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uzxzJ2VMz+WYPyuA"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511290835220.3177@g5.osdl.org>
X-Editor: Vim http://www.vim.org/
X-Info: http://www.snowman.net
X-Operating-System: Linux/2.4.24ns.3.0 (i686)
X-Uptime: 11:43:08 up 171 days,  8:55,  8 users,  load average: 0.18, 0.17, 0.11
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uzxzJ2VMz+WYPyuA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Linus Torvalds (torvalds@osdl.org) wrote:
> On Tue, 29 Nov 2005, Michael Krufky wrote:
> > In other words, the OOPS is the last thing to show on the screen in tex=
t mode,
> > before the console switches into X, using debian sarge's default bootup
> > process.
>=20
> Ok. Whatever it is, I'm happy it is doing that, since it caused us to see=
=20
> the oops quickly. None of _my_ boxes do that, obviously (and I tested on=
=20
> x86, x86-64 and ppc64 exactly to get reasonable coverage of what differen=
t=20
> architectures might do - but none of the boxes are debian-based).

I'm pretty curious about it too, none of my debian-based boxes have
'gdb' anywhere in /etc/init.d.  The only thing I see is that the shell
script /usr/bin/mozilla-firefox calls gdb when passed '--debugger', or
when the DEBUG environment variable is set...  Perhaps he's doing that
during his .xsession?

	Thanks,

		Stephen

--uzxzJ2VMz+WYPyuA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDjIaprzgMPqB3kigRAmMLAJ9lonKSnaGkA+XO1RI62SVbx0wP8wCfRu3J
jJXrEz3KdIPuQNI4VE7/G70=
=LD9u
-----END PGP SIGNATURE-----

--uzxzJ2VMz+WYPyuA--
