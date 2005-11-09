Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVKIMgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVKIMgg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 07:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbVKIMgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 07:36:36 -0500
Received: from onyx.ip.pt ([195.23.92.252]:34951 "EHLO mail.isp.novis.pt")
	by vger.kernel.org with ESMTP id S1750711AbVKIMgf (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 07:36:35 -0500
Subject: Re: New Linux Development Model
From: Marcos Marado <marado@isp.novis.pt>
Reply-To: marado@isp.novis.pt
To: pomac@vapor.com
Cc: Linux-kernel@vger.kernel.org, fawadlateef@gmail.com, s0348365@sms.ed.ac.uk,
       hostmaster@ed-soft.at, jerome.lacoste@gmail.com, carlsj@yahoo.com
In-Reply-To: <1131535832.2413.75.camel@localhost>
References: <1131500868.2413.63.camel@localhost>
	 <1131534496.8930.15.camel@noori.ip.pt> <1131535832.2413.75.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1lmG6v8tnTZyGnzH9510"
Organization: Novis ISP
Date: Wed, 09 Nov 2005 12:37:56 +0000
Message-Id: <1131539876.8930.44.camel@noori.ip.pt>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1lmG6v8tnTZyGnzH9510
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-11-09 at 12:30 +0100, Ian Kumlien wrote:
> On Wed, 2005-11-09 at 11:08 +0000, Marcos Marado wrote:
> > On Wed, 2005-11-09 at 02:47 +0100, Ian Kumlien wrote:
> > > Atm, the 'ancient' ieee802.11 is what breaks the ipw2200 build. So,
> > > basically all testing of cutting edge kernels gets very tedious due t=
o
> > > the ieee802.11 package removing the offending .h file and making
> > > reversing -gitX and applying -gitY a real PITA.
> >=20
> > Those are no "ancient" versions, they are the "stable" versions of
> > ieee80211, ipw2100 and ipw2200. ipw* folks think, and I have to agree,
> > that for the stable kernel (Linux tree) it makes sense to add the stabl=
e
> > versions of their projects.
>=20
> Yes, that would make sense if everyone interested changed the 'unstable'
> version instead, since they change the version merged it only creates
> problems. And if you DO check out the ipw2200 site you see that there
> has been no stable release for about a year and that there has been a
> large amount of bugfixes.
>=20
> Also, the 'stable' version didn't use a separated ieee802.11 stack.
>=20
> So to summarize:
> Merging the latest version of both and then, if someone has problems,
> tell them to downgrade would be simpler. This also means that the
> ipw2200 team could release patches against the kernel as well as
> standalone modules.
>=20
> The 'stable' version that got merged is more or less useless to people
> who are smart about their wlans. And on a side note, even the firmware
> has improved since then.

I totally disagree. See: for those who don't crawl on lkml, don't
compile kernels or modules or stuff like that, they had two choices: be
without ipw2100 or ipw2200 or learn how to put the drivers in their
kernels. Now, with the stock kernel you have ipw* support, even if
limited for some uses. Most people will be happy with this version, but
yes, there's still work to be done. When there's a new version
considered stable it will get merged into the kernel. Until then, if you
want to ride the unstable horse, you'll have to patch it yourself into
the kernel.

If you want to simplify the process of building the unstable versios of
ipw* or if you think that the newer versions of ipw* should be
considered the new stable, or if you at some point disagree with ipw*
development model you should complain in ipw2100 mailing list at
http://lists.sourceforge.net/lists/listinfo/ipw2100-devel .
Kernel-related, the decision of supporting the latest stable is good and
justifiable.

--=20
Marcos Marado <marado@isp.novis.pt>
Novis ISP

--=-1lmG6v8tnTZyGnzH9510
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDce2krpje80Vhea8RAtoDAKDro5oRA8FXLQr+ohfci3zhjK/wmwCgoCuK
Ju+EqKR6fbbQltivWz+NOYk=
=GtHD
-----END PGP SIGNATURE-----

--=-1lmG6v8tnTZyGnzH9510--

