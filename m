Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422780AbWBICsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422780AbWBICsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 21:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422781AbWBICsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 21:48:55 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:60879 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1422780AbWBICsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 21:48:54 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Thu, 9 Feb 2006 12:45:30 +1000
User-Agent: KMail/1.9.1
Cc: suspend2-devel@lists.suspend2.net, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602082208.56599.nigel@suspend2.net> <20060209000617.GG2654@elf.ucw.cz>
In-Reply-To: <20060209000617.GG2654@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1228206.ktzq7FqK45";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602091245.34833.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1228206.ktzq7FqK45
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello.

On Thursday 09 February 2006 10:06, Pavel Machek wrote:
> > On Wednesday 08 February 2006 20:03, Rafael J. Wysocki wrote:
> > > Well, that's probably because I always do my best to be nice and foll=
ow=20
> > the
> > > rules that Pavel sets.  I post patches to modify the existing code an=
d=20
> > not to
> > > replace it top-down.  I keep them as compact as reasonably possible
> > > and focus on one thing at a time.  I remove the parts that Pavel and=
=20
> > other
> > > people don't like or I try to modify these parts to be more acceptabl=
e.
> > > Etc.  This is not _that_ difficult.
> >=20
> > Yeah. I guess those are the differences. Thanks for putting it so clear=
ly.
> > Well, we're obviously not getting anywhere while I'm trying to redesign=
 the
> > existing code, so I guess I'll just go back to finishing the git tree a=
nd
> > leave anyone who wants to use it to use it.
>=20
> At one point you said you'd like to work with us, and earlier in the
> threads you stated that porting suspend2 to userland should be easy.
>=20
> [I do not think that putting suspend2 into git is useful thing to
> do. Of course, it is your option; but it seems to me that people
> likely to use suspend2 are not the kind of people that use git.]
>=20
> It would be very helpful if you could install uswsusp, then try to
> make suspend2 run in userland on top of uswsusp interface. Not
> everything will be possible that way, but it most of features should
> be doable that way. I'd hate to code yet another splashscreen code,
> for example...

I've begun briefly to have a look at this.

Part of the problem I have, both with doing incremental patches for swsusp
and with doing a userspace version, is that some of the fundamentals are
redesigned in suspend2. The most important of these is that we store the
metadata in bitmaps (for pageflags) and extents (for storage) instead of
pbes. Do you have thoughts on how to overcome that issue? Are you
willing, for example, to do work on switching swsusp to use a different
method of storing its data?

Nigel
=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart1228206.ktzq7FqK45
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6qzON0y+n1M3mo0RAhtIAKDnDEvemNNjHv2OZI/tN8HtI0sSTwCg46TO
nr2y9YhzTT7oT6OlEFyAgeY=
=ybz9
-----END PGP SIGNATURE-----

--nextPart1228206.ktzq7FqK45--
