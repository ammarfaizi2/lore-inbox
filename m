Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWACUgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWACUgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 15:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWACUgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 15:36:42 -0500
Received: from 6.143.111.62.revers.nsm.pl ([62.111.143.6]:47765 "HELO
	matthew.ogrody.nsm.pl") by vger.kernel.org with SMTP
	id S932518AbWACUgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 15:36:41 -0500
Date: Tue, 3 Jan 2006 21:37:32 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: Takashi Iwai <tiwai@suse.de>
Cc: Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060103203732.GF5262@irc.pl>
Mail-Followup-To: Takashi Iwai <tiwai@suse.de>,
	Olivier Galibert <galibert@pobox.com>,
	Alistair John Strachan <s0348365@sms.ed.ac.uk>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
	Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
	alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
	sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
	kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
	jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
	zwane@commfireservices.com, zaitcev@yahoo.com,
	linux-kernel@vger.kernel.org
References: <20050726150837.GT3160@stusta.de> <200601031522.06898.s0348365@sms.ed.ac.uk> <20060103160502.GB5262@irc.pl> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <s5h1wzpnjrx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zGQnqpIoxlsbsOfg"
Content-Disposition: inline
In-Reply-To: <s5h1wzpnjrx.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zGQnqpIoxlsbsOfg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2006 at 09:22:58PM +0100, Takashi Iwai wrote:
> At Tue, 3 Jan 2006 18:03:16 +0100,
> Olivier Galibert wrote:
> >=20
> > > This is exactly why the OSS emulation option in ALSA is really a last=
 resort=20
> > > and should not be an excuse for people to ignore implementing ALSA su=
pport=20
> > > directly. More so, it is very good justification for ditching "everyt=
hing=20
> > > OSS" as soon as possible, at least in new software.
> >=20
> > Actually the crappy state of OSS emulation is a good reason to ditch
> > ALSA in its current implementation.  As Linus reminded not so long
> > ago, backwards compatibility is extremely important.
>=20
> Well, we keep the compatibility exactly -- OSS drivers don't support
> software mixing in the kernel, too :)

 OSS will support software mixing. In kernel. On NetBSD.
http://kerneltrap.org/node/4388

--=20
Tomasz Torcz            There exists no separation between gods and men:
zdzichu@irc.-nie.spam-.pl   one blends softly casual into the other.


--zGQnqpIoxlsbsOfg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: gpg --search-keys Tomasz Torcz

iD8DBQFDuuCMThhlKowQALQRArEuAKDZGR44MESsWO2j2dgexAY00l4rOwCg6mmj
ibATWhDjfL4MCZgCXI59rSA=
=RmBW
-----END PGP SIGNATURE-----

--zGQnqpIoxlsbsOfg--
