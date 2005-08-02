Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVHBJOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVHBJOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 05:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261441AbVHBJOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 05:14:04 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:27657 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261438AbVHBJNP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 05:13:15 -0400
Date: Tue, 2 Aug 2005 11:13:13 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050802091313.GB6724@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <42ED4CCF.6020803@andrew.cmu.edu> <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe> <dckikj$e8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
In-Reply-To: <dckikj$e8$1@sea.gmane.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 01, 2005 at 08:19:42AM +0200, Stefan Seyfried wrote:
> Lee Revell wrote:
> > On Mon, 2005-08-01 at 00:47 +0200, Pavel Machek wrote:
> >> I'm pretty sure at least one distro will go with HZ<300 real soon now
> >> ;-).
> >>=20
> >=20
> > Any idea what their official recommendation for people running apps that
> > require the 1ms sleep resolution is?  Something along the lines of "Get
> > bent"?
>=20
> MPlayer is using /dev/rtc and was running smooth for me since the good
> old 2.4 days.

 VMware also uses /dev/rtc. So is NTP, which is needed when time drifts.
But they can't use /dev/rtc simultanously, as it's single-open device.
So running ntpd denies vmware and mplayer access to RTC. Bummer.

--=20
Tomasz Torcz            There exists no separation between gods and men:
zdzichu@irc.-nie.spam-.pl   one blends softly casual into the other.


--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFC7zkpThhlKowQALQRAkVfAKDnqziyvvlL2DSsms6sqH1Ru1aLvgCfZj8l
TAwvvd5uLTAIpNeSslpJ2uU=
=bOOR
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
