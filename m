Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273119AbRIJAuB>; Sun, 9 Sep 2001 20:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273117AbRIJAtm>; Sun, 9 Sep 2001 20:49:42 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:51235 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S273119AbRIJAtY>; Sun, 9 Sep 2001 20:49:24 -0400
Date: Mon, 10 Sep 2001 02:49:45 +0200
From: Kurt Garloff <garloff@suse.de>
To: Ignacio Vazquez-Abrams <ignacio@openservices.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lockup with 2.4.9-ac10 on Athlon
Message-ID: <20010910024945.B6004@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Ignacio Vazquez-Abrams <ignacio@openservices.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109091804450.1105-100000@terbidium.openservices.net> <Pine.LNX.4.33.0109092023230.11787-100000@terbidium.openservices.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109092023230.11787-100000@terbidium.openservices.net>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 09, 2001 at 08:24:47PM -0400, Ignacio Vazquez-Abrams wrote:
> I have solved the problem. It had to do with the setting of
> CONFIG_APM_REAL_MODE_POWER_OFF. It has to be on in my case.
>=20
> Is there any time when this option _has_ to be off?

BIOSes are broken. The APM interface should offer both real mode and
protected mode services, including the one to power off the system.
Both may be broken, but the likelihood is larger that the real mode
one is working, as that's the one used by Win98.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7nA4pxmLh6hyYd04RArFTAKDTE14chWRs1O7GrgjgXOJ4yvX1KQCgr5ge
Jf5D5pwViy3ETPqtnWtdaHs=
=0ToD
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
