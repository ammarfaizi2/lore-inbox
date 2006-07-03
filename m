Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751175AbWGCOQg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbWGCOQg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 10:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWGCOQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 10:16:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57499 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751175AbWGCOQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 10:16:35 -0400
Message-ID: <44A926C9.8050507@redhat.com>
Date: Mon, 03 Jul 2006 07:16:41 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Woodhouse <dwmw2@infradead.org>, ak@muc.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Support TIF_RESTORE_SIGMASK on x86_64
References: <1151919711.3000.82.camel@pmac.infradead.org> <20060703031937.274aa506.akpm@osdl.org>
In-Reply-To: <20060703031937.274aa506.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig92E3962C78DF1821849756BE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig92E3962C78DF1821849756BE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Andrew Morton wrote:
> We struggled with these patches quite a lot when they were in Andi's tr=
ee.=20
> My test box would get stuck during kernel compiles and Andi could never=

> reproduce it.

Try the patch.   dwmw2's change made all the difference for me.  The old
kernel wasn't able to handle the glibc test suite, this one does.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig92E3962C78DF1821849756BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEqSbJ2ijCOnn/RHQRAkhSAJ0UUB2MYbMJvTfqF2tkrRE/vAVAHwCfZsp/
/dX9dOaN3Yjin/5zxmLNR94=
=wDdw
-----END PGP SIGNATURE-----

--------------enig92E3962C78DF1821849756BE--
