Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbTLKLXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 06:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbTLKLXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 06:23:39 -0500
Received: from coruscant.franken.de ([193.174.159.226]:54209 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id S264873AbTLKLXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 06:23:37 -0500
Date: Thu, 11 Dec 2003 12:18:28 +0100
From: Harald Welte <laforge@netfilter.org>
To: Russell Elik Rademacher <elik@webspires.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPtables hang system when loading over 254 IP Addresses
Message-ID: <20031211111828.GL22826@sunbeam.de.gnumonks.org>
References: <098111156.20031208171810@webspires.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cGfB/trNgB3WtPHu"
Content-Disposition: inline
In-Reply-To: <098111156.20031208171810@webspires.com>
X-Operating-system: Linux sunbeam 2.6.0-test5-nftest
X-Date: Today is Setting Orange, the 53rd day of The Aftermath in the YOLD 3169
User-Agent: Mutt/1.5.4i
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cGfB/trNgB3WtPHu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2003 at 05:18:10PM -0700, Russell Elik Rademacher wrote:
> Hello linux-kernel,

Hi Russell!

>   I was wondering if anyone have fixed or knew the slightly broken
>   issue about loading the IPTables with Ingress/Egress filtering on
>   254 IP addresses or more?  It basically locks up the system in
>   networking level but everything else works fine.
>=20

The netfilter/iptables project has seperate mailinglists,
netfilter@lists.netfilter.org and/or netfilter-devel@lists.netfilter.org
are the ones you might want to contact
(http://netfilter.org/contact.html).

>   Basically, if you knew about the script, APF Firewall script, I uses
>   it and it make extensive uses of the IPTables to make complex
>   firewall rules.  But when it reaches to around 254, it just locks up
>   the network system, rendering the server unaccessible.  It make
>   extensive uses of Ingress/Egress and I only seen it locks up when I
>   make use of Egress filtering. Ingress works fine up to 400 IP
>   addresses and I haven't pushed it that far past it to see how far it
>   can go.  But Egress, it locks it up, when combined with Ingress.
>   Dunno about Egress itself in general.  So...anyone might have a clue
>   on this?

Maybe you should then talk to the "APF Firewall Script" author.  We are
not aware of any iptables-related issues with as little as 254 rules.

--=20
- Harald Welte <laforge@netfilter.org>             http://www.netfilter.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
  "Fragmentation is like classful addressing -- an interesting early
   architectural error that shows how much experimentation was going
   on while IP was being designed."                    -- Paul Vixie

--cGfB/trNgB3WtPHu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2FKEXaXGVTD0i/8RAg5vAKCbO6IRIQOuuU4r+ywRNqPLCrYjDgCgj6dG
QyF1TchGq65gBbRMWw0eK7k=
=zl4i
-----END PGP SIGNATURE-----

--cGfB/trNgB3WtPHu--
