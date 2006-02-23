Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWBWAOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWBWAOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 19:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbWBWAOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 19:14:40 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:1930 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1751479AbWBWAOk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 19:14:40 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Pavel Machek <pavel@suse.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Thu, 23 Feb 2006 10:11:39 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Andreas Happe <andreashappe@snikt.net>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602230031.41217.rjw@sisk.pl> <20060222235639.GK13621@elf.ucw.cz>
In-Reply-To: <20060222235639.GK13621@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart114077821.NTvfepT8ZO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602231011.44889.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart114077821.NTvfepT8ZO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 23 February 2006 09:56, Pavel Machek wrote:
> > > > The fact that we use page flags to store some suspend/resume-related
> > > > information is a big disadvantage in my view, and I'd like to get r=
id
> > > > of that in the future.  In principle we could use a bitmap, or rath=
er
> > > > two of them, to store the same information independently of the page
> > > > flags, and if we use bitmaps for this purpose, we can use them also
> > > > instead of PBEs.
> > >
> > > Well, we "only" use 2 bits... :-).
> >
> > In my view the problem is this adds constraints that other people have =
to
> > take into account.  Not a good thing if avoidable IMHO.
>
> Well, I hope that swsusp development will move to userland in future
>
> :-).

I don't get your point. I mean, we're talking about flags that record what=
=20
pages are going to be in the image, be atomically copied and so on. Are you=
=20
planning on trying to export the free page information and the like to=20
userspace too, along with atomic copy code?

Regards,

Nigel

--nextPart114077821.NTvfepT8ZO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD/P3AN0y+n1M3mo0RAiTGAJ412InDqlp0Is22PMc7ydyLG+8SpwCfWUHm
b/fS2ZNV4OmNU4V7CSOtheI=
=9NNN
-----END PGP SIGNATURE-----

--nextPart114077821.NTvfepT8ZO--
