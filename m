Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUDFXZS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 19:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbUDFXZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 19:25:18 -0400
Received: from mail01.hansenet.de ([213.191.73.61]:63428 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP id S264061AbUDFXZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 19:25:11 -0400
Date: Wed, 7 Apr 2004 01:24:58 +0200
From: Bjoern Michaelsen <bmichaelsen@gmx.de>
To: "Hemmann, Volker Armin" <volker.hemmann@heim9.tu-clausthal.de>
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: AGP problem SiS 746FX Linux 2.6.5-rc3
Message-ID: <20040406232458.GC9389@lord.sinclair>
References: <20040406031949.GA8351@lord.sinclair> <200404070001.35514.volker.hemmann@heim10.tu-clausthal.de> <20040406221403.GB10142@redhat.com> <200404070026.00589.volker.hemmann@heim10.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline
In-Reply-To: <200404070026.00589.volker.hemmann@heim10.tu-clausthal.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2004 at 12:26:00AM +0200, Hemmann, Volker Armin wrote:
> If you have more patches you want to get tested, just send them.. with fs=
 or=20
> ide-patches I would be a lot more reluctant ;o)
Just to make confusion perfect: my patch lets me work in AGP V3.0
on SiS 746. Just in case here is the relevant part of my lspci:

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0746 =
(rev 02)
	Subsystem: Elitegroup Computer Systems: Unknown device 1808
	Flags: bus master, medium devsel, latency 0
	Memory at d0000000 (32-bit, non-prefetchable) [size=3D128M]
	Capabilities: [c0] AGP version 3.0

01:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0312 =
(rev a1) (prog-if 00 [VGA])
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
	Memory at ce000000 (32-bit, non-prefetchable) [size=3D16M]
	Memory at b0000000 (32-bit, prefetchable) [size=3D256M]
	Expansion ROM at cfee0000 [disabled] [size=3D128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 3.0

this is a ECS L7S7A2 mainboard and a NoName (Manli) GeForce
FX5600TD 256MB.
Yours,
--=20
Bj=F6rn Michaelsen
pub  1024D/C9E5A256 2003-01-21 Bj=F6rn Michaelsen <bmichaelsen@gmx.de>
   Key fingerprint =3D D649 8C78 1CB1 23CF 5CCF  CA1A C1B5 BBEC C9E5 A256

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAczxKwbW77MnlolYRAt6YAKDG3vwBmiffKlJHLXUEue+M7fSCOACeO2+z
SJcuquLqw5JNj7DTMbmZnGU=
=/MUE
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--
