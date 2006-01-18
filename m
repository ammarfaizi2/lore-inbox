Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030455AbWARU5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030455AbWARU5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWARU5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:57:45 -0500
Received: from host-87-74-62-169.bulldogdsl.com ([87.74.62.169]:54568 "EHLO
	host-87-74-62-169.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1030455AbWARU5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:57:44 -0500
Message-ID: <43CEABBD.2050604@unsolicited.net>
Date: Wed, 18 Jan 2006 20:57:33 +0000
From: David R <david@unsolicited.net>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <43CD4504.8020705@unsolicited.net> <20060118045930.GC7292@kroah.com>
In-Reply-To: <20060118045930.GC7292@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFA784210DDEF79A188202919"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA784210DDEF79A188202919
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Greg KH wrote:
>> dmesg etc looks ok. I'd appreciate it if anyone has any thoughts?
>=20
> Nothing has changed in usbfs that might cause this that I know of.  Can=

> you use git to bisect what patch caused it?
>=20
> thanks,
>=20
> greg k-h

And indeed nothing had changed. There was a runaway process using 100% of=
 the
CPU causing the symptoms. After gently bashing my boot scripts around
everything seems to work just fine. So, RC1 seems 100% on my setup.

Sorry for the noise.
David



--------------enigFA784210DDEF79A188202919
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDzqvFDYHcaCYtZo4RAhNIAJ9MFeJBEr3fVqy5dY3ppHbsNLfDUgCgspiA
UZSwsqdU8KO002+qY6yCAqQ=
=9Y/d
-----END PGP SIGNATURE-----

--------------enigFA784210DDEF79A188202919--
