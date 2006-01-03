Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964847AbWACWN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964847AbWACWN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 17:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbWACWN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 17:13:26 -0500
Received: from 6.143.111.62.revers.nsm.pl ([62.111.143.6]:9748 "HELO
	matthew.ogrody.nsm.pl") by vger.kernel.org with SMTP
	id S932533AbWACWNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 17:13:25 -0500
Date: Tue, 3 Jan 2006 23:13:14 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Adrian Bunk <bunk@stusta.de>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Takashi Iwai <tiwai@suse.de>,
       Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060103221314.GB23175@irc.pl>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Jesper Juhl <jesper.juhl@gmail.com>, Takashi Iwai <tiwai@suse.de>,
	Olivier Galibert <galibert@pobox.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
	perex@suse.cz, alsa-devel@alsa-project.org,
	James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
	linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
	parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
	Thorsten Knabe <linux@thorsten-knabe.de>,
	zwane@commfireservices.com, zaitcev@yahoo.com,
	linux-kernel@vger.kernel.org
References: <20050726150837.GT3160@stusta.de> <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de> <20060103203732.GF5262@irc.pl> <s5hvex1m472.wl%tiwai@suse.de> <9a8748490601031256x916bddav794fecdcf263fb55@mail.gmail.com> <20060103215654.GH3831@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline
In-Reply-To: <20060103215654.GH3831@stusta.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2006 at 10:56:54PM +0100, Adrian Bunk wrote:
> > > > > Well, we keep the compatibility exactly -- OSS drivers don't supp=
ort
> > > > > software mixing in the kernel, too :)
> > > >
> > > >  OSS will support software mixing. In kernel. On NetBSD.
> > > > http://kerneltrap.org/node/4388
> > >
> > > Why do we need to keep the compatibility with NetBSD?
> > >
> > Software mixing is a really nice feature for people with soundscards
> > that can't do hardware mixing, so if the OSS compatibility could
> > transparently do software mixing for apps using OSS api that would be
> > a very nice extension for a lot of people - I'd say that if NetBSD do
> > that they've got the right idea.
>=20
> The OSS compatibility in ALSA is only a legacy API for applications not=
=20
> yet converted to use the ALSA API.

  OSS is universal cross-unix API. ALSA is Linux-only.

--=20
Tomasz Torcz            There exists no separation between gods and men:
zdzichu@irc.-nie.spam-.pl   one blends softly casual into the other.


--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFDuvb6ThhlKowQALQRAoXfAJ9aAPT8GDVP1705lihGUfTWFVaNlwCfVAti
2FrHucsItUoX+dzqTc9Fe7U=
=vPrv
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
