Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264732AbTE1N03 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 09:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264733AbTE1N03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 09:26:29 -0400
Received: from iucha.net ([209.98.146.184]:58444 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id S264732AbTE1N0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 09:26:25 -0400
Date: Wed, 28 May 2003 08:39:40 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: ALSA problems: sound lockup, modules, 2.5.70
Message-ID: <20030528133940.GT3359@iucha.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <170EBA504C3AD511A3FE00508BB89A92021C90DC@exnanycmbx4.ipc.com> <1054128212.614.7.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WN2ELtqJJ9aZ3yHj"
Content-Disposition: inline
In-Reply-To: <1054128212.614.7.camel@chevrolet.hybel>
X-message-flag: Microsoft: Where do you want to go today? Nevermind, you are coming with us!
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.4i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WN2ELtqJJ9aZ3yHj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2003 at 03:23:32PM +0200, Stian Jordet wrote:
> > > This did not fix my problem. When I unload one ALSA-modules after the
> > > other, the system hangs when I come to the "snd" module. No oops or
> > > panic, it just freezes. Other than that, ALSA works fine for me, just
> > > frustrating when I reboot.
> > >
> > > Best regards,
> > > Stian
> >=20
> > For what it's worth, maybe as a point to start to look for differences.=
=2E.
> >=20
> > I am running 2.5.70-mm1, with snd-intel8x0 module.  Also SMP on Xeon P4
> > (2up), Intel chipset.  I am not having any problems with unloading snd.
> >=20
> > So maybe the difference is between -mm1 and (IIRC) -bk1.
>=20
> Hmm. I will try -mm1 later today, but my problems started with
> 2.5.68-bk18 (IIRC). This is also a SMP-system, Dual P3 (But VIA
> chipset): But it's a pity you don't see the problem. I was hoping
> everyone had it :) Well, I'll try to insert some printk's and stuff, and
> see what happens. And try -mm1

Try -bk2: it contains Al Viro's second fix.

florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--WN2ELtqJJ9aZ3yHj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+1LwcNLPgdTuQ3+QRAnwvAJ9hG9WNk2wm5KmXIo2v1xFBZmEGaQCfSmJd
QcaznR8KweCtcSkIIUvfz/Q=
=HznY
-----END PGP SIGNATURE-----

--WN2ELtqJJ9aZ3yHj--
