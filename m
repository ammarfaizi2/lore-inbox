Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbULERyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbULERyg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 12:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbULERyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 12:54:33 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:42954 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261320AbULERyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 12:54:00 -0500
Date: Sun, 5 Dec 2004 18:54:00 +0100
From: lkml@Think-Future.de
To: Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Subject: Promise module (old) broken
Reply-To: lkml@Think-Future.de
Mail-Followup-To: lkml@Think-Future.de,
	Linux Kernel-Liste <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Url: http://www.Think-Future.de
X-Editor: Vi it! http://www.vim.org
X-Bkp: p2mi
X-GnuPG-Key: gpg --keyserver search.keyserver.net --recv-keys 06232116
Message-Id: <20041205195358.DC2B5440E2@service.i-think-future.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:35131867b06e6a502cee335cb348919d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Hi,

  up to the actual kernel rc 2.6.10rc3 has broken pdc 20265 support. As
some kernel releases ago, one had to specify i/o ports on kernel
cmdline. 2.4.28 kernel works w/o cmdline parameter.

Is this behaviour intended? Will it be fixed in 2.6.10 release?

W/o parameter kernel (2.6) does not recognise the pdc ide controller
drives.
dmesg output states: "ideX: Wait for ready failed before probe !"


As of kernel rc 2.6.10rc1 the kernel even reported ide drive short
read and seek errors on drives even not connected to the pdc
controller but connected to the onboard controller (->/dev/hda1). In
fact /dev/hda1 has no errors (so far).

Any comments?

  Thanks.

    Nils


--=20

*     lkml@                 * University of Stuttgart *    icq / lc   *
*      www.Think-Future.de  *    dep.comp.science     * 9336272/92045 *
:x                                                                   :)

   All power corrupts, but we need electricity.=20
  =20
  =20

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Nils Radtke

iD8DBQFBs0s4X3r3ggYjIRYRAjPHAJ4h7MajCZ8w2ki74YITT14I9HWqjACfYeqn
aXmJ53Ph5F+qyigSk6JVEUA=
=iYwQ
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--
