Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVAZK45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVAZK45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 05:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVAZK45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 05:56:57 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:16051 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262269AbVAZK4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 05:56:41 -0500
Date: Wed, 26 Jan 2005 11:56:21 +0100
From: Martin Waitz <tali@admingilde.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation updates
Message-ID: <20050126105621.GW3069@admingilde.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cxfMsoqvp1jUizWj"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cxfMsoqvp1jUizWj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

I have created some updates to the Linux documentation.

This includes two important fixes that allow to generate DocBook
documenation from kernel-doc comments again and some low-priority
updates to the kernel-doc comments itself.

All patches are available in my BK repository, it only contains
documentation updates, no code changes.
(The fixes have been reported here before but have not been merged yet.)

Please do a

	bk pull bk://tali.bkbits.net/linux-doc

This will update the following files:

 Documentation/DocBook/kernel-api.tmpl |    1=20
 drivers/block/ll_rw_blk.c             |    3 +
 drivers/net/8390.c                    |    1=20
 drivers/usb/core/hcd.c                |    2 -
 drivers/usb/core/hub.c                |    2 -
 drivers/video/fbmem.c                 |    7 ++-
 fs/jbd/journal.c                      |   19 ++++++++--
 fs/jbd/transaction.c                  |    3 +
 fs/super.c                            |    2 -
 include/linux/jbd.h                   |    5 ++
 include/linux/kernel.h                |   12 ++++++
 include/linux/skbuff.h                |    2 +
 include/linux/wait.h                  |   60 +++++++++++++++++++++++++++++=
+++++
 kernel/sysctl.c                       |    7 +++
 net/core/skbuff.c                     |    5 ++
 scripts/kernel-doc                    |    4 +-
 16 files changed, 118 insertions(+), 17 deletions(-)

through these ChangeSets:

<tali@admingilde.org> (05/01/26 1.2032)
   DocBook: new kernel-doc comments for might_sleep & wait_event_*
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/01/26 1.2031)
   DocBook: fix function parameter descriptin in fbmem
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/01/26 1.2030)
   DocBook: update function parameter description in USB code
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/01/26 1.2029)
   DocBook: update function parameter description in block/fs code
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/01/26 1.2028)
   DocBook: update function parameter description in network code
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/01/26 1.2027)
   DocBook: allow preprocessor directives between kernel-doc and function
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/01/26 1.2026)
   DocBook: remove reference to drivers/net/net_init.c
  =20
   This file has been removed and is breaking documentation generation.
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>


--=20
Martin Waitz

--cxfMsoqvp1jUizWj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFB93dVj/Eaxd/oD7IRAgtyAJ46dR4Mt/nxPEX5QsCCgDNEhIIV2QCfXFBY
24NXrDJNtk0aZypPXldobho=
=WgPT
-----END PGP SIGNATURE-----

--cxfMsoqvp1jUizWj--
