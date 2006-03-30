Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWC3MAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWC3MAY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWC3MAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:00:24 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:58021 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932122AbWC3MAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:00:23 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend2-2.2.2 for 2.6.16.
Date: Thu, 30 Mar 2006 21:59:01 +1000
User-Agent: KMail/1.9.1
Cc: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
References: <200603281601.22521.ncunningham@cyclades.com> <200603301944.27188.ncunningham@cyclades.com> <20060330115519.GN8485@elf.ucw.cz>
In-Reply-To: <20060330115519.GN8485@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1176791.HMTUW8be4Z";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603302159.05751.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1176791.HMTUW8be4Z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 30 March 2006 21:55, Pavel Machek wrote:
> Hi!
>
> > > > > Please do try code at suspend.sf.net. It should be as fast and not
> > > > > needing big kernel patch.
> > > >
> > > > Don't bother suggesting that to x86_64 owners: compilation is
> > > > currently broken in vbetool/lrmi.c (at least).
> > >
> > > It seems to work at least for some users. I do not have x86-64 machine
> > > easily available, so someone else will have to fix that one.
> > >
> > > (Also it should be possible to compile suspend without s2ram support,
> > > avoiding the problem).
> >
> > I just found the line saying pciutils-devel is needed. Maybe that will
> > make the difference.
>
> I do not see missing includes, so I'm not sure it will help. Can you
> try adding
>
> ARCH=3Dx86_64
>
> to Makefile?

Heh. It worked. Maybe you should have something to figure out what arch the=
=20
user is using :) It seems a bit strange to tell the compiler that I'm using=
=20
the arch it ought to know I'm using.

Regards,

Nigel

--nextPart1176791.HMTUW8be4Z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEK8gJN0y+n1M3mo0RAuApAJ9IXrQkNIVa64AZmbTP0soALYLGegCgnRke
WGZfER7UfnZNWWSjwLWhDSo=
=7YKT
-----END PGP SIGNATURE-----

--nextPart1176791.HMTUW8be4Z--
