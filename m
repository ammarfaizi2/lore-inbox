Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbTFMVBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 17:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265531AbTFMVBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 17:01:43 -0400
Received: from B528c.pppool.de ([213.7.82.140]:442 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id S265533AbTFMVBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 17:01:32 -0400
Subject: Re: linux-2.4.21 released
From: Daniel Egger <degger@fhm.edu>
To: Damian =?iso-8859-2?Q?Ko=B3kowski?= <deimos@deimos.one.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Stephan von Krawczynski <skraw@ithnet.com>, stefan@stefan-foerster.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030613183639.GA533@deimos.one.pl>
References: <200306131453.h5DErX47015940@hera.kernel.org>
	 <20030613165628.GE28609@in-ws-001.cid-net.de>
	 <20030613165625.GA573@deimos.one.pl>
	 <20030613193709.49f22332.skraw@ithnet.com>
	 <20030613171903.GA797@deimos.one.pl>
	 <1055526549.5162.78.camel@dhcp22.swansea.linux.org.uk>
	 <20030613183639.GA533@deimos.one.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oBAma0oWfsRJEObhMHhj"
Message-Id: <1055538278.11366.13.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 13 Jun 2003 23:04:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oBAma0oWfsRJEObhMHhj
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

Am Fre, 2003-06-13 um 20.36 schrieb Damian Ko=B3kowski:

> ACPI works with new acpid-1.0.2, but without CONFIG_X86_UP_IOAPIC :-)

Surprise, but ACPI never was the problem with this board... :)
I've tested a few more kernels. .21 fails as well as the latest -ac.

Unfortunately the -ac's also have "interesting" troubles with my 2nd
NIC in the machine which is a

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at d800 [size=3D256]
        Memory at e0108000 (32-bit, non-prefetchable) [size=3D256]
        Capabilities: [50] Power Management version 2

It loads perfectly but has problems coping with the media.=20

--=20
Servus,
       Daniel

--=-oBAma0oWfsRJEObhMHhj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+6jxmchlzsq9KoIYRAlJfAJ9/WoVxTTT4BHaVQsaFLdFoiHK86wCgnzUG
6MTcSPCdmwp8zo6DUZu+KOU=
=hIL9
-----END PGP SIGNATURE-----

--=-oBAma0oWfsRJEObhMHhj--

