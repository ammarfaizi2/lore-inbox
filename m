Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWCQOtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWCQOtW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWCQOtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:49:22 -0500
Received: from lug-owl.de ([195.71.106.12]:31419 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750810AbWCQOtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:49:22 -0500
Date: Fri, 17 Mar 2006 15:49:20 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Andras Mantia <amantia@kde.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Message-ID: <20060317144920.GS20746@lug-owl.de>
Mail-Followup-To: Andras Mantia <amantia@kde.org>,
	linux-kernel@vger.kernel.org
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HqPpMaT+a6TeY/Q4"
Content-Disposition: inline
In-Reply-To: <dvehv7$j9r$1@sea.gmane.org>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HqPpMaT+a6TeY/Q4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-03-17 16:43:55 +0200, Andras Mantia <amantia@kde.org> wrote:
> Jan-Benedict Glaw wrote:
> I know, but in this case I got this answer:=20
> " Dear Friend :

Huh?

>   Thank you for contacting ASUS Customer Service.
>   My name is ZYC, and I would be assisting you today.=20

Interesting name...

>  sorry ,due to chipset limitation ,
> when you add a PCI AUDIO card to a board which use VIA VT8237 southbridge
> controller ,
> the built in AC97 audio will be disabled automaticly .
> it is a chip limitation without way to fix ."
>=20
> Meantime I tried the patch against the 2.6.13-15 kernel shipped with SuSE=
 10
> (applied without errors), and altough I see=20
> PCI: enabled onboard AC97/MC97 devices
>=20
> in the logs, the onboard  card doesn't appear in lspci.

Maybe the fix was running too late? There needs to be a PCI bus scan
afterwards...  Test with a newer kernel version, hopefully not patched
to death...

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

--HqPpMaT+a6TeY/Q4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEGsxwHb1edYOZ4bsRAm5oAKCQJTwiyo8ed73bViWH6Zea0B4BBACZAQtP
c2mjtUyvN/PWNNE7IcJbdug=
=T7SM
-----END PGP SIGNATURE-----

--HqPpMaT+a6TeY/Q4--
