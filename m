Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVCUSub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVCUSub (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 13:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVCUSub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 13:50:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1215 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261554AbVCUSuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 13:50:24 -0500
Subject: Re: clone() and pthread_create() segment fault in 2.4.29
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: jmerkey <jmerkey@utah-nac.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <423F13EA.6050007@utah-nac.org>
References: <423F13EA.6050007@utah-nac.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cZPsz+KkKCLkndJH1x2d"
Organization: Red Hat, Inc.
Date: Mon, 21 Mar 2005 19:50:21 +0100
Message-Id: <1111431021.6952.73.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cZPsz+KkKCLkndJH1x2d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-03-21 at 11:35 -0700, jmerkey wrote:
> In case nobody has already reported it, clone() and pthread_create()=20
> return SIGSEGV faults
> when a 2.4.29 kernel on the Taroon Red Hat release.

you're running an OS that requires a kernel with NPTL support. Yet you
run a kernel without. Bad idea.



--=-cZPsz+KkKCLkndJH1x2d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCPxdtpv2rCoFn+CIRAj8/AJ937WBt6qEP+bCS4mkp6E28MNGN8gCfRwaz
uMvGzi76i4SrL5M7clzuKsg=
=Rsgr
-----END PGP SIGNATURE-----

--=-cZPsz+KkKCLkndJH1x2d--

