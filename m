Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbTDNRVr (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTDNRVq (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:21:46 -0400
Received: from NeverAgain.DE ([217.69.76.1]:47268 "EHLO hobbit.neveragain.de")
	by vger.kernel.org with ESMTP id S263576AbTDNRVo (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 13:21:44 -0400
Date: Mon, 14 Apr 2003 19:32:26 +0200
From: Martin Loschwitz <madkiss@madkiss.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IDE Problems with Asus P4PE
Message-ID: <20030414173226.GA729@minerva.local.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello all,

I am having IDE problems with my Asus P4PE. Reportedly, an Intel i845PE
chipset is working (or even not;) on this mainboard. However, from time
to time, the following appears in dmesg:

Apr 14 11:06:13 minerva kernel: hda: dma_timer_expiry: dma status =3D=3D 0x=
20
Apr 14 11:06:13 minerva kernel: hda: timeout waiting for DMA
Apr 14 11:06:13 minerva kernel: hda: timeout waiting for DMA
Apr 14 11:06:13 minerva kernel: hda: (__ide_dma_test_irq) called while not =
waiting
Apr 14 11:06:13 minerva kernel: hda: status timeout: status=3D0xd0 { Busy }
Apr 14 11:06:13 minerva kernel:=20
Apr 14 11:06:13 minerva kernel: hda: drive not ready for command
Apr 14 11:06:13 minerva kernel: ide0: reset: success

Somebody knows what this is caused by? And maybe somebody has a patch to
fix this behaviour?

--=20
  .''`.   Martin Loschwitz           Debian GNU/Linux developer
 : :'  :  madkiss@madkiss.org        madkiss@debian.org
 `. `'`   http://www.madkiss.org/    people.debian.org/~madkiss/
   `-     Use Debian GNU/Linux 3.0!  See http://www.debian.org/

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+mvCqHPo+jNcUXjARAr5WAJ9nVbi1ieP8SxiJMBATpl5z3WhKfgCeL7FN
XGYo7MCZvj8gv/MrCj6GmOw=
=nZbd
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
