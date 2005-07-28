Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVG1O7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVG1O7D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:59:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVG1Ox5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:53:57 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:56020 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261541AbVG1OxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:53:02 -0400
Date: Fri, 29 Jul 2005 00:53:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: hch@infradead.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] compat_sys_read/write
Message-Id: <20050729005302.70f96ef5.sfr@canb.auug.org.au>
In-Reply-To: <20050729004838.116e8361.sfr@canb.auug.org.au>
References: <20050728234341.3303d5fe.sfr@canb.auug.org.au>
	<20050728141653.GA22173@infradead.org>
	<20050729004838.116e8361.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__29_Jul_2005_00_53_02_+1000_6rA5eOZEbWxblO1_"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__29_Jul_2005_00_53_02_+1000_6rA5eOZEbWxblO1_
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Jul 2005 00:48:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> readv/writev were done ages ago (since they are necessary for other

But you are right, compat_sys_readv/writev need adjusting to call the
compat_read/write method if they exist ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__29_Jul_2005_00_53_02_+1000_6rA5eOZEbWxblO1_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC6PFOFdBgD/zoJvwRAk3aAJ0dJTQzQQYl5nUITV4dNuiumE21yACgoefi
KGmhCzr7dh6wKMD+cO9SAqw=
=xfEV
-----END PGP SIGNATURE-----

--Signature=_Fri__29_Jul_2005_00_53_02_+1000_6rA5eOZEbWxblO1_--
