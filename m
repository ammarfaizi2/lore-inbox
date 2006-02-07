Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWBGWo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWBGWo7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 17:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbWBGWnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 17:43:15 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:54747 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932448AbWBGWnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 17:43:13 -0500
From: Nigel Cunningham <nigel@suspend2.net>
Organization: Suspend2.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Tue, 7 Feb 2006 19:40:41 +1000
User-Agent: KMail/1.9.1
Cc: Lee Revell <rlrevell@joe-job.com>, Jim Crilly <jim@why.dont.jablowme.net>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, suspend2-devel@lists.suspend2.net,
       linux-kernel@vger.kernel.org
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <1139282017.2041.44.camel@mindpipe> <20060207093737.GC1742@elf.ucw.cz>
In-Reply-To: <20060207093737.GC1742@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart43828972.nZj8ZxsGDD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602071940.53843.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart43828972.nZj8ZxsGDD
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Tuesday 07 February 2006 19:37, Pavel Machek wrote:
> On Po 06-02-06 22:13:36, Lee Revell wrote:
> > On Mon, 2006-02-06 at 22:01 -0500, Jim Crilly wrote:
> > > On 02/06/06 08:19:02PM -0500, Lee Revell wrote:
> > > > On Mon, 2006-02-06 at 19:59 -0500, Jim Crilly wrote:
> > > > > I guess reasonable is a subjective term. For instance, I've seen=
=20
quite
> > > > > a few people vehemently against adding new ioctls to the kernel=20
and
> > > > > yet you'll be adding quite a few for /dev/snapshot. I'm just of=20
the
> > > > > same mind as Nigel in that it makes the most sense to me that the
> > > > > majority of the suspend/hibernation process to be in the kernel.=
=20
> > > >=20
> > > > No one is saying that ANY new ioctls are bad, just that the KISS
> > > > principle of engineering dictates that it's bad design to use=20
ioctls
> > > > where a simple read/write to a sysfs file will do.
> > > >=20
> > >=20
> > > I understand that, but shouldn't the KISS principle also be applied=20
to
> > > the user interface of a feature?
> >=20
> > Personally I agree with you on suspend2, I think this is something that
> > needed to Just Work yesterday, and every day it doesn't work we are
> > losing users... but who am I to talk, I'm not the one who will have to
> > maintain it.
>=20
> It does just work in mainline now. If it does not please open bug
> account at bugzilla.kernel.org.
>=20
> If mainline swsusp is too slow for you, install uswsusp. If it is
> still too slow for you, mail me a patch adding LZW to userland code
> (should be easy).

<horrified rebuke>

Pavel!

Responses like this are precisely why you're not the most popular kernel=20
maintainer. Telling people to use beta (alpha?) code or fix it themselves=20
(and then have their patches rejected by you) is no way to maintain a part=
=20
of the kernel. Stop being a liability instead of an asset!

</horrified rebuke>

Nigel

=2D-=20
See our web page for Howtos, FAQs, the Wiki and mailing list info.
http://www.suspend2.net                IRC: #suspend2 on Freenode

--nextPart43828972.nZj8ZxsGDD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD6GslN0y+n1M3mo0RAl2YAJ9GqHvVQ53K2G6yQUMaMmJ1ejpk3QCgpizb
lKrr0WoVn9mytr6ZErBehwA=
=4fZG
-----END PGP SIGNATURE-----

--nextPart43828972.nZj8ZxsGDD--
