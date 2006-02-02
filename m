Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWBBLfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWBBLfZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWBBLfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:35:25 -0500
Received: from 60-240-149-171.tpgi.com.au ([60.240.149.171]:32384 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750800AbWBBLfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:35:24 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [ 00/10] [Suspend2] Modules support.
Date: Thu, 2 Feb 2006 21:31:55 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022038.16262.nigel@suspend2.net> <20060202104750.GC1884@elf.ucw.cz>
In-Reply-To: <20060202104750.GC1884@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2090073.C9mklPSHvX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602022131.59928.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2090073.C9mklPSHvX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 02 February 2006 20:47, Pavel Machek wrote:
> Hi!
>
> > > > This set of patches represents the core of Suspend2's module suppor=
t.
> > > >
> > > > Suspend2 uses a strong internal API to separate the method of
> > > > determining the content of the image from the method by which it is
> > > > saved. The code for determining the content is part of the core of
> > > > Suspend2, and transformations (compression and/or encryption) and
> > > > storage of the pages are handled by 'modules'.
> > >
> > > swsusp already has a very strong API to separate image writing from
> > > image creation (in -mm patch, anyway). It is also very nice, just
> > > read() from /dev/snapshot. Please use it.
> >
> > You know that's not an option.
>
> No, I don't... please explain. Switching to this interface is going to
> be easier than pushing suspend2 into kernel. Granted, end result may
> not be suspend2, it may be something like suspend3, but it will be
> better result than u-swsusp or suspend2 is today...

It's not an option because I'm not trying not to step all over your codebas=
e,=20
because I'm not moving suspend2 to userspace and because it doesn't make=20
sense to add another layer of abstraction by sticking /dev/snapshot in the=
=20
middle of kernel space code. There may be more reasons, but I haven't looke=
d=20
at the /dev/snapshot code at all.

Regards,

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart2090073.C9mklPSHvX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4e2vN0y+n1M3mo0RAkIHAJ4po16606VqjB8XHCOCP6gNN+fFPwCgwxgs
SBF9tqnUaGk17uJP067HvHg=
=Dw3V
-----END PGP SIGNATURE-----

--nextPart2090073.C9mklPSHvX--
