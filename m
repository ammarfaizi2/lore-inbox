Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269496AbTCDSJo>; Tue, 4 Mar 2003 13:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269500AbTCDSJo>; Tue, 4 Mar 2003 13:09:44 -0500
Received: from coruscant.franken.de ([193.174.159.226]:3789 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S269493AbTCDSJl>; Tue, 4 Mar 2003 13:09:41 -0500
Date: Tue, 4 Mar 2003 19:20:06 +0100
From: Harald Welte <laforge@netfilter.org>
To: David =?iso-8859-1?Q?Lagani=E8re?= <spanska@securinet.qc.ca>
Cc: linux-kernel@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: A suggestion for the netfilter part of the sources
Message-ID: <20030304182006.GI4880@sunbeam.de.gnumonks.org>
Mail-Followup-To: Harald Welte <laforge@netfilter.org>,
	David =?iso-8859-1?Q?Lagani=E8re?= <spanska@securinet.qc.ca>,
	linux-kernel@vger.kernel.org,
	Netfilter Development Mailinglist <netfilter-devel@lists.netfilter.org>
References: <3E64E1C8.9040309@securinet.qc.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+1TulI7fc0PCHNy3"
Content-Disposition: inline
In-Reply-To: <3E64E1C8.9040309@securinet.qc.ca>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux sunbeam 2.4.20-nfpom
X-Date: Today is Pungenday, the 63rd day of Chaos in the YOLD 3169
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+1TulI7fc0PCHNy3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 04, 2003 at 12:26:32PM -0500, David Lagani=E8re wrote:
=20
> Since a couple of new kernel versions already, I use to modify two files=
=20
> related to the netfilter part to be able to add more
> ports for the IRC NAT module. I was wondering if you could definitively=
=20
> apply those modifications to the kernel sources.

We (the netfilter developers) thought that for the usual case, 8 ports
should be a reasonable compiletime-limit.  I know, especially for IRC,
this largely depends on the number of IRC networks and servers you want
to support...

> Here are my two modifications:
>=20
> In /usr/src/linux-2.4.20/net/ipv4/netfilter:
> I change "#define MAX_PORTS 8" to "#define MAX_PORTS 15" in both=20
> "ip_conntrack_irc.c" and "ip_nat_irc.c".

yes, this is the (documented) way to compile with support for more ports

> I'd greatly appreciate a reply even though my suggestion is not a good on=
e.

The suggestion is neither 'good' nor 'bad'.  Nobody has (until now)
asked us to raise this value, eight seems to be enough for most people.

As long as your proposal is not backed by more other users who think the
default should be raised, I'd rather leave it the way it currently is.

btw: further discussion should happen at
netfilter-devel@lists.netfilter.org

> David Lagani=E8re
> Network/System Administrator
> Securinet Systems

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--+1TulI7fc0PCHNy3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+ZO5WXaXGVTD0i/8RAsBvAJ9xdiJ24q+V6t3XUquh5kFYch6emwCfaJIM
DU7Ib83fpJ8cY+QLLYnZTBQ=
=HKvP
-----END PGP SIGNATURE-----

--+1TulI7fc0PCHNy3--
