Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262137AbUK3QFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262137AbUK3QFt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 11:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbUK3QFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 11:05:49 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:57818 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262137AbUK3QEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 11:04:47 -0500
Date: Tue, 30 Nov 2004 17:04:22 +0100
From: Martin Waitz <tali@admingilde.org>
To: Christian Mayrhuber <christian.mayrhuber@gmx.net>
Cc: reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
Message-ID: <20041130160422.GD19738@admingilde.org>
Mail-Followup-To: Christian Mayrhuber <christian.mayrhuber@gmx.net>,
	reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
	Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	linux-kernel@vger.kernel.org
References: <2c59f00304112205546349e88e@mail.gmail.com> <1101379820.2838.15.camel@grape.st-and.ac.uk> <41A773CD.6000802@namesys.com> <200411262213.58242.christian.mayrhuber@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZa61AII3s1sGKYx"
Content-Disposition: inline
In-Reply-To: <200411262213.58242.christian.mayrhuber@gmx.net>
User-Agent: Mutt/1.3.28i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZa61AII3s1sGKYx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Nov 26, 2004 at 10:13:57PM +0100, Christian Mayrhuber wrote:
> Regarding namespace unification + XPath:
> For files: cat /etc/passwd/[. =3D "joe"] should work like in XPath.
> But what to do with directories?
> Would 'cat /etc/[. =3D "passwd"]' output the contents of the passwd file
> or does it mean to output the file '[. =3D "passwd"]'?
> If the first is the case then you have to prohibit filenames looking=20
> like '[foo bar]'.

perhaps we should create a XML/XPath shell and a replacement for the
textutils package instead of implementing all these utilities inside the
kernel.

Then convert /etc/passwd to /etc/passwd.xml and all is well.

--=20
Martin Waitz

--YZa61AII3s1sGKYx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBrJoFj/Eaxd/oD7IRAs31AJ4ynSBuVumNBZQrPn13EECm3Vj41gCeO9kX
MsIXijRrPgphrX28LKWuuEE=
=mo4r
-----END PGP SIGNATURE-----

--YZa61AII3s1sGKYx--
