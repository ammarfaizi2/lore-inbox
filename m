Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVGZIvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVGZIvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 04:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVGZIvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 04:51:14 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:42893 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S261629AbVGZIvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 04:51:09 -0400
Date: Tue, 26 Jul 2005 04:45:41 -0400
From: Harald Welte <laforge@netfilter.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Eric Leblond <eleblond@inl.fr>, Patrick McHardy <kaber@trash.net>,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: Netlink connector
Message-ID: <20050726084541.GH7925@rama>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Eric Leblond <eleblond@inl.fr>, Patrick McHardy <kaber@trash.net>,
	Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
References: <20050723125427.GA11177@rama> <20050723091455.GA12015@2ka.mipt.ru> <20050724.191756.105797967.davem@davemloft.net> <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com> <20050725070603.GA28023@2ka.mipt.ru> <42E4F800.1010908@trash.net> <1122302623.29940.20.camel@localhost.localdomain> <20050725193351.GB30567@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IuhbYIxU28t+Kd57"
Content-Disposition: inline
In-Reply-To: <20050725193351.GB30567@2ka.mipt.ru>
User-Agent: mutt-ng devel-20050619 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--IuhbYIxU28t+Kd57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 25, 2005 at 11:33:51PM +0400, Evgeniy Polyakov wrote:

> Netlink is transport protocol - no need to add complexity into it,=20
> it must be as simple as possible and thus extensible.

yes.  but when you run into a serious addressing shortage (like the
internet does with ipv4), you develop something that provides more
addresses (such as ipv6).  That's why support for more groups than 32
(per family) is something that should be put in the netlink protocol.

I totally agree that we need a higher-level api on top of that, in order
to hide the details of the networking stack for those not interested in
it.

--=20
- Harald Welte <laforge@netfilter.org>                 http://netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--IuhbYIxU28t+Kd57
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD4DBQFC5fg1XaXGVTD0i/8RArphAJ9n8AMiYjcDTDkqHzPOWoz3hxPSrACXTdkM
3dK9CwuPtTghvc9QWV4A9g==
=mP2X
-----END PGP SIGNATURE-----

--IuhbYIxU28t+Kd57--
