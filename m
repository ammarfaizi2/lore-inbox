Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbUA3TYF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 14:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbUA3TYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 14:24:05 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:59802 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263537AbUA3TYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 14:24:02 -0500
Subject: Re: 2.6.2-rc2-mm2
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: Torrey Hoffman <thoffman@arnor.net>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <200401302007.26333.thomas.schlichter@web.de>
References: <20040130014108.09c964fd.akpm@osdl.org>
	 <1075489136.5995.30.camel@moria.arnor.net>
	 <200401302007.26333.thomas.schlichter@web.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xkRAxDXiPlQsZ5n9EjdN"
Organization: Red Hat, Inc.
Message-Id: <1075490624.4272.7.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 30 Jan 2004 14:23:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xkRAxDXiPlQsZ5n9EjdN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-01-30 at 14:07, Thomas Schlichter wrote:
> Am Freitag, 30. Januar 2004 19:58 schrieb Torrey Hoffman:
> > On Fri, 2004-01-30 at 01:41, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-r=
c2/2
> > >.6.2-rc2-mm2/
> >
> > I used the rc2-mm1-1 patch and got this on make modules_install:
> >
> > WARNING: /lib/modules/2.6.2-rc2-mm2/kernel/net/sunrpc/sunrpc.ko needs
> > unknown symbol groups_free
> > WARNING: /lib/modules/2.6.2-rc2-mm2/kernel/fs/nfsd/nfsd.ko needs unknow=
n
> > symbol sys_setgroups
> >
> > Same .config had no problems in 2.6.2-rc2-mm1.
>=20
> The attached patches make it work for me...

directly calling sys_ANYTHING sounds really wrong to me...

--=-xkRAxDXiPlQsZ5n9EjdN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAGq9AxULwo51rQBIRAo7DAJ9eruPAtHOkrh0t4/FdR3UX93P4cACgi3nb
IR53D2JIys5wd7ABDwSnpfM=
=wyF5
-----END PGP SIGNATURE-----

--=-xkRAxDXiPlQsZ5n9EjdN--
