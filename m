Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266359AbUFYIb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266359AbUFYIb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 04:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266567AbUFYIb6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 04:31:58 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14800 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266571AbUFYIb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 04:31:27 -0400
Subject: Re: 2.6.7-mm2, mmaps rework, buggy apps, setarch
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040625082243.GA11515@gamma.logic.tuwien.ac.at>
References: <20040625082243.GA11515@gamma.logic.tuwien.ac.at>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8yiIUIsvhzMu1jUpUtM1"
Organization: Red Hat UK
Message-Id: <1088152275.2704.8.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 25 Jun 2004 10:31:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8yiIUIsvhzMu1jUpUtM1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


>=20
> Can someone please explain me *what* the effects of a `buggy app' would
> be: Segfault I suppose. But what to do with a commerical app where I
> cannot check a stack trace or whatever?

basically the applications that break do:

int ptr;

ptr =3D malloc(some_size);

if (ptr <=3D 0)=20
    handle_no_memory();



> Background: I am having problems with current debian/sid on 2.6.7-mm2
> with vuescan.

can you describe these problems in somewhat more detail ?

--=-8yiIUIsvhzMu1jUpUtM1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA2+LSxULwo51rQBIRAoxDAJ9ZvUMSbnFRHuQ4urn3BfvmOiuXkwCfUgxo
UgpzWyU1n0chABr7r0bufbE=
=Y/97
-----END PGP SIGNATURE-----

--=-8yiIUIsvhzMu1jUpUtM1--

