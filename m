Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267469AbUHPHMM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267469AbUHPHMM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 03:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267477AbUHPHMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 03:12:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17112 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267469AbUHPHMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 03:12:09 -0400
Subject: Re: DRM and 2.4 ...
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Dave Airlie <airlied@linux.ie>
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0408160652350.9944@skynet>
References: <Pine.LNX.4.58.0408160652350.9944@skynet>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-s9wJ45WTw5sKXw64eqeP"
Organization: Red Hat UK
Message-Id: <1092640312.2791.6.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 09:11:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-s9wJ45WTw5sKXw64eqeP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-08-16 at 07:56, Dave Airlie wrote:
> At the moment we are adding a lot of 2.6 stuff to the DRM under
> development in the DRM CVS tree and what will be merged into the -mm and
> Linus trees eventually, this has meant ifdefing stuff out so 2.4 will
> still work,

which is uglyfying the code significantly if done wrong

> So the question is do we want to a final stable DRM for 2.4 in the next
> 2.4 release? and after that point I can tag the 2.4 release in the DRM CV=
S
> tree (and maybe branch it ...),

I would strongly urge you to no longer update DRM in 2.4 in significant
ways. 2.4 is the release for doing strict maintenance; people who want
to run newer X will generally run 2.6 kernels as well anyway.


--=-s9wJ45WTw5sKXw64eqeP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBIF44xULwo51rQBIRAo5rAKCHCx1ysGuK5WNi0lti9pQ1iXWaKACdEscT
QDr3vtY7xJG4oNjrIN2kgxw=
=oPYR
-----END PGP SIGNATURE-----

--=-s9wJ45WTw5sKXw64eqeP--

