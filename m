Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263100AbUERMCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263100AbUERMCv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 08:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263104AbUERMCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 08:02:50 -0400
Received: from [151.38.86.74] ([151.38.86.74]:47629 "EHLO gateway.milesteg.arr")
	by vger.kernel.org with ESMTP id S263100AbUERMCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 08:02:48 -0400
Date: Tue, 18 May 2004 14:02:37 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Sis900 bug fixes 0/4
Message-ID: <20040518120237.GC23565@picchio.gall.it>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have prepared 4 patches that fix various issues with the sis900 driver
in Linux 2.6.6, two of them had some discussion on lkml. The entire
patchset has been tested by me, but patches 2 and 3 require testing from
the people who reported the bugs (they are CCed).

Patches 2,3,4 are incremental and need to be applied in that order.

Patch summary:
1. change of maintainership for the sis900 driver
2. Add new ISA bridge PCI ID
3. Fix PHY transceiver detection code to fall back to known PHY and not
   to the last detected.
4. Small cleanup and spelling fixes of sis900.h (much more needed, also
   in sis900.c, will go through trivial).

Any comment is highly appreciated.


--=20
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqftd2rmHZCWzV+0RAt/xAJ0RG+ZMFdeaTaR10XLReuep5FUYxgCfbhL/
8mdYTaTg2/pQeBhOCkmdupE=
=XL+6
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
