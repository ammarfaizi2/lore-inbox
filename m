Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUFFP6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUFFP6P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 11:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263763AbUFFP6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 11:58:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10438 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263752AbUFFP6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 11:58:13 -0400
Subject: Re: Using getpid() often, another way? [was Re: clone() <->
	getpid() bug in 2.6?]
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Russell Leighton <russ@elegant-software.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <40C33A84.4060405@elegant-software.com>
References: <40C1E6A9.3010307@elegant-software.com>
	 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
	 <40C32A44.6050101@elegant-software.com>
	 <40C33A84.4060405@elegant-software.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ydn0fas4sJKfseuLaYzh"
Organization: Red Hat UK
Message-Id: <1086537490.3041.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 06 Jun 2004 17:58:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ydn0fas4sJKfseuLaYzh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-06-06 at 17:38, Russell Leighton wrote:
> I have a library that creates 2 threads using clone().
> [NOTE: I can't use pthreads for a variety of reasons, mostly due
> to the wacky signal handling rules...it turns out that using clone() is=20
> cleaner for me anyway.]

a library using clone sounds suspect to me, I can't imagine an app using
pthreads being able to just use your library as a result. Note also that
clone() is not a portable interface even within linux architectures.


--=-Ydn0fas4sJKfseuLaYzh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAwz8SxULwo51rQBIRAlLmAJ9D7kmQdzv4fTCOTRFjAw7dZd/81wCghwvB
92cb7MPlxb7JX1Lw87q2X8I=
=pbag
-----END PGP SIGNATURE-----

--=-Ydn0fas4sJKfseuLaYzh--

