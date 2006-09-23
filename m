Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbWIWPf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWIWPf7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 11:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWIWPf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 11:35:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19659 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751247AbWIWPf6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 11:35:58 -0400
Message-ID: <45155499.4000209@redhat.com>
Date: Sat, 23 Sep 2006 08:36:57 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Stas Sergeev <stsp@aknet.ru>, Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru> <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1F344651CE472136269B0682"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1F344651CE472136269B0682
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hugh Dickins wrote:
> so let's CC Ulrich Drepper in case he's changed his mind on it.

Definitely not.  The test should stay.  It does the right thing.  Yes,
some applications might break, but this is the fault of the application.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig1F344651CE472136269B0682
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFFVSZ2ijCOnn/RHQRAqcnAJ9ZHK43I+GWHaTSkpBS89A040ya3ACdGVUB
ne/vUQtAIdR9aOxQ5P0FGZ4=
=bklb
-----END PGP SIGNATURE-----

--------------enig1F344651CE472136269B0682--
