Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbULFTLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbULFTLR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 14:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbULFTLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 14:11:17 -0500
Received: from 213-0-210-244.dialup.nuria.telefonica-data.net ([213.0.210.244]:18315
	"EHLO dardhal.24x7linux.com") by vger.kernel.org with ESMTP
	id S261579AbULFTLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 14:11:07 -0500
Date: Mon, 6 Dec 2004 20:11:07 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ip contrack problem, not strictly followed RFC, DoS very much possible
Message-ID: <20041206191107.GA7192@localhost>
Mail-Followup-To: kernel list <linux-kernel@vger.kernel.org>
References: <41B464B3.8020807@pointblue.com.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <41B464B3.8020807@pointblue.com.pl>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Monday, 06 December 2004, at 14:54:59 +0100,
Grzegorz Piotr Jaskiewicz wrote:

> If someone has argumentation for 5 days timeout, please speak out. In=20
> everyday life, router, desktop, server usage 100s is enough there, and=20
> makes my life easier, as many other linux admins.
>=20
Maybe five days is a bit high, but there are definitely many (maybe badly
designed) applications that expect a TCP connection to remain open (and
traffic not dropped) for much longer than your proposed 100 seconds.

It is not unusual the need to tweak the settings for several commercial
firewalls I work with in several customers to raise the default timeouts
for TCP connection tracking, because some application breaks if the
connection gets put out of the firewalls' connection tables and the
traffic dropped.

Many times is just "my users are too lazy to double click the 'start
connection' icon again when they come from their breakfast, and want to be
able to enter commands on the remote host again". But at least, the
parameter is tunable in recent kernel versions, and not hardcoded in the
kernel sources like it was some time ago.

Greetings.

--=20
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.10-rc3)


--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBtK7Lao1/w/yPYI0RAl2mAJwPU5ZJzPS5lJSjczd0DFIRzCzmsACfQqOl
sxJ72f5uw9qUlGYWmpbXwrY=
=qC9W
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
