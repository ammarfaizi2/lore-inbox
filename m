Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266213AbUHNJKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266213AbUHNJKT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 05:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUHNJKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 05:10:19 -0400
Received: from alhambra.mulix.org ([192.117.103.203]:40152 "EHLO
	granada.merseine.nu") by vger.kernel.org with ESMTP id S266213AbUHNJKM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 05:10:12 -0400
Date: Sat, 14 Aug 2004 12:11:06 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, gene.heskett@verizon.net
Subject: Re: [RFC] HOWTO find oops location
Message-ID: <20040814091106.GO17907@granada.merseine.nu>
References: <200408141153.06625.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WoqaC9TUMqqIOlla"
Content-Disposition: inline
In-Reply-To: <200408141153.06625.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WoqaC9TUMqqIOlla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 14, 2004 at 11:53:06AM +0300, Denis Vlasenko wrote:
> Hi folks,
>=20
> Is this draft HOWTO useful? Comments?

Looks very nice. One small niggle:=20

> EIP is at prune_dcache+0x147/0x1c0
>           ^^^^^^^^^^^^^^^^^^^^^^^^

> Let's try to find out where did that exactly happened.
> Grep in your kernel tree for prune_dcache. Aha, it is defined in
> fs/dcache.c! Ok, execute these two commands:
>=20
> # objdump -d fs/dcache.o > fs/dcache.disasm
> # make fs/cache.s

you mean 'make fs/dcache.s' here, I believe.=20

Cheers,=20
Muli
--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--WoqaC9TUMqqIOlla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBHdcqKRs727/VN8sRAn5xAKC9xloBp+jaH4grqJC9ly26DYz4sgCcDO9L
ogOVSVGQSMV3doe2vOLgeIk=
=raqU
-----END PGP SIGNATURE-----

--WoqaC9TUMqqIOlla--
