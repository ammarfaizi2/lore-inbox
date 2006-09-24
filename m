Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWIXQsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWIXQsv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 12:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWIXQsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 12:48:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43490 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751150AbWIXQsu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 12:48:50 -0400
Message-ID: <4516B721.5070801@redhat.com>
Date: Sun, 24 Sep 2006 09:49:37 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Stas Sergeev <stsp@aknet.ru>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru>	 <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>	 <451555CB.5010006@aknet.ru>	 <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>	 <1159037913.24572.62.camel@localhost.localdomain>	 <45162BE5.2020100@aknet.ru> <1159106032.11049.12.camel@localhost.localdomain> <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com> <4516B2C8.4050202@aknet.ru>
In-Reply-To: <4516B2C8.4050202@aknet.ru>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig32CC7E3695CE61F9250DEB5B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig32CC7E3695CE61F9250DEB5B
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Stas Sergeev wrote:
> Exactly. So why such a "middle-ground" solution is currently
> there? I can:
> 1. mprotect() the existing mapping to PROT_EXEC and bypass the
> checks (but you can easily restrict that by patching mprotect()).

The consensus has been to add the same checks to mprotect.  They were
not left out intentionally.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig32CC7E3695CE61F9250DEB5B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFFrch2ijCOnn/RHQRAkChAKCeuWiKSQSufq+U/0/VvMQBrh1c/wCdEdS+
Rg6ENvSDnhSt7k3KzP/UTe0=
=5T2q
-----END PGP SIGNATURE-----

--------------enig32CC7E3695CE61F9250DEB5B--
