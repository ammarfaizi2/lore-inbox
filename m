Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965590AbVKGXUH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965590AbVKGXUH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 18:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965594AbVKGXUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 18:20:07 -0500
Received: from attila.bofh.it ([213.92.8.2]:40143 "EHLO attila.bofh.it")
	by vger.kernel.org with ESMTP id S965590AbVKGXUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 18:20:05 -0500
Date: Tue, 8 Nov 2005 00:19:57 +0100
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg KH <greg@kroah.com>, Pozsar Balazs <pozsy@uhulinux.hu>,
       linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
       333052@bugs.debian.org
Subject: Re: 2.6.14, udev: unknown symbols for ehci_hcd
Message-ID: <20051107231957.GA13521@wonderland.linux.it>
References: <436CD1BC.8020102@t-online.de> <20051105162503.GC20686@kroah.com> <436D9BDE.3060404@t-online.de> <20051106215158.GB3603@kroah.com> <20051107113329.GA7632@wonderland.linux.it> <20051107173157.GA16465@kroah.com> <20051107190738.GC22737@ojjektum.uhulinux.hu> <20051107191214.GA20364@kroah.com> <1131405438.21610.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <1131405438.21610.17.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: md@Linux.IT (Marco d'Itri)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 08, Rusty Russell <rusty@rustcorp.com.au> wrote:

> The current simple fix for that (thanks Pozsar!) is to poll while a
> module we rely on is still loading as indicated in /proc/modules.  This
> fix will be needed to cover existing kernels, even if we were to get
> fancy in new kernels.
I have *not* been able to verify this, but at least two people still
reported problems after using this patch.

--=20
ciao,
Marco

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDb+EdFGfw2OHuP7ERAuHBAKCc56u2WPFTCV745647Q4BrqJJlHwCfaadV
hH+XjeGzfjrM1UFkM7WjJBk=
=Mlm+
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
