Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWBVWyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWBVWyP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWBVWyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:54:15 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:50112 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932310AbWBVWyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:54:14 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Hesse, Christian" <mail@earthworm.de>
Subject: Re: hald in status D with 2.6.16-rc4
Date: Thu, 23 Feb 2006 08:51:14 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <200602202034.29413.mail@earthworm.de> <200602222109.21816.ncunningham@cyclades.com> <200602222336.31562.mail@earthworm.de>
In-Reply-To: <200602222336.31562.mail@earthworm.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1281268.1ObUN3SWa0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602230851.18377.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1281268.1ObUN3SWa0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi.

On Thursday 23 February 2006 08:36, Hesse, Christian wrote:
> On Wednesday 22 February 2006 12:09, Nigel Cunningham wrote:
> > On Wednesday 22 February 2006 20:10, Hesse, Christian wrote:
> > > On Tuesday 21 February 2006 23:49, Andrew Morton wrote:
> > > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > > On Tuesday 21 February 2006 06:19, Andrew Morton wrote:
> > > > > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > > > > Hello everybody,
> > > > > > >
> > > > > > > since using kernel version 2.6.16-rc4 the hal daemon is in
> > > > > > > status D after resume. I use suspend2 2.2.0.1 for 2.6.16-rc3.
> > > > > > > Any hints what could be the problem? It worked perfectly with
> > > > > > > 2.6.15.x and suspend2 2.2.
> > > > > >
> > > > > > a) Look in the logs for any oopses, other nasties
> > > > >
> > > > > Nothing.
> > > > >
> > > > > > b) Do `echo t > /proc/sysrq-trigger', `dmesg -s 1000000 > foo'
> > > > > > then find the trace for `hald' in `foo', send it to this list.
> > > > >
> > > > > Ok, here it is:
> > > > >
> > > > > [ trace snipped ]
> > > > >
> > > > > This is with 2.6.16-rc4-git1 + suspend2 2.2.0.1.
> > > >
> > > > Hopefully suspend2 isn't involved.  People would feel more
> > > > comfortable if you could test a vanilla mainline tree..
> > > >
> > > > Could the ACPI team please take a look at fixing this regression?
> > >
> > > I did two cycles with mainline suspend now and did not hit the
> > > problem... I will keep an eye on it.
> >
> > Could you let me know how you go? I didn't make any changes between 2.2
> > and 2.2.0.1 that I think could cause this, but if you can't reproduce it
> > otherwise, I'll happily look again.
>
> You just missed my last mail. It happens with mainline suspend as well, so
> it is not your fault.

Ok. Thanks! :)

Nigel

--nextPart1281268.1ObUN3SWa0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/OrmN0y+n1M3mo0RAovRAJwNIUFc1NTgU6rPXnG0IjZWbiFYkgCfS3x5
CrypdpFk2fiQvq6k3DK9e3I=
=WAHq
-----END PGP SIGNATURE-----

--nextPart1281268.1ObUN3SWa0--
