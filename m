Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263895AbUFSOjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263895AbUFSOjA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 10:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbUFSOjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 10:39:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25809 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263895AbUFSOiz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 10:38:55 -0400
Subject: Re: [PATCH] Handle non-readable binfmt_misc executables
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: yoav.zach@intel.com, torvalds@osdl.org
In-Reply-To: <200406181612.i5IGCIYY001854@hera.kernel.org>
References: <200406181612.i5IGCIYY001854@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Fy5wX+mYS5Bo0pcK6KoW"
Organization: Red Hat UK
Message-Id: <1087655927.15190.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 19 Jun 2004 16:38:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Fy5wX+mYS5Bo0pcK6KoW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> +_error_close_file:
> +	if (fd_binary > 0) {
> +		sys_close (fd_binary);
> +		fd_binary =3D -1;
> +		bprm->file =3D NULL;
> +=09


ewww sys_close.... there HAS to be a better way to do that...=20

--=-Fy5wX+mYS5Bo0pcK6KoW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1E/3xULwo51rQBIRAiZpAJ9CFJEeSdfLDJqIwgW3mhMeQajLjACfWmBU
1xbhrqloAs+1T9bh7q0j3/M=
=Z8pg
-----END PGP SIGNATURE-----

--=-Fy5wX+mYS5Bo0pcK6KoW--

