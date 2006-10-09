Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932763AbWJIM7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932763AbWJIM7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 08:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbWJIM7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 08:59:36 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:5808 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932763AbWJIM7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 08:59:35 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] kernel-doc: drop __must_check and various "inline"  qualifiers
Date: Mon, 9 Oct 2006 15:00:18 +0200
User-Agent: KMail/1.9.4
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <20061008200851.47eb99da.rdunlap@xenotime.net>
In-Reply-To: <20061008200851.47eb99da.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1235731.fTfNZWmWVe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610091500.24131.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1235731.fTfNZWmWVe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@xenotime.net>
>
> Drop __inline, __always_inline, noinline, and __must_check in the
> produced kernel-doc output, similar to other pseudo directives.

The inline status of a function is not of much help for a developer, that's=
=20
right. But I would like to see the the __must_check in the documentation.=20
This it what makes a difference, the inline stuff is extraneous.

Eike

--nextPart1235731.fTfNZWmWVe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFKkfoXKSJPmm5/E4RAu4hAJ9DDF2jOW+96cII5PonBzQ2lag/KgCbB+yY
ImLkpQSt4WXMIhklbKh1dKM=
=6FJ0
-----END PGP SIGNATURE-----

--nextPart1235731.fTfNZWmWVe--
