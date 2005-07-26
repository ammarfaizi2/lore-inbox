Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVGZIvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVGZIvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 04:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVGZIvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 04:51:11 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:41869 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261628AbVGZIvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 04:51:08 -0400
Date: Tue, 26 Jul 2005 04:42:14 -0400
From: Harald Welte <laforge@netfilter.org>
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, johnpol@2ka.mipt.ru,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, netdev@redhat.com
Subject: Re: Netlink connector
Message-ID: <20050726084214.GG7925@rama>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	James Morris <jmorris@redhat.com>,
	"David S. Miller" <davem@davemloft.net>, johnpol@2ka.mipt.ru,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, netdev@redhat.com
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru> <20050724.191756.105797967.davem@davemloft.net> <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Content-Disposition: inline
In-Reply-To: <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2005 at 02:02:10AM -0400, James Morris wrote:
> On Sun, 24 Jul 2005, David S. Miller wrote:
> >From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
> >Date: Sat, 23 Jul 2005 13:14:55 +0400
> >>Andrew has no objection against connector and it lives in -mm
> >A patch sitting in -mm has zero significance.
>=20
> The significance I think is that Andrew is trying to gently encourage som=
e=20
> further progress in the area.

Patrick McHardy is currently working on some ideas on how to extend
netlink.

The fundamental problem that the connector is trying to solve:

1) provide more 'groups' (to transport more different kinds of events)
2) provide an abstract API for other kernel code, so it doesn't have to
   know anything about skb's or networking.

IMHO issue number '1' should (and can) be adressed within netlink.  Wait
for Patrick's work on this to show up on netdev.  We can then think
whether the connctor API (or something similar) can be put on top of it.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC5fdmXaXGVTD0i/8RAl1WAKCQAD4+NFRr1MxqhTpWwluzmWTmUQCeO7r0
Ag/KZSUDLX7PLT/eDmXsOIE=
=kYAe
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--
