Return-Path: <linux-kernel-owner+w=401wt.eu-S1751965AbXAPRrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbXAPRrf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbXAPRrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:47:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41226 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965AbXAPRre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 12:47:34 -0500
Message-ID: <45AD0F70.30808@redhat.com>
Date: Tue, 16 Jan 2007 09:46:24 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Pierre Peiffer <pierre.peiffer@bull.net>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Jakub Jelinek <jakub@redhat.com>
Subject: Re: [PATCH 2.6.20-rc4 0/4] futexes functionalities and improvements
References: <45A3BFAC.1030700@bull.net> <45A67830.4050207@redhat.com> <20070111134615.34902742.akpm@osdl.org> <45A73E90.7050805@bull.net> <20070112075816.GA23341@elte.hu> <45AC8E2A.3060708@bull.net> <45ACEBDF.60602@redhat.com> <20070116154054.GA21786@elte.hu>
In-Reply-To: <20070116154054.GA21786@elte.hu>
X-Enigmail-Version: 0.94.1.2.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig50C54277E1FDDD485760C07F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig50C54277E1FDDD485760C07F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Ingo Molnar wrote:
> what do you mean by that - which is this same resource?

=46rom what has been said here before, all futexes are stored in the same=

list or hash table or whatever it was.  I want to see how that code
behaves if many separate processes concurrently use futexes.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig50C54277E1FDDD485760C07F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFrQ912ijCOnn/RHQRAkA2AKCUJvmSdAVMageJQTu9gYtNoFHG3wCgjwln
p089zwg8SNAT3EzqKhCIe9w=
=tfSO
-----END PGP SIGNATURE-----

--------------enig50C54277E1FDDD485760C07F--
