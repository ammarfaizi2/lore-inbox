Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264857AbUHWGcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264857AbUHWGcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 02:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267443AbUHWGcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 02:32:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8916 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264857AbUHWGc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 02:32:29 -0400
Subject: Re: [PATCH] e1000 - Use vmalloc for data structures not shared
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ganesh.venkatesan@intel.com
In-Reply-To: <200408222225.i7MMPRNX019306@hera.kernel.org>
References: <200408222225.i7MMPRNX019306@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ham3SKUJ8ZBxxPJKhoig"
Organization: Red Hat UK
Message-Id: <1093242724.2792.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 23 Aug 2004 08:32:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ham3SKUJ8ZBxxPJKhoig
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-29 at 18:01, Linux Kernel Mailing List wrote:
> ChangeSet 1.1807.39.3, 2004/07/29 12:01:46-04:00, ganesh.venkatesan@intel=
.com
>=20
> 	[PATCH] e1000 - Use vmalloc for data structures not shared

eh why? You are aware that vmalloc'd datastructures are slower during
use (due to TLB overhead) right ?
These structures also don't look THAT big on first sight....

--=-Ham3SKUJ8ZBxxPJKhoig
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBKY9kxULwo51rQBIRAsxlAJsE2NnABHWAki6surdKuteyzhFAgQCeOisx
jYvQ+u1QezKsKvsJwXfGuJE=
=86Fg
-----END PGP SIGNATURE-----

--=-Ham3SKUJ8ZBxxPJKhoig--

