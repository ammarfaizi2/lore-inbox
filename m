Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265015AbTFLVel (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265004AbTFLVdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:33:11 -0400
Received: from grendel.firewall.com ([66.28.56.41]:27362 "EHLO
	grendel.firewall.com") by vger.kernel.org with ESMTP
	id S265006AbTFLVc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:32:59 -0400
Date: Thu, 12 Jun 2003 23:46:26 +0200
From: Marek Habersack <grendel@caudium.net>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.5.70-mm8 and the 3com NIC driver
Message-ID: <20030612214626.GA1770@thanes.org>
Reply-To: grendel@caudium.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
Organization: I just...
X-GPG-Fingerprint: 0F0B 21EE 7145 AA2A 3BF6  6D29 AB7F 74F4 621F E6EA
X-message-flag: Outlook - A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hello,

  As mentioned in the subject, the kernel doesn't work with a 3Com 3c905
card. Here's what's shown on the screen and in the logs on both startup and
in intervals during normal system run:

NETDEV WATCHDOG: eth0: transmit timed out
eth0: transmit timed out, tx_status 00 status e601.
diagnostics: net 0cc0 media 8802 dma 0000003b fifo 0000
eth0: Interrupt posted but not delivered -- IRQ blocked by another device?
Flags; bus-master 1, dirty 240(0) current 240(0)
Transmit list 00000000 vs. efce2200.
0: @efce2200  length 8000002a status 0000002a
1: @efce22a0  length 80000050 status 00000050
2: @efce2340  length 8000002a status 0000002a
3: @efce23e0  length 8000002a status 0000002a
4: @efce2480  length 8000002a status 0000002a
5: @efce2520  length 80000036 status 00000036
6: @efce25c0  length 80000036 status 00000036
7: @efce2660  length 80000036 status 00000036
8: @efce2700  length 80000050 status 00000050
9: @efce27a0  length 80000050 status 00000050
10: @efce2840  length 80000050 status 00000050
11: @efce28e0  length 80000050 status 00000050
12: @efce2980  length 80000050 status 00000050
13: @efce2a20  length 80000050 status 00000050
14: @efce2ac0  length 80000050 status 80000050
15: @efce2b60  length 80000050 status 80000050
eth0: Resetting the Tx ring pointer.

All the earlier -mm kernels worked fine in this regard,

marek

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+6PSyq3909GIf5uoRAo4RAJ940+AgFJ/u+QV6SDLlT75zbab32wCfZjtQ
RxOEMFVXuQZY97rQ/KSwNK8=
=PUuU
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
