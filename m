Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262712AbVGMTuQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262712AbVGMTuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbVGMTsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:48:52 -0400
Received: from [84.77.111.123] ([84.77.111.123]:22967 "EHLO
	dardhal.24x7linux.com") by vger.kernel.org with ESMTP
	id S262711AbVGMTpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:45:42 -0400
Date: Wed, 13 Jul 2005 21:45:40 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>,
       acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux v2.6.13-rc3
Message-ID: <20050713194540.GC29529@localhost>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>,
	acpi-devel@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.58.0507122157070.17536@g5.osdl.org> <200507131259.04855.rjw@sisk.pl> <Pine.LNX.4.58.0507131145310.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507131145310.17536@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday, 13 July 2005, at 11:53:08 -0700,
Linus Torvalds wrote:

> Len, ACPI people - can we fix this regression, please?
>=20
> Rafael even pinpoints exactly which patches are causing the problem, so=
=20
> why didn't they get reverted before sending them off to me?
>=20
> Grumble. I don't like being sent known-bad patches when we're trying to=
=20
> calm things down.
>=20
Also related to ACPI, a patch went in recently that prevents some boxes (at
least mine) to power off properly via ACPI. The patch is:
http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdif
f;h=3Dcee5dab4856f51c5cad3aecc630ad0a4d2217a85

As the commit log says, this was somewhat expected. I sent a message a
couple of days ago both to the list and to Eric W. Biederman, with no
response so far. Message Subject: is:
[2.6.12-git8] ACPI shutdown fails to power off machine
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D112094139204799&w=3D2

Greetings,

--=20
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.13-rc2)


--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC1W9kao1/w/yPYI0RAjzUAJoC1fqYNqjEa9DzjjdyvELkDdUWQgCgg/MH
9awrCGEqA4SqGfkH9fXBQXc=
=r8FG
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
