Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265695AbUFSNFf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbUFSNFf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 09:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265691AbUFSNFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 09:05:35 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:56791 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S265695AbUFSNFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 09:05:22 -0400
Subject: [sundance] Known problems?
From: Ian Kumlien <pomac@vapor.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-GS41UxtFSfS1CnAKDM7V"
Message-Id: <1087650302.2971.44.camel@big>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 19 Jun 2004 15:05:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GS41UxtFSfS1CnAKDM7V
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I changed my networking card back to my dlink DFE-580tx (one of those 4
port 100mbit cards that uses the alta chipset). And now the watchdog
keep killing the connection.

The max bw that is being used is aprox 5.5 megabyte/s (to avoid
confusion). Has there been any work done with this recently or during
2.5/6 development? Afair i had no problems with it in 2.4.x when my
firewall used it.

CC, I'm not subscribed.

Here is some info, i assume you need more...

On the server side:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: Transmit timed out, TxStatus 00 TxFrameId 18, resetting...
00 2fcbe000 2fcbe010 00008001(00) 1d883002 800005ea
01 2fcbe010 2fcbe020 00008005(01) 180fb802 800005ea
02 2fcbe020 2fcbe030 00008009(02) 08630802 800005ea
03 2fcbe030 2fcbe040 0000800d(03) 2a4e7002 800005ea
04 2fcbe040 2fcbe050 00008011(04) 1897b002 800005ea
05 2fcbe050 2fcbe060 00008015(05) 2c51b002 800005ea
06 2fcbe060 2fcbe070 00008019(06) 0be05802 800005ea
07 2fcbe070 2fcbe080 0000801d(07) 0e7d2002 800005ea
08 2fcbe080 2fcbe090 00008021(08) 0e7d2802 800005ea
09 2fcbe090 2fcbe0a0 00008025(09) 2b02e402 8000017a
0a 2fcbe0a0 2fcbe0b0 00008029(0a) 25120802 800005ea
0b 2fcbe0b0 2fcbe0c0 0000802d(0b) 19ac5802 800005ea
0c 2fcbe0c0 2fcbe0d0 00008031(0c) 19ac5002 800005ea
0d 2fcbe0d0 2fcbe0e0 00008035(0d) 2bf58802 800005ea
0e 2fcbe0e0 2fcbe0f0 00008039(0e) 2bf58002 800005ea
0f 2fcbe0f0 2fcbe100 0000803d(0f) 145b6802 800005ea
10 2fcbe100 2fcbe110 00008041(10) 145b6002 800005ea
11 2fcbe110 2fcbe120 00008045(11) 152db802 800005ea
12 2fcbe120 2fcbe130 00008049(12) 152db002 800005ea
13 2fcbe130 2fcbe140 0000804d(13) 2d0de802 800005ea
14 2fcbe140 2fcbe150 00008051(14) 2d0de002 800005ea
15 2fcbe150 2fcbe160 00008055(15) 2c5d3802 800005ea
16 2fcbe160 00000000 00008059(16) 2c5d3002 800005ea
17 2fcbe170 2fcbe180 0001805d(17) 00000000 00000000
18 2fcbe180 2fcbe190 00018061(18) 00000000 00000000
19 2fcbe190 2fcbe1a0 00008065(19) 2d4d2802 800005ea
1a 2fcbe1a0 2fcbe1b0 00008069(1a) 17b26002 800005ea
1b 2fcbe1b0 2fcbe1c0 0000806d(1b) 2df94802 800005ea
1c 2fcbe1c0 2fcbe1d0 00008071(1c) 2bd26802 800005ea
1d 2fcbe1d0 2fcbe1e0 00008075(1d) 2bd26002 800005ea
1e 2fcbe1e0 2fcbe1f0 00008079(1e) 2d5c0802 800005ea
1f 2fcbe1f0 2fcbe000 0000807d(1f) 2d759802 800005ea
TxListPtr=3D2fcbe180 netif_queue_stopped=3D1
cur_tx=3D28023(17) dirty_tx=3D27993(19)
cur_rx=3D40 dirty_rx=3D40
cur_task=3D28023

On the client side:
nfs: server blue not responding, still trying

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-GS41UxtFSfS1CnAKDM7V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA1Dn+7F3Euyc51N8RAvfpAJ0T1sK00e4nl+E4VjhnwiW8F4YMAwCcDr0p
09313IjMHpypVVJdRtvkm5M=
=bFLw
-----END PGP SIGNATURE-----

--=-GS41UxtFSfS1CnAKDM7V--

