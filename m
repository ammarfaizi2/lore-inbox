Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265694AbUAPStj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265732AbUAPStj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:49:39 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:51841 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S265694AbUAPSth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:49:37 -0500
Date: Sat, 17 Jan 2004 07:54:52 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: Re: PATCH 1/2: Make gotoxy & siblings use unsigned variables
In-reply-to: <40083052.80703@tmr.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074279291.5328.1.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-GcSEWUtGBXJjTah+Bwda";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1c9S3-75-23@gated-at.bofh.it> <1cauN-131-17@gated-at.bofh.it>
 <1cb7n-1Z6-17@gated-at.bofh.it> <1cbAw-2BB-27@gated-at.bofh.it>
 <40083052.80703@tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GcSEWUtGBXJjTah+Bwda
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

Since we discussed this, I've produced a cut down patch and sent it to
my wide-console users. I can confirm that it is all that is needed. I'll
be posting a new patch for Andrew shortly.

Regards,

Nigel

On Sat, 2004-01-17 at 07:41, Bill Davidsen wrote:
> Andries Brouwer wrote:
> >>>Shouldn't we be using "size_t" for unsigned int
> >=20
> >=20
> >>You might be right. I was just being consistent with the other definiti=
ons.
> >=20
> >=20
> > These are character positions on a screen.
> > When did you last see a console in text mode with a line length
> > of more than 2^31 ?
> >=20
> > If you go for a minimal patch then you should replace "char"
> > in one or two places by "unsigned char" and that is all.
>=20
> Are these screen positions or offsets into the string for the line? The=20
> reason I ask is that with a 2-byte character set no char is going to do=20
> the latter reliably, not only do people run 132 col mode with vt100=20
> windows, just hitting the "full screen" button with most WM will give=20
> you >127 columns.
--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-GcSEWUtGBXJjTah+Bwda
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBACDN7VfpQGcyBBWkRAhH7AJ0dx1Pm2fTEEJTzt9dl/MvmPvJc3gCfTC+o
YxxmO7uVKtsouOlE2mv7cUE=
=lCBS
-----END PGP SIGNATURE-----

--=-GcSEWUtGBXJjTah+Bwda--

