Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTJSSdT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 14:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbTJSSdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 14:33:19 -0400
Received: from pool-162-84-134-188.ny5030.east.verizon.net ([162.84.134.188]:28665
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S262041AbTJSSdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 14:33:13 -0400
Subject: Linux-2.6.0-test8, e1000 timeouts.
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XHTjUdsa4+mM6bGNG9TV"
Message-Id: <1066588403.1232.57.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (Slackware Linux)
Date: Sun, 19 Oct 2003 14:33:23 -0400
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-beta; AVE: 6.22.0.1; VDF: 6.22.0.9; host: blazebox.homeip.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XHTjUdsa4+mM6bGNG9TV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello folks,

I keep getting timeouts before my Intel NIC is offered a lease from DHCP
server.

Kernel 2.4.22/2.4.23-pre7 and 2.6.0-test1-7/mm worked fine with the same
configuration/hardware.

The NIC is onboard Intel OEM chip on GIGABYTE 7NNXP Nforce2 board.

System is Slackware Linux 9.1
GCC 3.2.3
module-init-tools version 0.9.14
Linux blaze 2.6.0-test8 #1 Sat Oct 18 01:25:35 EDT 2003 i686 unknown
unknown GNU/Linux

Here's a snip from dmesg:

Intel(R) PRO/1000 Network Driver - version 5.2.20-k1
Copyright (c) 1999-2003 Intel Corporation.
eth0: Intel(R) PRO/1000 Network Connection
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex
NETDEV WATCHDOG: eth0: transmit timed out
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex

lsmod : e1000                  84032  0

I can provide more info upon request.

Paul B.



--=-XHTjUdsa4+mM6bGNG9TV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/ktjyo0/Ad0tTwzgRAg5hAKC6ICqz2sT5o317NtHuxfcvrRmqbgCfVfOt
JJNb2OwCPOzkQ9iRD2eElZU=
=bdag
-----END PGP SIGNATURE-----

--=-XHTjUdsa4+mM6bGNG9TV--
