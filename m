Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWDZKqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWDZKqs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 06:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWDZKqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 06:46:48 -0400
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:39399 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932384AbWDZKqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 06:46:47 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][PATCH] swsusp: support creating bigger images
Date: Wed, 26 Apr 2006 13:41:27 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200604242355.08111.rjw@sisk.pl> <200604260021.08888.rjw@sisk.pl> <444ED9EB.5060205@yahoo.com.au>
In-Reply-To: <444ED9EB.5060205@yahoo.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3631143.1XjrAkghlY";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200604261341.32500.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3631143.1XjrAkghlY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Nick.

On Wednesday 26 April 2006 12:24, Nick Piggin wrote:
> Rafael J. Wysocki wrote:
> >This means if we freeze bdevs, we'll be able to save all of the LRU page=
s,
> >except for the pages mapped by the current task, without copying.  I thi=
nk
> > we can try to do this, but we'll need a patch to freeze bdevs for this
> > purpose. ;-)
>
> Why not the current task? Does it exit the kernel? Or go through some
> get_uesr_pages path?

I think Rafael is asleep at the mo, so I'll answer for him - he's wanting i=
t=20
to be compatible with using userspace to control what happens (uswsusp). In=
=20
that case, current will be the userspace program that's calling the ioctls =
to=20
get processes frozen etc.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart3631143.1XjrAkghlY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBETuvsN0y+n1M3mo0RAsApAKDD4OYZQ7Xi1CaGX0eGra2rPpcO8wCeJGtQ
pAi57ra6EUGfKWVuf6Z2i/g=
=LqDi
-----END PGP SIGNATURE-----

--nextPart3631143.1XjrAkghlY--
