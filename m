Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVFMPjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVFMPjI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVFMPjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:39:08 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8870 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261593AbVFMPjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:39:02 -0400
Message-ID: <42ADA7B6.2060203@redhat.com>
Date: Mon, 13 Jun 2005 08:35:18 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: David Woodhouse <dwmw2@infradead.org>,
       bert hubert <bert.hubert@netherlabs.nl>,
       Linus Torvalds <torvalds@osdl.org>, jnf <jnf@innocence-lost.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Add pselect, ppoll system calls.
References: <1118444314.4823.81.camel@localhost.localdomain> <1118616499.9949.103.camel@localhost.localdomain> <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org> <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg> <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org> <42AD2640.5040601@redhat.com> <20050613091600.GA32364@outpost.ds9a.nl> <1118655702.2840.24.camel@localhost.localdomain> <20050613110556.GA26039@infradead.org>
In-Reply-To: <20050613110556.GA26039@infradead.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7580CC32E7B6F80B6186E382"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7580CC32E7B6F80B6186E382
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig wrote:
> Yes, it kinda makes sense.  Question to Uli: would you put ppoll() into=

> glibc as GNU extension?

Of course.  I would rather not add pselect() and deprecate select() than
not adding ppoll().  In fact, we just discussed a similar issue in the
POSIX base working group.  Due to the limitations select() might indeed
get the axe in a future revision.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig7580CC32E7B6F80B6186E382
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFCrae22ijCOnn/RHQRAi1rAJ9Ywu7huFprPp4y5RQp/vKEOEPDdgCgiV0e
sxS7HzQEop3NjyNFAFyn1IQ=
=VXJ/
-----END PGP SIGNATURE-----

--------------enig7580CC32E7B6F80B6186E382--
