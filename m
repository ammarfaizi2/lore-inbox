Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUCGNEF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 08:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUCGNEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 08:04:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17313 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261904AbUCGNEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 08:04:02 -0500
Subject: Re: External kernel modules, second try
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Gruenbacher <agruen@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       "kbuild-devel@lists.sourceforge.net" 
	<kbuild-devel@lists.sourceforge.net>
In-Reply-To: <20040307125348.GA2020@mars.ravnborg.org>
References: <1078620297.3156.139.camel@nb.suse.de>
	 <20040307125348.GA2020@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LeVtQ4ZMwCtcq1Cdo9IC"
Organization: Red Hat, Inc.
Message-Id: <1078664629.9812.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 07 Mar 2004 14:03:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LeVtQ4ZMwCtcq1Cdo9IC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


>=20
> Could you explain what is the actually gain of using the
> modversions file your patch creates. (modpost changes)

distributions don't like to install the vmlinux since it's big(ish) and
means customers need to download a new vmlinux at each kernel erratum.
The same information is btw also present in System.map so imo the real
solution is to make modpost use System.map instead ;)
> > modules SUBDIRS=3D$PWD'' works against a read-only tree.
> Agree - should be easy to test using a CD.
> Are there an easy way to mount just a directory structure RO?

not without making it a separate partition or loopback device.


--=-LeVtQ4ZMwCtcq1Cdo9IC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBASx20xULwo51rQBIRAoxLAKCqLx/mgbNqmS9P0Z6jPQNCM4KhFwCdFFIW
8BCs/sdPBhOrkkV2OzU1cX0=
=5Olr
-----END PGP SIGNATURE-----

--=-LeVtQ4ZMwCtcq1Cdo9IC--

