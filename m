Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWJMXGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWJMXGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 19:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbWJMXGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 19:06:20 -0400
Received: from wavehammer.waldi.eu.org ([82.139.201.20]:5856 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1751999AbWJMXGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 19:06:19 -0400
Date: Sat, 14 Oct 2006 01:06:17 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.18 - check for chroot, broken root and cwd values in procfs
Message-ID: <20061013230617.GA15489@wavehammer.waldi.eu.org>
Mail-Followup-To: Bastian Blank <bastian@waldi.eu.org>,
	linux-kernel@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20061012140224.GA7632@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20061012140224.GA7632@wavehammer.waldi.eu.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 12, 2006 at 04:02:24PM +0200, Bastian Blank wrote:
> The commit 778c1144771f0064b6f51bee865cceb0d996f2f9 replaced the old
> root-based security checks in procfs with processed based ones.

The new behaviour even allows a user to escape from the chroot by using
chdir to /proc/$pid/cwd or /proc/$pid/root of a process he owns and
lives outside of the chroot.

Bastian

--=20
Punishment becomes ineffective after a certain point.  Men become insensiti=
ve.
		-- Eneg, "Patterns of Force", stardate 2534.7

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iEYEARECAAYFAkUwG+kACgkQnw66O/MvCNHQUwCfeHCIb/0NoGUZ0bv1pmWZ2LrH
yQMAoIfPLAS5HRyuRgq5FHav/EnH6YJW
=Kgly
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
