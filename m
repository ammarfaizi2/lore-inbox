Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbUCFTrM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 14:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUCFTrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 14:47:12 -0500
Received: from av1-2-sn4.m-sp.skanova.net ([81.228.10.115]:28830 "EHLO
	av1-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261705AbUCFTrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 14:47:10 -0500
Subject: Strange DMA-errors and system hang with Promise 20268
From: Henrik Persson <nix@syndicalist.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ENzIV/c7AXJ40FsXhx7Y"
Message-Id: <1078602426.16591.8.camel@vega>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Mar 2004 20:47:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ENzIV/c7AXJ40FsXhx7Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

The last month or so I've experienced some strangeness with one of my
boxes. It is up and running without any problems and then suddently i
get this in the syslog:

Mar  6 20:29:42 eurisco kernel: hdf: dma_timer_expiry: dma status =3D=3D
0x61

(sometimes dma status has been 0x41)

And a few seconds later the system has frozen and I have to reset the
box to get it back up and running.

It isn't always the same hdX. If I remove the device that produces the
error another device, but it's allways a device on the promise
controller, fails.

I've seen this behaviour with 2.4.25, 2.4.24 and 2.4.23 (I think).

Any ideas?

--=20
Henrik Persson <nix@syndicalist.net>

--=-ENzIV/c7AXJ40FsXhx7Y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBASiq6vq1PUVOXJbARAkl3AKCJr6NpCMDIKSXfjwyNVMbkWttrfgCgwXsL
16RjnilxtIVWuSZGBxOLhjY=
=KJpb
-----END PGP SIGNATURE-----

--=-ENzIV/c7AXJ40FsXhx7Y--

