Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbTDPVAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 17:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264587AbTDPVAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 17:00:31 -0400
Received: from iucha.net ([209.98.146.184]:1845 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S264584AbTDPVA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 17:00:29 -0400
Date: Wed, 16 Apr 2003 16:12:23 -0500
To: Dave Jones <davej@codemonkey.org.uk>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Message-ID: <20030416211223.GH29143@iucha.net>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030415133608.A1447@cuculus.switch.gts.cz> <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com> <20030415164435.GA6389@rivenstone.net> <20030415182057.GC29143@iucha.net> <20030415154355.08ef6672.akpm@digeo.com> <20030416004556.GD29143@iucha.net> <1050493328.28591.42.camel@dhcp22.swansea.linux.org.uk> <20030416131536.GF29143@iucha.net> <20030416135819.GB18358@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8sldprk+5E/pDEv"
Content-Disposition: inline
In-Reply-To: <20030416135819.GB18358@suse.de>
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8sldprk+5E/pDEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2003 at 02:58:19PM +0100, Dave Jones wrote:
> On Wed, Apr 16, 2003 at 08:15:36AM -0500, Florin Iucha wrote:
>=20
>  > 00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
>  > 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL
>  > [Radeon 8500 LE]
>  >=20
>  > Maybe the AGP code is trying to push some bits in the wrong
>  > port/address?
>=20
> SiS driver internals haven't changed (at least not under my hands),
> so it should be poking the same bits in the same registers as the
> 2.4 driver does. The only 'bits in wrong address' type bug outstanding
> in agpgart is that the gatt_table address is potentially allocated as
> a 64bit address and truncated to fit into 32bits, but that will only bite
> you on a 64bit host that uses the generic gatt allocation routines.
> (Namely x86-64).

Should I try 2.4.20? I can not try -ac kernels because all my filesystems
are xfs.

florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--a8sldprk+5E/pDEv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+ncc3NLPgdTuQ3+QRAsWmAKCcodS8mbxZneijJtQStak0fEWppACcCgGh
ofGI+KIcMWMpf9HdS6Ybm1g=
=0iZM
-----END PGP SIGNATURE-----

--a8sldprk+5E/pDEv--
