Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264910AbUFXNt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbUFXNt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbUFXNtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:49:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40906 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264826AbUFXNtn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:49:43 -0400
Date: Thu, 24 Jun 2004 15:49:00 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using gcc built-ins for bitops?
Message-ID: <20040624134900.GG21376@devserv.devel.redhat.com>
References: <2awGH-DF-17@gated-at.bofh.it> <E1BdUZ0-00004M-QC@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RE3pQJLXZi4fr8Xo"
Content-Disposition: inline
In-Reply-To: <E1BdUZ0-00004M-QC@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RE3pQJLXZi4fr8Xo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 24, 2004 at 03:46:50PM +0200, Pascal Schmidt wrote:
> On Thu, 24 Jun 2004 09:20:07 +0200, you wrote in linux.kernel:
> 
> > +#if __GNUC_MINOR__ >= 4
> > +#define HAVE_BUILTIN_CTZL
> > +#endif
> 
> Eh, what value does __GNUC_MINOR__ have for, say, gcc-2.95.x?

gcc 2.x.y do not use compiler-gcc3.h but compiler-gcc2.h instead so that is
irrelevant ;)

--RE3pQJLXZi4fr8Xo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFA2tvLxULwo51rQBIRAg9qAJ9i2CwOPXwSCVwG28a7JZK1n716rgCfdA6N
3vf8bol4z3wSDgTd0Pv95DE=
=Vx2p
-----END PGP SIGNATURE-----

--RE3pQJLXZi4fr8Xo--
