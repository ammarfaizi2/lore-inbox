Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbTJUIjo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 04:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbTJUIjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 04:39:43 -0400
Received: from smtp02.web.de ([217.72.192.151]:8220 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263039AbTJUIjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 04:39:37 -0400
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Andrew Morton <akpm@osdl.org>, Valdis.Kletnieks@vt.edu
Subject: Re: 2.6.0-test8-mm1
Date: Tue, 21 Oct 2003 10:39:18 +0200
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       James Simmons <jsimmons@infradead.org>
References: <20031020020558.16d2a776.akpm@osdl.org> <200310210046.h9L0kHFg001918@turing-police.cc.vt.edu> <20031020185613.7d670975.akpm@osdl.org>
In-Reply-To: <20031020185613.7d670975.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_7CPl/oUqXn2R+gk";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310211039.23358.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_7CPl/oUqXn2R+gk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 21 October 2003 03:56, Andrew Morton wrote:
> Valdis.Kletnieks@vt.edu wrote:
> > I've not had a chance to play binary search on those options yet..=20
> > Graphics card is an NVidia GeForce 440Go, and was previous working just
> > fine with framebuffer over on vc1-6 and NVidia's driver on an XFree86 on
> > vc7. (OK, I admit I didn't stress test the framebuffer side much past
> > "penguins and scroiled text"...)
>
> Thanks.  You're now the third person (schlicht@uni-mannheim.de,
> jeremy@goop.org) who reports that the weird oopses (usually in
> invalidate_list()) go away when the fbdev code is disabled.
>
> You're using vesafb on nvidia, Jeremy is using vesafb on either radeon or
> nvidia, not sure about Thomas.

Sorry for not mentioning it!
I use(d) vesafb on a Nvidia GeForce 2 MX 440.

> Has anyone tried CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC, see if that
> turns anything up?

I didn't yet, but I'll try now...

--Boundary-02=_7CPl/oUqXn2R+gk
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/lPC7YAiN+WRIZzQRAqg8AJ4rh0MlSoTsKndBF2/YDtCzi3JwZwCeNdfB
ffv+e7SJsjVcJRjeR8N/LRY=
=+aaQ
-----END PGP SIGNATURE-----

--Boundary-02=_7CPl/oUqXn2R+gk--
