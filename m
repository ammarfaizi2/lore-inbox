Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbTLOIzW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 03:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTLOIzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 03:55:22 -0500
Received: from node-d-1fcf.a2000.nl ([62.195.31.207]:39808 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263412AbTLOIzS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 03:55:18 -0500
Subject: Re: [patch] Re: Problem with exiting threads under NPTL
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Roland McGrath <roland@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0312141353220.1586@home.osdl.org>
References: <20031214052516.GA313@vana.vc.cvut.cz>
	 <Pine.LNX.4.58.0312142032310.9900@earth>
	 <Pine.LNX.4.58.0312141228170.1478@home.osdl.org>
	 <Pine.LNX.4.58.0312142205050.13533@earth>
	 <Pine.LNX.4.58.0312141353220.1586@home.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4k+eG7o457hGRRN9yv4d"
Organization: Red Hat, Inc.
Message-Id: <1071478455.5223.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 15 Dec 2003 09:54:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4k+eG7o457hGRRN9yv4d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-12-14 at 23:10, Linus Torvalds wrote:

> Even though the parent ignores SIGCHLD it _can_ be running on another CPU
> in "wait4()".

which fwiw is a case of illegal behavior in the program ... of course
the kernel shouldn't die if it happens.

--=-4k+eG7o457hGRRN9yv4d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/3Xa3xULwo51rQBIRAgT4AJ4zLNwVFThsU2w7F02WjvuIMddl2QCdFo//
tyb2FjQrk9sGepHUNz+BvAs=
=tH4t
-----END PGP SIGNATURE-----

--=-4k+eG7o457hGRRN9yv4d--
