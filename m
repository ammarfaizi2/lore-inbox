Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWBVWKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWBVWKA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWBVWKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:10:00 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:63901 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751448AbWBVWJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:09:58 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "Hesse, Christian" <mail@earthworm.de>
Subject: Re: hald in status D with 2.6.16-rc4
Date: Wed, 22 Feb 2006 21:09:16 +1000
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
References: <200602202034.29413.mail@earthworm.de> <20060221144907.1ac11799.akpm@osdl.org> <200602221110.44813.mail@earthworm.de>
In-Reply-To: <200602221110.44813.mail@earthworm.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3178343.cvBiZZPuXe";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602222109.21816.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3178343.cvBiZZPuXe
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Wednesday 22 February 2006 20:10, Hesse, Christian wrote:
> On Tuesday 21 February 2006 23:49, Andrew Morton wrote:
> > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > On Tuesday 21 February 2006 06:19, Andrew Morton wrote:
> > > > "Hesse, Christian" <mail@earthworm.de> wrote:
> > > > > Hello everybody,
> > > > >
> > > > > since using kernel version 2.6.16-rc4 the hal daemon is in status=
 D
> > > > > after resume. I use suspend2 2.2.0.1 for 2.6.16-rc3. Any hints wh=
at
> > > > > could be the problem? It worked perfectly with 2.6.15.x and
> > > > > suspend2 2.2.
> > > >
> > > > a) Look in the logs for any oopses, other nasties
> > >
> > > Nothing.
> > >
> > > > b) Do `echo t > /proc/sysrq-trigger', `dmesg -s 1000000 > foo' then
> > > > find the trace for `hald' in `foo', send it to this list.
> > >
> > > Ok, here it is:
> > >
> > > [ trace snipped ]
> > >
> > > This is with 2.6.16-rc4-git1 + suspend2 2.2.0.1.
> >
> > Hopefully suspend2 isn't involved.  People would feel more comfortable =
if
> > you could test a vanilla mainline tree..
> >
> > Could the ACPI team please take a look at fixing this regression?
>
> I did two cycles with mainline suspend now and did not hit the problem...=
 I
> will keep an eye on it.

Could you let me know how you go? I didn't make any changes between 2.2 and=
=20
2.2.0.1 that I think could cause this, but if you can't reproduce it=20
otherwise, I'll happily look again.

Regards,

Nigel

--nextPart3178343.cvBiZZPuXe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/EZhN0y+n1M3mo0RAm5HAKDgGohA6w31t86TZCiveVQyc2+NJgCgzrXb
bwVm9bb9ojNArJDGIJJ/LXY=
=UIXM
-----END PGP SIGNATURE-----

--nextPart3178343.cvBiZZPuXe--
