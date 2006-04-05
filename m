Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751036AbWDEA3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbWDEA3E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWDEA3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:29:04 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:58261 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S1751036AbWDEA3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:29:01 -0400
Date: Wed, 5 Apr 2006 10:28:37 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Message-Id: <20060405102837.66b44c43.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0604041612320.30113-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0604041612320.30113-100000@gate.crashing.org>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Wed__5_Apr_2006_10_28_37_+1000_f=m16pQy4_7kJ7xT"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__5_Apr_2006_10_28_37_+1000_f=m16pQy4_7kJ7xT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Apr 2006 16:14:04 -0500 (CDT) Kumar Gala <galak@kernel.crashing.o=
rg> wrote:
>
> Please pull from 'for_paulus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git
>=20
> to receive the following updates:
>=20
>  arch/powerpc/configs/mpc85xx_cds_defconfig |  846 ++++++++++++++++++++++=
+++++++
>  arch/powerpc/kernel/ppc_ksyms.c            |    1=20
>  arch/powerpc/platforms/85xx/Kconfig        |    9=20
>  arch/powerpc/platforms/85xx/Makefile       |    1=20
>  arch/powerpc/platforms/85xx/mpc85xx_cds.c  |  359 ++++++++++++
>  arch/powerpc/platforms/85xx/mpc85xx_cds.h  |   43 +
>  arch/ppc/kernel/ppc_ksyms.c                |    1=20
>  include/asm-ppc/mpc85xx.h                  |    3=20
>  8 files changed, 1262 insertions(+), 1 deletion(-)
>=20
> Andy Fleming:
>       Add 85xx CDS to arch/powerpc

Could these "add xxx to arch/powerpc" patches please move any relevant
headers files to include/asm-powerpc as well.  It would be nice if we
could remove the hack from the powerpc Makefile that include files from
include/asm-ppc.  i.e. My opinion is that if any ARCH=3Dpowerpc build
requires a file in include/asm-ppc, then that file should be moved to
include/asm-powerpc.  I am doing a set of patches to that effect.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__5_Apr_2006_10_28_37_+1000_f=m16pQy4_7kJ7xT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEMw8+FdBgD/zoJvwRAkpyAJ0WnqUuJe8uJs9RSfJr+XT+lHwVTgCeJU9k
cpgsvEMLlU4qZRK8wqGHBuw=
=9zpQ
-----END PGP SIGNATURE-----

--Signature=_Wed__5_Apr_2006_10_28_37_+1000_f=m16pQy4_7kJ7xT--
