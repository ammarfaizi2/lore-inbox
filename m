Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316678AbSFUQYI>; Fri, 21 Jun 2002 12:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSFUQYC>; Fri, 21 Jun 2002 12:24:02 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:52547 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S316678AbSFUQX7>; Fri, 21 Jun 2002 12:23:59 -0400
Date: Fri, 21 Jun 2002 18:24:00 +0200
From: Kurt Garloff <garloff@suse.de>
To: Linux SCSI list <linux-scsi@vger.kernel.org>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: [ANN] Tekram DC3x5 SCSI driver 1.41
Message-ID: <20020621162400.GE29154@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux SCSI list <linux-scsi@vger.kernel.org>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

the version 1.41 of the Tekram DC3x5 (TRM-S1040 chip) driver has been
released.
It includes support for new exception handling (at this moment only
enabled by default on 2.5, on 2.4 you can pass FORCE_NEW_EH=3D1 to
the makefile to test, will be default for 2.4 when more testing has=20
happened) which has been contributed by Douglas Gilbert and subsequently
completed by myself. Thanks go to Martin Peschke and Aron Zeh as well for
answering questions related to new EH.
Keith Owens has contributed a few fixes WRT to unaligned accesses and
one sg_map fix for iA64. The driver seems to work there, BTW!
The Makefiles now also support 2.5.

http://www.garloff.de/kurt/linux/dc395/
ftp://ftp.suse.com/pub/people/garloff/linux/dc395/

The usual care should be applied.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE Linux AG, Nuernberg, DE                            SCSI, Security

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9E1MfxmLh6hyYd04RAtT2AJ42O8VcWygKjN8xNbdNfWfotkYWSACglwWk
GNcqJlIhEDnxs0P3JUSZc9k=
=U87W
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
