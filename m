Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbVFMPma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbVFMPma (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVFMPm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:42:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5288 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261595AbVFMPmQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:42:16 -0400
Message-ID: <42ADA880.60303@redhat.com>
Date: Mon, 13 Jun 2005 08:38:40 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Jakub Jelinek <jakub@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Add pselect, ppoll system calls.
References: <1118444314.4823.81.camel@localhost.localdomain>	 <1118616499.9949.103.camel@localhost.localdomain>	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>	 <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>	 <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>	 <42AD2640.5040601@redhat.com> <20050613091600.GA32364@outpost.ds9a.nl>	 <1118655702.2840.24.camel@localhost.localdomain>	 <20050613110556.GA26039@infradead.org>	 <20050613111422.GT22349@devserv.devel.redhat.com> <1118661848.2840.34.camel@localhost.localdomain>
In-Reply-To: <1118661848.2840.34.camel@localhost.localdomain>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig011BEEE883EE60F3FCE883AB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig011BEEE883EE60F3FCE883AB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

David Woodhouse wrote:

> Eep -- I hadn't noticed that difference. Will update patch accordingly.=
=20

And change it to expect a 64bit value I hope...


> The other documented difference (other than the signal mask bit) is tha=
t
> pselect() is documented not to modify the timeout parameter. I'm not
> sure whether I should preserve that difference, or not.

As long as there is a configuration where the timeout value is not
modified, it doesn't matter.  That is the case for select() using a
personality switch.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig011BEEE883EE60F3FCE883AB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFCraiA2ijCOnn/RHQRAvqRAJ9wEpZDpSNuHgtIvF5j3gl9khW+1ACfT317
oAmMTgF46kMnDn7EWnf03uY=
=lFj0
-----END PGP SIGNATURE-----

--------------enig011BEEE883EE60F3FCE883AB--
