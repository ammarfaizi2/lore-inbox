Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268003AbUIGMkw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268003AbUIGMkw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUIGMkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:40:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33212 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268003AbUIGMi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:38:28 -0400
Subject: Re: attribute warn_unused_result
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <413DA83A.7010704@kolivas.org>
References: <413DA83A.7010704@kolivas.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZnpzKdRRTLCfh0sq7DRn"
Organization: Red Hat UK
Message-Id: <1094560688.2801.11.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 07 Sep 2004 14:38:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZnpzKdRRTLCfh0sq7DRn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-07 at 14:23, Con Kolivas wrote:
> Gcc3.4.1 has recently been complaining of a number of unused results=20
> from function with attribute warn_unused_result set. I'm not sure of how=20
> you want to tackle this so I'm avoiding posting patches. Should we=20
> remove the attribute (seems the likely option) or set some dummy=20
> variable (sounds stupid now that I ask it).

that attribute is supposed to only be set for functions you really ought
to check the result for.... so how about checking/using the result ?

--=-ZnpzKdRRTLCfh0sq7DRn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBPauwxULwo51rQBIRApFYAJ9zFNUmUlEJ6bnPJVNER6kCF1qfiQCfU3EP
dpeVjqv3Ok+3DyKTowYD8sI=
=794E
-----END PGP SIGNATURE-----

--=-ZnpzKdRRTLCfh0sq7DRn--

