Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030497AbVKIL3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030497AbVKIL3o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 06:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbVKIL3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 06:29:44 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:53386 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751377AbVKIL3o (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 06:29:44 -0500
Subject: Re: New Linux Development Model
From: Ian Kumlien <pomac@vapor.com>
Reply-To: pomac@vapor.com
To: marado@isp.novis.pt
Cc: Linux-kernel@vger.kernel.org, fawadlateef@gmail.com, s0348365@sms.ed.ac.uk,
       hostmaster@ed-soft.at, jerome.lacoste@gmail.com, carlsj@yahoo.com
In-Reply-To: <1131534496.8930.15.camel@noori.ip.pt>
References: <1131500868.2413.63.camel@localhost>
	 <1131534496.8930.15.camel@noori.ip.pt>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-c/N6z2ItvgLmbtqVLEm4"
Date: Wed, 09 Nov 2005 12:30:32 +0100
Message-Id: <1131535832.2413.75.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-c/N6z2ItvgLmbtqVLEm4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-11-09 at 11:08 +0000, Marcos Marado wrote:
> On Wed, 2005-11-09 at 02:47 +0100, Ian Kumlien wrote:
>=20
> > Anyways, I was also miffed that the kernel folks merged a 'ancient'
> > version of ipw2200 and ieee802.11, if they had merged something more
> > current everything would have worked out of the box and all the cleanup=
s
> > would have been easier to cope with. Ie, the intel ppl could release
> > straight patches to the in kernel version. I dunno if they have changed
> > the way their driver works now.
> >=20
> > Atm, the 'ancient' ieee802.11 is what breaks the ipw2200 build. So,
> > basically all testing of cutting edge kernels gets very tedious due to
> > the ieee802.11 package removing the offending .h file and making
> > reversing -gitX and applying -gitY a real PITA.
>=20
> Those are no "ancient" versions, they are the "stable" versions of
> ieee80211, ipw2100 and ipw2200. ipw* folks think, and I have to agree,
> that for the stable kernel (Linux tree) it makes sense to add the stable
> versions of their projects.

Yes, that would make sense if everyone interested changed the 'unstable'
version instead, since they change the version merged it only creates
problems. And if you DO check out the ipw2200 site you see that there
has been no stable release for about a year and that there has been a
large amount of bugfixes.

Also, the 'stable' version didn't use a separated ieee802.11 stack.

So to summarize:
Merging the latest version of both and then, if someone has problems,
tell them to downgrade would be simpler. This also means that the
ipw2200 team could release patches against the kernel as well as
standalone modules.

The 'stable' version that got merged is more or less useless to people
who are smart about their wlans. And on a side note, even the firmware
has improved since then.

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-c/N6z2ItvgLmbtqVLEm4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)

iD8DBQBDcd3Y7F3Euyc51N8RAiecAJ0amg849+i00iqitnhnUyyetaOsxwCdEbnM
6cMPU7HyPi2Y5bTfMqLzBdM=
=C4bm
-----END PGP SIGNATURE-----

--=-c/N6z2ItvgLmbtqVLEm4--

