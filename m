Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbVBZKhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVBZKhh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 05:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbVBZKhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 05:37:35 -0500
Received: from h01.hostsharing.net ([212.42.230.152]:23224 "EHLO
	pima.hostsharing.net") by vger.kernel.org with ESMTP
	id S261166AbVBZKh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 05:37:27 -0500
Date: Sat, 26 Feb 2005 11:37:22 +0100
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.11-rc5: Doesn't compile with gcc-3.4 on ppc
Message-ID: <20050226103722.GB7736@aragorn.home.lxtec.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
Organization: LXTEC
X-gnupg-key-fingerprint: BE65 85E4 4867 7E9B 1F2A  B2CE DC88 3C6E C54F 7FB0
User-Agent: Mutt/1.5.8+lxtec-i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

tried to build 2.6.11-rc5 on my powerbook, stops as follows:

  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  CHK     usr/initramfs_list
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
mm/built-in.o(.rodata.cst4+0x0): relocation truncated to fit: R_PPC_ADDR32 =
empty_zero_page+40000000
make[1]: *** [.tmp_vmlinux1] Error 1

gcc (GCC) 3.4.4 20050203 (prerelease) (Debian 3.4.3-9)
GNU ld version 2.15

Using gcc-3.3 (GCC) 3.3.5 (Debian 1:3.3.5-8) compiles well.

Any hints?
Elimar

--=20
  Do you smell something burning or ist it me?

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCIFFi3Ig8bsVPf7ARAnxJAJ0aEzDW1UXXFv3ligSjsesbkomtmQCgsAZv
kDqOwp8ZVg21Fdw1xNdPxPQ=
=MbQY
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
