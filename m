Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUEWHNg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUEWHNg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 03:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUEWHNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 03:13:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38121 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263024AbUEWHN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 03:13:28 -0400
Subject: Re: i486 emu in mainline?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, willy@w.ods.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040522234059.GA3735@infradead.org>
References: <20040522234059.GA3735@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+uFXnD+NzlZeTfyjEAd+"
Organization: Red Hat UK
Message-Id: <1085296400.2781.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 23 May 2004 09:13:20 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+uFXnD+NzlZeTfyjEAd+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-05-23 at 01:40, Christoph Hellwig wrote:
> These days gcc uses i486+ only instruction by default in libstdc++ so
> most modern distros wouldn't work on i386 cpus anymore.  To make it work
> again Debian merged Willy Tarreau's patch to trap those and emulate them
> on real i386 cpus.  The patch is extremely non-invasive and would
> certainly be usefull for mainline.  Any reason not to include it?
>=20

on first look it seems to be missing a bunch of get_user() calls and
does direct access instead....

--=-+uFXnD+NzlZeTfyjEAd+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAsE8PxULwo51rQBIRAiW4AKCPE6Zmh2MmBlMAb6Xefb4l/2xllgCgig7L
EkJjOQGb+loMYx1XTJdJ9zw=
=J1h5
-----END PGP SIGNATURE-----

--=-+uFXnD+NzlZeTfyjEAd+--

