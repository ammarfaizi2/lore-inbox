Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422999AbWCXEFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422999AbWCXEFv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 23:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbWCXEFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 23:05:51 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:6613 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751233AbWCXEFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 23:05:50 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: linux-kernel@vger.kernel.org
Subject: ACPI Compile error in current git (pci.h)
Date: Fri, 24 Mar 2006 14:04:03 +1000
User-Agent: KMail/1.9.1
Cc: linux-acpi@vger.kernel.org, Greg KH <gregkh@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1862015.krs2c7nWbr";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603241404.08109.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1862015.krs2c7nWbr
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

Current git produces the following compile error (x86_64 uniprocessor compi=
le):

arch/x86_64/pci/mmconfig.c:152: error: conflicting types for =E2=80=98pci_m=
mcfg_init=E2=80=99
arch/i386/pci/pci.h:85: error: previous declaration of =E2=80=98pci_mmcfg_i=
nit=E2=80=99 was here
make[1]: *** [arch/x86_64/pci/mmconfig.o] Error 1
make: *** [arch/x86_64/pci] Error 2

I haven't found out yet how the i386 file is getting included, but I
can say that git compiled fine last night.

Greg, I believe you're the pci guru, so I thought I'd try you too.
Apologies in advance if I've gotten it wrong.

Regards,

Nigel

--nextPart1862015.krs2c7nWbr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEI2+4N0y+n1M3mo0RAs9PAKCJv3OgCscy4erTjLxLvwZkJibrnQCfbR3Z
ncq1mzUM8OOg7W7n9p9ubEU=
=QITD
-----END PGP SIGNATURE-----

--nextPart1862015.krs2c7nWbr--
