Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbWAYAab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbWAYAab (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 19:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750913AbWAYAaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 19:30:30 -0500
Received: from mail.gmx.de ([213.165.64.21]:28139 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750912AbWAYAaa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 19:30:30 -0500
X-Authenticated: #24128601
Date: Wed, 25 Jan 2006 01:30:50 +0100
From: Sebastian <sebastian_ml@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: radeonfb: monitor_layout doesn't work, need to disable second head
Message-ID: <20060125003050.GA8086@section_eight.mops.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
X-PGP-Key: http://www-users.rwth-aachen.de/sebastian.kemper/sebastian_ml_pubkey.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

(please CC me)

I got a Radeon 9250 video card with a DVI and a VGA port. The DVI is
connected to my flat panel. The VGA port is connected, too, but to a TV.

I'd like to disable the VGA port, because when it's enabled the tv is
driven at a resolution it doesn't support.

I tried booting with the following parameters:

append=3D"radeonfb.monitor_layout=3DTMDS,NONE radeonfb.mirror=3D0"

But there is still a signal on the VGA port. Apologies for taking this
to this list, but I can't find the infos I need on the web, or at least
my code reading skills are not 100% so that I could figure it out by
myself.

Do I need to change my boot parameters or does it need a change to the
driver code?

Thank you

Sebastian
--=20
"When the going gets weird, the weird turn pro." (HST)

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD1sa6TWouIrjrWo4RAnXZAJ4+S2k4NQ4Cset/7Zbi4OU4i+BivQCeMASI
8frUJ+gFrxk2m1KrsaOIHlQ=
=K2Jh
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--

