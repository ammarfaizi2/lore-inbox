Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272313AbTGYUiD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 16:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272312AbTGYUiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 16:38:03 -0400
Received: from coruscant.franken.de ([193.174.159.226]:36498 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S272311AbTGYUhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 16:37:52 -0400
Date: Fri, 25 Jul 2003 22:50:24 +0200
From: Harald Welte <laforge@netfilter.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Adrian Bunk <bunk@fs.tum.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       "David S. Miller" <davem@redhat.com>,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [2.4 patch] netfilter Configure.help cleanup
Message-ID: <20030725205024.GA3244@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Adrian Bunk <bunk@fs.tum.de>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org
References: <20030717201304.GL1407@fs.tum.de> <20030718012910.0D5BB2C5A9@lists.samba.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JhY86nTAwD/oWhC3"
Content-Disposition: inline
In-Reply-To: <20030718012910.0D5BB2C5A9@lists.samba.org>
X-Operating-system: Linux sunbeam 2.6.0-test1-nftest
X-Date: Today is Prickle-Prickle, the 53rd day of Confusion in the YOLD 3169
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JhY86nTAwD/oWhC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2003 at 11:06:49AM +1000, Rusty Russell wrote:
> In message <20030717201304.GL1407@fs.tum.de> you write:
>
> > the patch below does the following changes to the netfilter entries in
> > Configure.help in 2.4.22-pre2:
> > - order similar to net/ipv4/netfilter/Config.in
> > - remove useless short descriptions above CONFIG_*
> > - added CONFIG_IP_NF_MATCH_RECENT entry (stolen from 2.5)
>=20
> Sorry Adrian, I think this is overzealous.
>=20
> Please just add the CONFIG_IP_NF_MATCH_RECENT entry.  Remember,
> "stable" means "boring". 8)

I will submit the RECENT entry to davem with my next set of patches.

Does everybody else have an ordered Configure.help?  if yes, I'd accept
the patch to comply with common practice.  If not, I would just say: who
cares about the order, it's processed by {old,menu,x}config anyway.

> Rusty.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--JhY86nTAwD/oWhC3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/IZgQXaXGVTD0i/8RArFrAJ912q2rrMA9hpwko3PQ6UDagd1H5wCgi5Jk
s5GFci4ROPUR5mfpwrZTN1E=
=6uEt
-----END PGP SIGNATURE-----

--JhY86nTAwD/oWhC3--
