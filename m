Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUG0Jtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUG0Jtk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 05:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262138AbUG0Jtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 05:49:40 -0400
Received: from krezus.e-wro.net ([82.143.159.250]:11479 "EHLO krezus.e-wro.net")
	by vger.kernel.org with ESMTP id S262356AbUG0JrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 05:47:10 -0400
Date: Tue, 27 Jul 2004 11:47:02 +0200
From: Tomasz Paszkowski <tomasz.paszkowski@e-wro.pl>
To: linux-kernel@vger.kernel.org
Subject: hfsc and huge set of rules
Message-ID: <20040727094702.GA14723@krezus.e-wro.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-NCC-RegID: pl.e-wro
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'am running hfsc qdisc with huge set of rules loaded.

root@hades:/home/system/scr/etc/hfsc_rebuild# cat tc.batch | grep hfsc | wc=
 -l
  27884


Always when I delete the root qdisc (qdisc del dev eth0 root)
the machine stop responding for about 5-6 seconds. As I think it's due the
hfsc_destory_qdisc is executed in main kernel thread. Similar problem is
present also in htb scheduler.

Is there any quick solution to solve this problem ?

--=20
Tomasz Paszkowski
Administrator
Miejskie Sieci Informatyczne e-wro
http://www.e-wro.pl

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBBiSWcNXOL98XeysRAiQ5AJwKm3MWHNHlUKDirvBE/M/seSyzJgCfeUCJ
cYGI4/qpJFYpAMA0TA1rlxg=
=Ac+w
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
