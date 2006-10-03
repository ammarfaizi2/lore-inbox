Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030339AbWJCRWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWJCRWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 13:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWJCRWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 13:22:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58058 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030339AbWJCRWW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 13:22:22 -0400
Message-ID: <45229C8E.6080503@redhat.com>
Date: Tue, 03 Oct 2006 10:23:26 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Stas Sergeev <stsp@aknet.ru>
CC: Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Valdis.Kletnieks@vt.edu
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru>	 <1159106032.11049.12.camel@localhost.localdomain>	 <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com>	 <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>	 <45198395.4050008@aknet.ru>	 <1159396436.3086.51.camel@laptopd505.fenrus.org>  <451E3C0C.10105@aknet.ru> <1159887682.2891.537.camel@laptopd505.fenrus.org> <45229A99.6060703@aknet.ru>
In-Reply-To: <45229A99.6060703@aknet.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6DD91332DBD04335DF8DD67D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6DD91332DBD04335DF8DD67D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

You keep repeating the same nonsense over and over again, lot listening
to anybody who doesn't agree with your position.

If you don't want to have the noexec semantics on a filesystem, remove
it.  Not using the strict (mmap + protect) makes the whole thing
completely meaningless since ld.so can be invoked directly.

If anything breaks for  you, remove the noexec  mount flag.  But don't
argue that because noexec doesn't provide 100% security (which it cannot
alone, of course) it needs not be strict at all.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig6DD91332DBD04335DF8DD67D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFIpyO2ijCOnn/RHQRAq2tAJ94L9Dd4ho1C+r/sMcAuXJIWwUh/ACgp1Dz
RMnemxlVtEqg4b1v6vE2vdw=
=aL40
-----END PGP SIGNATURE-----

--------------enig6DD91332DBD04335DF8DD67D--
