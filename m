Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUELE7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUELE7h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 00:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264972AbUELE7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 00:59:37 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:28291 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264971AbUELE7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 00:59:33 -0400
Subject: Re: [PATCH] [RFC] adding support for .patches and /proc/patches.gz
From: Jon Oberheide <jon@focalhost.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk,
       Paul Eggert <eggert@CS.UCLA.EDU>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, bug-patch@gnu.org, bug-gnu-utils@gnu.org
In-Reply-To: <c7r676$gvo$1@gatekeeper.tmr.com>
References: <1084157289.7867.0.camel@latitude>
	 <c7r676$gvo$1@gatekeeper.tmr.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8XS7WnNMfU+cbx+LqOAs"
Message-Id: <1084337968.31228.35.camel@latitude>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 12 May 2004 00:59:28 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8XS7WnNMfU+cbx+LqOAs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-05-11 at 14:37, Bill Davidsen wrote:
> Jon Oberheide wrote:
> > Greetings,
> >=20
> > This feature has been brought up several times before, as can be seen
> > here:
> > http://www.ussg.iu.edu/hypermail/linux/kernel/0404.3/0798.html
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/0203.1/0598.html
> > http://www.uwsg.iu.edu/hypermail/linux/kernel/9803.0/0223.html
> >=20
> > For those unfamiliar, a file linux/.patches would be adding to the
> > source tree.  When applying patches to the source tree, descriptive
> > information would be written to .patches.  After compilation and runnin=
g
> > of this kernel, the .patches information would be accessible through
> > /proc/patches.gz; similar to the /proc/config.gz feature.
>=20
> The first question would be, patches between the current kernel and=20
> what? Vendor kernel, people may not have it. Kernel.org kernal, just the=20
> patches to a current vendor kernel diff would be pretty huge in some case=
s.

Any patches applied against the current vanilla kernel.org kernel would
be listed in .patches.  This would include vendor, third-party, and even
pre/bk/mm patches. =20

Keep in mind, .patches would not contain the entire patch, as that would
be WAY to large, but just a short entry such as the name, date last
modified, and date applied of the patch file.

> Let's say it looks like a high cost/benefit ratio, would be much less=20
> effective unless it were used for every patch, and feels like something=20
> you might want to do within an organization rather than as a general=20
> practice.

Exactly as I stated, adoption would be the hardest part.  Paul's idea of
adding an option to patch w/o breaking POSIX sounds like a way to go.=20
Of course that would require widespread documentation updates and
contacting vendors but would be very possible.

> Sorry, you asked for comments...

No need to be sorry, thanks!  :)

Regards,
Jon Oberheide
jon@focalhost.com

--=-8XS7WnNMfU+cbx+LqOAs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAoa8vxmFkpQzxUm0RAmfQAJ4lg2F2Q3rNnhIsb+PI1XKePHUykQCggPfq
y+bMmCaqwIzC1URdA888Rqw=
=1eqT
-----END PGP SIGNATURE-----

--=-8XS7WnNMfU+cbx+LqOAs--

