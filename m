Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbVKIQAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbVKIQAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVKIQAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:00:13 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:62945 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751438AbVKIQAL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:00:11 -0500
X-IronPort-AV: i="3.97,308,1125871200"; 
   d="asc'?scan'208"; a="8865796:sNHT49722507"
Subject: Re: New Linux Development Model
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: marado@isp.novis.pt
Cc: Linux-kernel@vger.kernel.org, fawadlateef@gmail.com, s0348365@sms.ed.ac.uk,
       hostmaster@ed-soft.at, jerome.lacoste@gmail.com, carlsj@yahoo.com
In-Reply-To: <1131539876.8930.44.camel@noori.ip.pt>
References: <1131500868.2413.63.camel@localhost>
	 <1131534496.8930.15.camel@noori.ip.pt> <1131535832.2413.75.camel@localhost>
	 <1131539876.8930.44.camel@noori.ip.pt>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MGSKNiWil68dJncubbE5"
Date: Wed, 09 Nov 2005 17:01:04 +0100
Message-Id: <1131552065.2413.90.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MGSKNiWil68dJncubbE5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Repost, forgot the CC etc lines. (Yeah i know, reply to all etc)

On Wed, 2005-11-09 at 12:37 +0000, Marcos Marado wrote:
> On Wed, 2005-11-09 at 12:30 +0100, Ian Kumlien wrote:
> > So to summarize:
> > Merging the latest version of both and then, if someone has problems,
> > tell them to downgrade would be simpler. This also means that the
> > ipw2200 team could release patches against the kernel as well as
> > standalone modules.
> >=20
> > The 'stable' version that got merged is more or less useless to people
> > who are smart about their wlans. And on a side note, even the firmware
> > has improved since then.
>=20
> I totally disagree. See: for those who don't crawl on lkml, don't
> compile kernels or modules or stuff like that, they had two choices: be
> without ipw2100 or ipw2200 or learn how to put the drivers in their
> kernels. Now, with the stock kernel you have ipw* support, even if
> limited for some uses. Most people will be happy with this version, but
> yes, there's still work to be done. When there's a new version
> considered stable it will get merged into the kernel. Until then, if you
> want to ride the unstable horse, you'll have to patch it yourself into
> the kernel.

Since it has to be out of tree the way it is now, you don't patch or
upgrade, you simply have to make it compile. And if you are happy with
wlan driver that hardly does wep then you have some issues as well.

> If you want to simplify the process of building the unstable versios of
> ipw* or if you think that the newer versions of ipw* should be
> considered the new stable, or if you at some point disagree with ipw*
> development model you should complain in ipw2100 mailing list at
> http://lists.sourceforge.net/lists/listinfo/ipw2100-devel .
> Kernel-related, the decision of supporting the latest stable is good and
> justifiable.

Thats why we have "experimental" drivers in the kernel?=20

like, f.ex.:
Packet Engines Yellowfin Gigabit-NIC support (EXPERIMENTAL)
New SysKonnect GigaEthernet support (EXPERIMENTAL)

Or the protocols? (STCP, DCCP, etc)

IF a unstable version of a driver is better for the user isn't it better
to merge it as experimental instead of merging a old version that wreaks
havock on users of newer kernels (and they will STILL run the unstable
version on older kernels anyways).

Note: I use skge myself, so pointing out that they are experimental is
in no way negative, i actually prefer it to the stable driver.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-MGSKNiWil68dJncubbE5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBDch1A7F3Euyc51N8RAmiyAJ96VooaYB/izO0u+XTa1OVp9mtcrACfSbm1
MyNcWTp41Rq5eW2yWkJY8HI=
=y4ZX
-----END PGP SIGNATURE-----

--=-MGSKNiWil68dJncubbE5--
