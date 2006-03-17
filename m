Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWCQOdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWCQOdI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWCQOdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:33:08 -0500
Received: from lug-owl.de ([195.71.106.12]:18852 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751121AbWCQOdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:33:07 -0500
Date: Fri, 17 Mar 2006 15:33:03 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Andras Mantia <amantia@kde.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Message-ID: <20060317143303.GR20746@lug-owl.de>
Mail-Followup-To: Andras Mantia <amantia@kde.org>,
	linux-kernel@vger.kernel.org
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bGopQmzlzQgFk3Fg"
Content-Disposition: inline
In-Reply-To: <dve3j9$r50$1@sea.gmane.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bGopQmzlzQgFk3Fg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-03-17 12:38:33 +0200, Andras Mantia <amantia@kde.org> wrote:
> bjd wrote:
> > From: Bauke Jan Douma <bjdouma@xs4all.nl>
> > On ASUS A8V and A8V Deluxe boards, the onboard AC97 audio controller
> > and MC97 modem controller are deactivated when a second PCI soundcard
> > is present.  This patch enables them.
>=20
> Thanks for the patch! I can't wait to go home and try it. AFAIK it affects
> other boards aside of the ASUS A8V using the same chipset. Once I contact=
ed
> the ASUS support and they told me due to the chipset's design it is not
> possible to enable the onboard sound when a PCI card is installed. It is
> amazing that you could do it. :-)

Nonsense :-)  These days, it's merely only a bit in PCI config space
that needs a flip.  Since vendors seem more and more to `care' about
their customers to only use one (that is, the newly bought additional
sound card, or even other equipment) I even thought about writing a
little helper program to help finding the correct bit.

Just for the records, it happens actually quite often that some little
features / improvements of a chipset have bugs; from time to time,
you'll see a BIOS update that doesn't really do more than switching
off that feature. I guess that quite some of our quirks originate from
looking at what a newer BIOS configures differently compared to an
older version.  Some instability can be fixed that way (though it's
better to have a fix for such a bug inside the BIOS: this way, the fix
is in place at the time the Linux kernel is loaded, so there's no way
for it to eg. cause memory corruption between loading the kernel and
issueing the quirks.)

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--bGopQmzlzQgFk3Fg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEGsifHb1edYOZ4bsRAtb0AJ9oy8LfsqbCF5l0/JIVRucuwBTr8wCfWZgL
o8kdSyTvAEDC4rB1D+274ak=
=FPOB
-----END PGP SIGNATURE-----

--bGopQmzlzQgFk3Fg--
