Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266342AbUFUR7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266342AbUFUR7s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 13:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266355AbUFUR7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 13:59:47 -0400
Received: from cs.earlham.edu ([159.28.230.3]:22033 "EHLO quark.cs.earlham.edu")
	by vger.kernel.org with ESMTP id S266342AbUFUR7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 13:59:45 -0400
Date: Mon, 21 Jun 2004 12:59:42 -0500
From: Skylar Thompson <skylar@cs.earlham.edu>
To: Meelis Roos <mroos@linux.ee>
Cc: bikram.assal@wku.edu, linux-kernel@vger.kernel.org
Subject: Re: eepro100 NIC driver. any bug ?
Message-ID: <20040621175942.GB12853@quark.cs.earlham.edu>
Reply-To: Skylar Thompson <skylar@cs.earlham.edu>
References: <web-68980662@mailadmin.wku.edu> <E1Ba7hC-0001uK-Bl@rhn.tartu-labor>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <E1Ba7hC-0001uK-Bl@rhn.tartu-labor>
User-Agent: Mutt/1.4.2.1i
X-Accept-Primary-Language: en
X-Accept-Secondary-Language: es
SMTP-Mailing-Host: quark.cs.earlham.edu
X-Operating-System: FreeBSD 4.10-STABLE
X-Uptime: 12:48PM  up 3 days,  9:33, 16 users, load averages: 0.25, 0.28, 0.27
X-Editor: VIM - Vi IMproved 6.2 (2003 Jun 1, compiled May 19 2004 13:14:50)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 15, 2004 at 09:45:22AM +0300, Meelis Roos wrote:
> BA> Would you suggest ee100 over eepro100 driver for an INTEL NIC ?
> BA>=20
> BA> kernel: NETDEV WATCHDOG: eth1: transmit timed out
> BA> Jun 2 12:56:24 kernel: eth1: Transmit timed out: status f048 0c00 at =
1703794288/1703794348 command 200ca000.
>=20
> A co-worker had a very similar problem with eepro100 when I switched his
> computer from 100 Mbps fullduplex switch to 10Mbps halfduplex hub. The
> problems went away with e100 driver. It was with a revent kernel about a
> month ago but I don't remeber whether it was a recent 2.4 or a recent
> 2.6 kernel. The NIC in question is the onboard NIC of Intel D815EEA2
> mainboard.

I've also had trouble with the eepro100 driver. I help maintain a 16-node
HPC cluster of VA Linux 2200 2x2 with on-board Intel EtherExpress Pro 100
NICs. During times of high network traffic, the eepro100 driver would just
cause the card to lose its carrier. Switching to the e100 driver solved
this problem.

--=20
-- Skylar Thompson (skylar@cs.earlham.edu)
-- http://www.cs.earlham.edu/~skylar/

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (FreeBSD)

iD8DBQFA1yIOsc4yyULgN4YRApU0AKCs0yG+4nugEn8nCQSPTf2UnFzZzwCgspwT
pZRoYuZachRttBaxHUjuWWs=
=+Uko
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
