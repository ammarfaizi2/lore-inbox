Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbULJSSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbULJSSf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 13:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbULJSSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 13:18:34 -0500
Received: from got80-74-137-2.ch-meta.net ([80.74.137.2]:47582 "EHLO
	gothicus.metanet.ch") by vger.kernel.org with ESMTP id S261784AbULJSS0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 13:18:26 -0500
From: Thomas Bettler <bettlert@student.ethz.ch>
To: linux-kernel@vger.kernel.org, linux-laptop@vger.kernel.org
Subject: module uhci-hcd and pm
Date: Fri, 10 Dec 2004 19:18:14 +0100
User-Agent: KMail/1.7.2
References: <200412091447.11996.bettlert@student.ethz.ch>
In-Reply-To: <200412091447.11996.bettlert@student.ethz.ch>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1216614.ZKd03Oksu9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200412101918.24191.bettlert@student.ethz.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1216614.ZKd03Oksu9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello you all

The uhci-hcd module causes the cpu to work at highest frequecy
(according to x86info -mhz). If I unload it, cpu frequency dropps from full
(1.8GHz) to ~2/3 (1.1GHz). In both cases top shows 97% or even 99% idle.
modprobing it again speeds the cpu up again.

So module uhci-hcd prehibits the cpu clock from saving power on notebooks. =
(At=20
least theese with P4-M cpus)

What code forces the cpu to run at high speed? Can I tweak the module to=20
permit slower cpu speed?

Thomas Bettler

--nextPart1216614.ZKd03Oksu9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBuehvePDD0plw9EYRAiNLAJ9oUnPfEkAfDRwkjZuUj3UPZq+JKQCgxyJk
Jbv6WGlItHQpxSz9fs9+IT8=
=0I7S
-----END PGP SIGNATURE-----

--nextPart1216614.ZKd03Oksu9--
