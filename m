Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbUELV6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUELV6L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 17:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbUELV6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 17:58:11 -0400
Received: from zlynx.org ([199.45.143.209]:36868 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S261920AbUELV6E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 17:58:04 -0400
Subject: Re: MSEC_TO_JIFFIES is messed up...
From: Zan Lynx <zlynx@acm.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Davide Libenzi <davidel@xmailserver.org>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
In-Reply-To: <20040512211255.GA20800@elte.hu>
References: <20040512020700.6f6aa61f.akpm@osdl.org>
	 <20040512181903.GG13421@kroah.com> <40A26FFA.4030701@pobox.com>
	 <20040512193349.GA14936@elte.hu>
	 <Pine.LNX.4.58.0405121247011.11950@bigblue.dev.mdolabs.com>
	 <20040512200305.GA16078@elte.hu>
	 <Pine.LNX.4.58.0405121400360.11950@bigblue.dev.mdolabs.com>
	 <20040512211255.GA20800@elte.hu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tyT1IZs0Aqen8m1DlB8J"
Message-Id: <1084399017.27252.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7jb) 
Date: Wed, 12 May 2004 15:56:57 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tyT1IZs0Aqen8m1DlB8J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-05-12 at 15:12, Ingo Molnar wrote:
> * Davide Libenzi <davidel@xmailserver.org> wrote:
>=20
> > int foo(int i) {
> >=20
> >=20
> >         return i * 1000 / 1000;
> > }
>=20
> try unsigned and you'll see:
[snip]

I forgot to add that yes I know i * (x / 1000) is different than i * x /
1000 in integer math.  Please don't hit me.
--=20
Zan Lynx <zlynx@acm.org>

--=-tyT1IZs0Aqen8m1DlB8J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAop2pG8fHaOLTWwgRAu34AJwMXBXS5I9WzBcNDlXuNwy+iRf+rACcCOrj
J66yZh73io1vDNmaB6Rau0A=
=pyaH
-----END PGP SIGNATURE-----

--=-tyT1IZs0Aqen8m1DlB8J--

