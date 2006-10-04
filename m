Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030666AbWJDN5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030666AbWJDN5t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030675AbWJDN5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:57:49 -0400
Received: from nsm.pl ([195.34.211.229]:18181 "EHLO nsm.pl")
	by vger.kernel.org with ESMTP id S1030666AbWJDN5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:57:48 -0400
Date: Wed, 4 Oct 2006 15:57:43 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Takashi Iwai <tiwai@suse.de>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.18: hda_intel: azx_get_response timeout, switching to single_cmd mode...
Message-ID: <20061004135743.GA6150@irc.pl>
Mail-Followup-To: Jeremy Fitzhardinge <jeremy@goop.org>,
	Takashi Iwai <tiwai@suse.de>, Pavel Machek <pavel@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	alsa-devel@alsa-project.org, Andrew Morton <akpm@osdl.org>
References: <451834D0.40304@goop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <451834D0.40304@goop.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2006 at 12:58:08PM -0700, Jeremy Fitzhardinge wrote:
> I have a ThinkPad X60 which uses the Intel 82801G HDA audio chip.  This=
=20
> used to work for me, but lately (sometime during 2.6.18-rcX series) it=20
> stopped working - programs trying to use it tend to just block forever=20
> waiting for /dev/dsp.
>=20
> The only obvious symptom is:
>=20
>    hda_intel: azx_get_response timeout, switching to single_cmd mode...
>=20
> appearing in the kernel log when booting.


  Just a blind shot -- do you have modem enabled in BIOS? Sometimes
disabling (hiding) modem breaks sound.

--=20
Tomasz Torcz                        To co nierealne -- tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na =BFycie maj=B1 tu patenty spe=
cjalne.


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFFI73X10UJr+75NrkRAmYHAJ0TB0Au0J0vZMwF6xRx6V0oYObSQACgiOhN
zx1HFPLGojc2s+HKGYtdd2k=
=mndS
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
