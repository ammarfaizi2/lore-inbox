Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265287AbUFTVZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265287AbUFTVZv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 17:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbUFTVZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 17:25:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22149 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265287AbUFTVZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 17:25:49 -0400
Subject: Re: [PATCH 2/2] kbuild: Improved external module support
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Andreas Gruenbacher <agruen@suse.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
In-Reply-To: <20040620212353.GD10189@mars.ravnborg.org>
References: <20040620211905.GA10189@mars.ravnborg.org>
	 <20040620212353.GD10189@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-JZVMy9v7kvHTqELCBoTG"
Organization: Red Hat UK
Message-Id: <1087766729.2805.15.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 20 Jun 2004 23:25:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JZVMy9v7kvHTqELCBoTG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> #   3) The build symlink now points to the output of the kernel
> #      compile.
> #      - When a kernel is compiled with output and source
> #        mixed, the build and source symlinks will point
> #        to the same directory. In this case there is
> #        no change in behaviour.

> #   It is recommended that distributions pick up this
> #   method, and especially start shipping kernel output and
> #   source separately.
> #  =20

I don't see the point of this; module builds don't use the output of the
kernel compile but the SOURCE, eg the headers and Makefiles.

I don't see a reason for this change; at least what I ship right now for
the Fedora Core 2 kernel seems to work for all modules with sane
makefiles so far....


--=-JZVMy9v7kvHTqELCBoTG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1gDJxULwo51rQBIRApj5AJ9cXDVp1qv5ZHRMS1W2Um05tL/EHwCeLOAd
xvuBcGUDnf9CeXThaIcPYu4=
=BY9w
-----END PGP SIGNATURE-----

--=-JZVMy9v7kvHTqELCBoTG--

