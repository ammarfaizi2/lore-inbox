Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262711AbVG2S41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbVG2S41 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 14:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbVG2S40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 14:56:26 -0400
Received: from [84.77.83.123] ([84.77.83.123]:59095 "EHLO
	dardhal.24x7linux.com") by vger.kernel.org with ESMTP
	id S262714AbVG2SzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 14:55:07 -0400
Date: Fri, 29 Jul 2005 20:55:06 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Kevin Radloff <radsaq@gmail.com>, linux-kernel@vger.kernel.org
Cc: ndrew Morton <akpm@osdl.org>
Subject: Re: Followup on 2.6.13-rc3 ACPI processor C-state regression
Message-ID: <20050729185506.GA4736@localhost>
Mail-Followup-To: Kevin Radloff <radsaq@gmail.com>,
	linux-kernel@vger.kernel.org, ndrew Morton <akpm@osdl.org>
References: <3b0ffc1f050713150527c7c649@mail.gmail.com> <20050729183318.GA27093@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20050729183318.GA27093@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday, 29 July 2005, at 20:33:18 +0200,
Jose Luis Domingo Lopez wrote:

> I was just about to gather data to report the exact same problem in my
> box, a no-brand non-mobile PC (AMD Athlon XP 1700+). Kernel version
> 2.6.13-rc2 and before correctly detected both C1 and C2 processor states,
> so when the system is idle some energy and heat is preserved. Now, with
> 2.6.13-rc3-git8 only C1 gets detected, so no power save.
>=20
> I am going to try the patch Andrew suggest in this same thread right now,
> and will report back is this fixes the issue.
>=20
Just rebooted with a 2.6.13-rc3-git8 kernel patched with the patch Andrew
showed in his last email in this thread, and now processor C2 power state
is recognized and operational again, giving in my setup a 12=BAC decrease in
processor temperature while idle.

Greetings,

--=20
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.13-rc3-git8)


--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC6nuKao1/w/yPYI0RApjTAKCJFDgsZhKfv1sN6JN08Bzv6IGZSQCgnVR+
IpH+lHgEaQTCrTMLwwxd3vA=
=Hbkj
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
