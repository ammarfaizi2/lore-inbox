Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVL3DF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVL3DF5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 22:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbVL3DF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 22:05:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20667 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750798AbVL3DF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 22:05:56 -0500
Message-ID: <43B4A3CA.4060406@redhat.com>
Date: Thu, 29 Dec 2005 19:04:42 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mail/News 1.5 (X11/20051129)
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make sysenter support optional
References: <20051228212402.GX3356@waste.org>	 <a36005b50512281407x74415958tb0fa2b52f4dd7988@mail.gmail.com>	 <43B30E19.6080207@redhat.com> <20051229195641.GB3356@waste.org> <a36005b50512291901l6a5acb77ha17d3552ea9c9fd9@mail.gmail.com>
In-Reply-To: <a36005b50512291901l6a5acb77ha17d3552ea9c9fd9@mail.gmail.com>
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC3BE90920A4D78BBE6B7E39B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC3BE90920A4D78BBE6B7E39B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> It's under CONFIG_EMBEDDED. Think uclibc. Think systems without
> interactive shells.

Interactive or not has absolutely nothing to do with this.  And other
libcs have the same issues wrt to backtraces.  And finally, there is
unfortunately no way to prevent somebody from using glibc on an
"embedded" kernel and I have no interest in getting "bug reports" caused
by this kind of user error.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enigC3BE90920A4D78BBE6B7E39B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDtKPK2ijCOnn/RHQRAlDLAJ493rL3IjsfykMtk9EEQDDk+xREcACgqtS2
MUBt436B99fRPAceetsQtg0=
=eyFH
-----END PGP SIGNATURE-----

--------------enigC3BE90920A4D78BBE6B7E39B--
