Return-Path: <linux-kernel-owner+w=401wt.eu-S932208AbXAIQaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbXAIQaG (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbXAIQaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:30:05 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33633 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932208AbXAIQaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:30:04 -0500
Message-ID: <45A3C2CE.7070500@redhat.com>
Date: Tue, 09 Jan 2007 08:29:02 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Pierre Peiffer <pierre.peiffer@bull.net>
CC: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Jakub Jelinek <jakub@redhat.com>,
       Darren Hart <dvhltc@us.ibm.com>,
       =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Subject: Re: [PATCH 2.6.20-rc4 1/4] futex priority based wakeup
References: <45A3B330.9000104@bull.net> <45A3BFC8.1030104@bull.net>
In-Reply-To: <45A3BFC8.1030104@bull.net>
X-Enigmail-Version: 0.94.1.2.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig095198DC409F14AB98C812B2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig095198DC409F14AB98C812B2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Pierre Peiffer wrote:
> This patch makes use of plist (pirotity ordered lists) instead of simpl=
e
> list in
> futex_hash_bucket.

I have never seen performance numbers for this.  If it is punishing
existing code in a measurable way I think it's not anacceptable default
behavior.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig095198DC409F14AB98C812B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFo8LO2ijCOnn/RHQRAjKJAKCRTuVGuyI/cZpTdIbpBsjt24x+JwCfRw71
BMdRCtzRfzHkl/pD35IRRVc=
=JzLq
-----END PGP SIGNATURE-----

--------------enig095198DC409F14AB98C812B2--
