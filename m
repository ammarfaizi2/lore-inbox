Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263574AbUFVNvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263574AbUFVNvS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 09:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUFVNvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 09:51:12 -0400
Received: from mail022.syd.optusnet.com.au ([211.29.132.100]:20929 "EHLO
	mail022.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263574AbUFVNtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 09:49:41 -0400
Subject: Re: [2.6.7-bk] NFS-related kernel panic
From: Stewart Smith <stewart@flamingspork.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Bob Gill <gillb4@telusplanet.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       akepner@sgi.com
In-Reply-To: <20040621203520.H22989@build.pdx.osdl.net>
References: <1087872607.4066.13.camel@localhost.localdomain>
	 <20040621203520.H22989@build.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sXR9h3aEXb3vhXNhgdKX"
Message-Id: <1087911479.4691.4.camel@kennedy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Jun 2004 23:37:59 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-sXR9h3aEXb3vhXNhgdKX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-22 at 13:35, Chris Wright wrote:
> > bad: scheduling while atomic!
> The lockless loopback transmission patch mucks up the preempt count.
> Can you give this patch a try?

This seems to fix the problem, thanks.

--=20
Stewart Smith (stewart@flamingspork.com)
http://www.flamingspork.com/


--=-sXR9h3aEXb3vhXNhgdKX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA2DY33tgLgERgy8oRAg5JAJ9XMGm4Rh+C7PIvsXkPaRVIN132fgCgxlu6
065sZ1qOJLj6ytZHjbNjyEI=
=CAyu
-----END PGP SIGNATURE-----

--=-sXR9h3aEXb3vhXNhgdKX--

