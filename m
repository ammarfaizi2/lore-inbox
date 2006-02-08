Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWBHXy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWBHXy0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 18:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422661AbWBHXy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 18:54:26 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:3549 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1422660AbWBHXyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 18:54:25 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: chroot in swsusp userland interface (was: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Thu, 9 Feb 2006 09:51:06 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Olivier Galibert <galibert@pobox.com>,
       linux-kernel@vger.kernel.org,
       Bernard Blackham <bernard@blackham.com.au>
References: <200602030918.07006.nigel@suspend2.net> <200602060902.50386.ncunningham@cyclades.com> <200602061613.40496.rjw@sisk.pl>
In-Reply-To: <200602061613.40496.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1991179.4ChpfO9Med";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602090951.11050.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1991179.4ChpfO9Med
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 07 February 2006 01:13, Rafael J. Wysocki wrote:
> > > I like the chroot idea too.
> >=20
> > You're making this too complicated. Just require that the userspace pro=
gram=20
> > does all it's file opening etc prior to telling kernelspace to do=20
> > anything. Then clearly document the requirement. If someone breaks the=
=20
> > rule, it is their problem, and their testing should show their=20
> > foolishness. We have done a similar thing in the Suspend2 userspace use=
r=20
> > interface code, and it works fine.
>=20
> Unfortunately I'd like to open at least one device file after freeze, for=
 a
> technical reason that probably does not exist in suspend2, so I need a
> temporary filesystem anyway.  Chrooting to it is just a cake.

Does the open need to be delayed until after the freeze?
=20
> [BTW, we have the list suspend-devel@lists.sourceforge.net we'd like
> to be a place for discussing the userspace suspend issues.  If you could
> subscribe to it, we'd be able to move the discussion there.]

Will do. Sorry for the slow reply - had a bogus mail filtering rule.

Nigel

--nextPart1991179.4ChpfO9Med
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6oPvN0y+n1M3mo0RAu6hAKDX5zAfSQWyNoDrUAl+sgwTi2ovxQCg361K
ud01HdYK4c41ltUbvUMrwao=
=zOZ0
-----END PGP SIGNATURE-----

--nextPart1991179.4ChpfO9Med--
