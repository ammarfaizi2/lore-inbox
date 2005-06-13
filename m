Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVFMQfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVFMQfR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 12:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVFMQfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 12:35:17 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19913 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261671AbVFMQfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 12:35:07 -0400
Message-ID: <42ADB4E4.2010504@redhat.com>
Date: Mon, 13 Jun 2005 09:31:32 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Jakub Jelinek <jakub@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: Add pselect, ppoll system calls.
References: <1118444314.4823.81.camel@localhost.localdomain>	 <1118616499.9949.103.camel@localhost.localdomain>	 <Pine.LNX.4.58.0506121725250.2286@ppc970.osdl.org>	 <Pine.LNX.4.62.0506121815070.24789@fhozvffvba.vaabprapr-ybfg.arg>	 <Pine.LNX.4.58.0506122018230.2286@ppc970.osdl.org>	 <42AD2640.5040601@redhat.com> <20050613091600.GA32364@outpost.ds9a.nl>	 <1118655702.2840.24.camel@localhost.localdomain>	 <20050613110556.GA26039@infradead.org>	 <20050613111422.GT22349@devserv.devel.redhat.com>	 <1118661848.2840.34.camel@localhost.localdomain>	 <42ADA880.60303@redhat.com>	 <1118678548.25956.200.camel@hades.cambridge.redhat.com>	 <42ADAFE5.5050206@redhat.com> <1118680177.25956.213.camel@hades.cambridge.redhat.com>
In-Reply-To: <1118680177.25956.213.camel@hades.cambridge.redhat.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2A6CA12B629D9BB85D7C015F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2A6CA12B629D9BB85D7C015F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

David Woodhouse wrote:
> Yes, we should make the time for ppoll() a 64-bit value, so you can
> request a time period longer than 24 days. Shall we also switch to
> microseconds?

I don't see the need for higher precision in this API and a change is
confusing.  There is nanosleep() for people who only want a delay and
that can be done with high precision.

--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig2A6CA12B629D9BB85D7C015F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFCrbTk2ijCOnn/RHQRAu/VAKCoRgqfqLFk2FhQCcxwxOQanCY3DQCfTJM9
Wf4w43OhF8gBqZqAz5i79yY=
=idQw
-----END PGP SIGNATURE-----

--------------enig2A6CA12B629D9BB85D7C015F--
