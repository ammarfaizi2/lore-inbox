Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265515AbUFTVco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbUFTVco (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265537AbUFTVcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:32:43 -0400
Received: from wblv-235-33.telkomadsl.co.za ([165.165.235.33]:11447 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265515AbUFTVcW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:32:22 -0400
Subject: Re: [PATCH 2/2] kbuild: Improved external module support
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: arjanv@redhat.com
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
In-Reply-To: <1087766729.2805.15.camel@laptop.fenrus.com>
References: <20040620211905.GA10189@mars.ravnborg.org>
	 <20040620212353.GD10189@mars.ravnborg.org>
	 <1087766729.2805.15.camel@laptop.fenrus.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-YGG/PRmqJXmXn/IA04AO"
Message-Id: <1087767103.14794.44.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 20 Jun 2004 23:31:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-YGG/PRmqJXmXn/IA04AO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-20 at 23:25, Arjan van de Ven wrote:
> > #   3) The build symlink now points to the output of the kernel
> > #      compile.
> > #      - When a kernel is compiled with output and source
> > #        mixed, the build and source symlinks will point
> > #        to the same directory. In this case there is
> > #        no change in behaviour.
>=20
> > #   It is recommended that distributions pick up this
> > #   method, and especially start shipping kernel output and
> > #   source separately.
> > #  =20
>=20
> I don't see the point of this; module builds don't use the output of the
> kernel compile but the SOURCE, eg the headers and Makefiles.
>=20
> I don't see a reason for this change; at least what I ship right now for
> the Fedora Core 2 kernel seems to work for all modules with sane
> makefiles so far....

And is going to break a lot of things - IMHO not an change for a
'stable' release.


--=20
Martin Schlemmer

--=-YGG/PRmqJXmXn/IA04AO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1gI/qburzKaJYLYRAg1qAJ993BSrbmEN8HH6xglKmkeQKOe4mACeO3WF
9aox7tprDCqGOH8z/nZkLrE=
=aLG+
-----END PGP SIGNATURE-----

--=-YGG/PRmqJXmXn/IA04AO--

