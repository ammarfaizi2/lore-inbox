Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269661AbUICMda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269661AbUICMda (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269662AbUICMda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:33:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20368 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269661AbUICMdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:33:18 -0400
Subject: Re: [PATCH] 2.6.8.1 ES7000 subarch update
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jason Davis <jason.davis@unisys.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1094210117.7533.28.camel@localhost.localdomain>
References: <20040902235214.GA21954@righTThere.net>
	 <1094210117.7533.28.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kX6/44nlLUqjvUoETH9H"
Organization: Red Hat UK
Message-Id: <1094214773.2823.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 03 Sep 2004 14:32:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kX6/44nlLUqjvUoETH9H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-09-03 at 13:15, Alan Cox wrote:
> On Gwe, 2004-09-03 at 00:52, Jason Davis wrote:
> >  int 			mip_port;
> >  unsigned long		mip_addr, host_addr;
> > =20
> > +EXPORT_SYMBOL(mip_reg);
> > +EXPORT_SYMBOL(host_reg);
> > +EXPORT_SYMBOL(mip_port);
> > +EXPORT_SYMBOL(mip_addr);
> > +EXPORT_SYMBOL(host_addr);
>=20
> This is asking for collisions with other modules. It would be a lot
> better for the future it these became e7000_mip_reg etc I think.

they seem to also be exclusively for a binary only kernel module.....
hot topic.


--=-kX6/44nlLUqjvUoETH9H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBOGR1xULwo51rQBIRAhrhAJ9MNjTi7wVrG+VgOZug8jbnib9O4gCfWhO9
6i3cxe0wB3a/UDNeEVa6LAM=
=2b1o
-----END PGP SIGNATURE-----

--=-kX6/44nlLUqjvUoETH9H--

