Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbUHDJQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUHDJQX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 05:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUHDJQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 05:16:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58755 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261763AbUHDJQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 05:16:21 -0400
Subject: Re: [patch] Add a writer prior lock methord for rwlock
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Liu Tao <liutao@safe-mail.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4110A7AF.2060903@safe-mail.net>
References: <4110A7AF.2060903@safe-mail.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iucl4eAhWS2qu5GYurBY"
Organization: Red Hat UK
Message-Id: <1091610963.2792.13.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 04 Aug 2004 11:16:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iucl4eAhWS2qu5GYurBY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-08-04 at 11:09, Liu Tao wrote:
> The patch adds the write_forcelock() methord, which has higher priority t=
han
> read_lock() and write_lock(). The original read_lock() and write_lock()=20
> is not
> touched, and the unlock methord is still write_unlock();
> The patch gives implemention on i386, for kernel 2.6.7.

can you please elaborate what kind of usage scenarios this would be
useful ? It would be nice to know what this is for ;)

--=-iucl4eAhWS2qu5GYurBY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBEKlTxULwo51rQBIRAoGsAJ9MS9tBmSaCO3v6Z+xT+/GH23NDrgCfX/nC
Sprv0RJiE4xIYrvtk5RWVYg=
=M3TT
-----END PGP SIGNATURE-----

--=-iucl4eAhWS2qu5GYurBY--

