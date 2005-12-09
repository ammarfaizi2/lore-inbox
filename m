Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbVLIKtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVLIKtU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 05:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbVLIKtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 05:49:20 -0500
Received: from cassiel.sirena.org.uk ([80.68.93.111]:35337 "EHLO
	cassiel.sirena.org.uk") by vger.kernel.org with ESMTP
	id S1750720AbVLIKtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 05:49:19 -0500
Date: Fri, 9 Dec 2005 10:48:33 +0000
From: Mark Brown <broonie@sirena.org.uk>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Tim Hockin <thockin@hockin.org>,
       Harald Welte <laforge@gnumonks.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] natsemi: NAPI support
Message-ID: <20051209104832.GA3677@sirena.org.uk>
Mail-Followup-To: Francois Romieu <romieu@fr.zoreil.com>,
	Jeff Garzik <jgarzik@pobox.com>, Tim Hockin <thockin@hockin.org>,
	Harald Welte <laforge@gnumonks.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20051204224734.GA12962@sirena.org.uk> <20051204231209.GA28949@electric-eye.fr.zoreil.com> <20051205232301.GA4551@sirena.org.uk> <20051206001934.GA18329@electric-eye.fr.zoreil.com> <20051206211729.GB3709@sirena.org.uk> <20051206215619.GB3425@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20051206215619.GB3425@electric-eye.fr.zoreil.com>
X-Cookie: <doogie> dpkg has bugs?  no way!
User-Agent: Mutt/1.5.11
X-Spam-Score: -2.4 (--)
X-Spam-Report: Spam detection software, running on the system "cassiel.sirena.org.uk", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tue, Dec 06, 2005 at 10:56:19PM +0100, Francois 
	Romieu wrote: > netif_rx_schedule_prep return netif_running(dev) && > 
	dev_close clear_bit(__LINK_STATE_START, &dev->state); Oh, of course - 
	thanks for bearing wth me. Will fix that too and resubmit. [...] 
	Content analysis details:   (-2.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.2 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2005 at 10:56:19PM +0100, Francois Romieu wrote:

> netif_rx_schedule_prep return netif_running(dev) &&
> dev_close              clear_bit(__LINK_STATE_START, &dev->state);

Oh, of course - thanks for bearing wth me.  Will fix that too and
resubmit.

--=20
"You grabbed my hand and we fell into it, like a daydream - or a fever."

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ5lg6w2erOLNe+68AQIFjwP/eWx8Hmf+TZDpG49Be7qOCO+5+2GNdy+q
NDG5r4NKd04teLxW1Y+coYE0ap3sByMT/nyB52jiORTKb3/0gaQb8bmkL+9WJvms
SnFfuUhGfLTeWVIWZhFewHzFnafjjHqJTsoE2ImuMaG4fSKB2K8Z/wJTmSa/0Qu1
b5PpT/ETCXo=
=+tvS
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
