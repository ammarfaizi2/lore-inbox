Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWHTPWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWHTPWY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 11:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWHTPWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 11:22:24 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:50139 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750729AbWHTPWX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 11:22:23 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][CHAR] Return better error codes if drivers/char/raw.c module init fails
Date: Sun, 20 Aug 2006 17:22:45 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, "Chen, Kenneth W" <kenneth.w.chen@intel.com>
References: <200608180918.30483.eike-kernel@sf-tec.de> <20060818162743.f97ff431.akpm@osdl.org>
In-Reply-To: <20060818162743.f97ff431.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1288915.yfDmmHoooU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608201722.45401.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1288915.yfDmmHoooU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Andrew Morton wrote:
> On Fri, 18 Aug 2006 09:18:30 +0200
>
> Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > Currently this module just returns 1 if anything on module init fails.
> > Store the error code of the different function calls and return their
> > error on problems.
> >
> > I'm not sure if this doesn't need even more cleanup, for example
> > kobj_put() is called only in one error case.
>
> You seem to be using kmail in funky-confuse-sylpheed mode.  Inlined patch=
es
> in plain-text emails are preferred, please.

Sorry, I left the "sign mail" activated by accident. gpg-agent had the=20
password still cached, otherwise I would have seen that.

Eike

--nextPart1288915.yfDmmHoooU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBE6H5FXKSJPmm5/E4RApMcAJ438e2bJAh+5gYtVqNsbHZMtfx0fACfRIwH
qHCvnwjfpft1+syR6ENSJb8=
=bPr1
-----END PGP SIGNATURE-----

--nextPart1288915.yfDmmHoooU--
