Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVCCKcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVCCKcd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:32:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVCCKcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:32:32 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:52147 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262414AbVCCK3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:29:04 -0500
Date: Thu, 3 Mar 2005 11:28:52 +0100
From: Martin Waitz <tali@admingilde.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Documentation update
Message-ID: <20050303102852.GG8617@admingilde.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sClP8c1IaQxyux9v"
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


--sClP8c1IaQxyux9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hoi :)

I'm still working on fixing and updating the Linux DocBook
Documentation.  My tree currently consists of several fixes
to the Documentation generation, some additional kernel-doc
entries and a move from SGML to valid XML.

Please have a look at it and consider merging.

Please do a

	bk pull bk://tali.bkbits.net/linux-doc

This will update the following files:

 Documentation/DocBook/Makefile                |   77 +--
 Documentation/DocBook/deviceiobook.tmpl       |    4=20
 Documentation/DocBook/gadget.tmpl             |    5=20
 Documentation/DocBook/journal-api.tmpl        |    5=20
 Documentation/DocBook/kernel-api.tmpl         |   14=20
 Documentation/DocBook/kernel-hacking.tmpl     |    4=20
 Documentation/DocBook/kernel-locking.tmpl     |  240 +++++------
 Documentation/DocBook/libata.tmpl             |    4=20
 Documentation/DocBook/librs.tmpl              |    6=20
 Documentation/DocBook/lsm.tmpl                |   11=20
 Documentation/DocBook/mcabook.tmpl            |    4=20
 Documentation/DocBook/mtdnand.tmpl            |   14=20
 Documentation/DocBook/procfs-guide.tmpl       |   27 -
 Documentation/DocBook/scsidrivers.tmpl        |    5=20
 Documentation/DocBook/sis900.tmpl             |  556 +++++++++++++--------=
-----
 Documentation/DocBook/tulip-user.tmpl         |    8=20
 Documentation/DocBook/usb.tmpl                |    5=20
 Documentation/DocBook/via-audio.tmpl          |    6=20
 Documentation/DocBook/videobook.tmpl          |  206 ++++-----
 Documentation/DocBook/wanbook.tmpl            |    4=20
 Documentation/DocBook/writing_usb_driver.tmpl |    4=20
 Documentation/DocBook/z8530book.tmpl          |    4=20
 drivers/block/ll_rw_blk.c                     |    3=20
 drivers/net/8390.c                            |    1=20
 drivers/usb/core/hcd.c                        |    2=20
 drivers/usb/core/hub.c                        |    2=20
 drivers/video/fbmem.c                         |   13=20
 fs/jbd/journal.c                              |   19=20
 fs/jbd/transaction.c                          |    3=20
 fs/super.c                                    |    2=20
 include/linux/jbd.h                           |    5=20
 include/linux/kernel.h                        |   12=20
 include/linux/kfifo.h                         |   12=20
 include/linux/skbuff.h                        |    2=20
 include/linux/wait.h                          |   60 ++
 kernel/kfifo.c                                |   10=20
 kernel/sysctl.c                               |    7=20
 net/core/skbuff.c                             |    5=20
 scripts/kernel-doc                            |   78 +--
 39 files changed, 802 insertions(+), 647 deletions(-)

through these ChangeSets:

<tali@admingilde.org> (05/03/03 1.2041)
   [DocBook] escape declaration_purpose
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/03/03 1.2040)
   [DocBook] factor out escaping of XML special characters
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/03/02 1.2039)
   [DocBook] add kfifo to kernel-api docs
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/03/02 1.2038)
   [DocBook] kernel-docify comments
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/02/09 1.2037)
   DocBook: fix XML in templates
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/02/08 1.2036)
   DocBook: s/sgml/xml/ in Documentation/DocBook/Makefile
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/02/08 1.2035)
   DocBook: move kernel-doc comment next to function
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/02/08 1.2034)
   DocBook: s/sgml/xml/ in scripts/kernel-doc
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

<tali@admingilde.org> (05/02/08 1.2033)
   DocBook: convert template files to XML
  =20
   Signed-off-by: Martin Waitz <tali@admingilde.org>

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

--sClP8c1IaQxyux9v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCJubkj/Eaxd/oD7IRAnnYAJ9s0efh/FX1gs3lmRgGPnCg6SWSkACeP49r
O9Tq5/jdUXBaTtw3awirLBE=
=gg6w
-----END PGP SIGNATURE-----

--sClP8c1IaQxyux9v--
