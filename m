Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030764AbWI0U0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030764AbWI0U0Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 16:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030765AbWI0U0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 16:26:24 -0400
Received: from r16s03p19.home.nbox.cz ([83.240.22.12]:49815 "EHLO
	scarab.smoula.net") by vger.kernel.org with ESMTP id S1030764AbWI0U0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 16:26:23 -0400
Subject: Re: forcedeth - WOL
From: Martin Filip <bugtraq@smoula.net>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200609271935.12969.s0348365@sms.ed.ac.uk>
References: <1159379441.9024.7.camel@archon.smoula-in.net>
	 <200609271935.12969.s0348365@sms.ed.ac.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Leuk+6QFnSh3nid6rx39"
Date: Wed, 27 Sep 2006 22:26:14 +0200
Message-Id: <1159388774.10054.1.camel@archon.smoula-in.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Leuk+6QFnSh3nid6rx39
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

Hi,

no.. I don't think it's my problem

# ethtool eth0
Settings for eth0:
        Supported ports: [ MII ]
        Supported link modes:   10baseT/Half 10baseT/Full=20
                                100baseT/Half 100baseT/Full=20
                                1000baseT/Full=20
        Supports auto-negotiation: Yes
        Advertised link modes:  10baseT/Half 10baseT/Full=20
                                100baseT/Half 100baseT/Full=20
                                1000baseT/Full=20
        Advertised auto-negotiation: Yes
        Speed: 100Mb/s
        Duplex: Full
        Port: MII
        PHYAD: 1
        Transceiver: external
        Auto-negotiation: on
        Supports Wake-on: g
        Wake-on: g
        Link detected: yes


Alistair John Strachan p=ED=B9e v St 27. 09. 2006 v 19:35 +0100:
> On Wednesday 27 September 2006 18:50, Martin Filip wrote:
> > Hi to LKML,
> >
> > I'm experiencing some troubles with WOL with my nForce NIC.
> > The problem is simple - after setting WOL mode to magic packet my PC
> > won't wake up. I've noticed there were some changes about this in new
> > kernel, but no luck for me.
> >
> > I'm using 2.6.18 kernel, vanilla. I've tried this with Windows Vista RC=
1
> > (build 5600) and WOL works correctly. My NIC is integrated on MSI K8N
> > Neo4-FI
>=20
> On my nForce4 CK804 it's disabled by default, I bet this is your problem:
>=20
> [root] 19:33 [~] ethtool lan
> Settings for lan:
>         Supported ports: [ MII ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Full
>         Supports auto-negotiation: Yes
>         Advertised link modes:  10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                 1000baseT/Full
>         Advertised auto-negotiation: Yes
>         Speed: 100Mb/s
>         Duplex: Full
>         Port: MII
>         PHYAD: 1
>         Transceiver: external
>         Auto-negotiation: on
>         Supports Wake-on: g
>         Wake-on: d
>         Link detected: yes
>=20
> Read the manpage for ethtool. HTH.
>=20
--=20
Martin Filip
e-mail: nexus@smoula.net
ICQ#: 31531391
jabber: nexus@smoula.net
www: http://www.smoula.net

 _______________________________________=20
/ BOFH Excuse #410: Electrical conduits \
\ in machine room are melting.          /
 ---------------------------------------=20
       \   ,__,
        \  (oo)____
           (__)    )\
              ||--|| *

--=-Leuk+6QFnSh3nid6rx39
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Toto je =?UTF-8?Q?digit=C3=A1ln=C4=9B?=
	=?ISO-8859-1?Q?_podepsan=E1?= =?UTF-8?Q?_=C4=8D=C3=A1st?=
	=?ISO-8859-1?Q?_zpr=E1vy?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFGt5mzvp9bBLJ9XMRAgLSAJ4sYf67fExQpQsv9D0dzDd300rsVACfYTiF
s59UXCzC+W8asOQDMrvr/ro=
=EQzq
-----END PGP SIGNATURE-----

--=-Leuk+6QFnSh3nid6rx39--

