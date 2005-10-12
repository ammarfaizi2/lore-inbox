Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbVJLQho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbVJLQho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 12:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbVJLQho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 12:37:44 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:33952 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1751460AbVJLQhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 12:37:43 -0400
Date: Wed, 12 Oct 2005 18:37:33 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modalias entries for ccw devices
Message-ID: <20051012163733.GA11334@wavehammer.waldi.eu.org>
Mail-Followup-To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org
References: <20051012141218.GA4039@wavehammer.waldi.eu.org> <1129127818.32420.2.camel@localhost.localdomain> <20051012154844.GA10587@wavehammer.waldi.eu.org> <1129133472.32420.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <1129133472.32420.6.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 12, 2005 at 06:11:12PM +0200, Martin Schwidefsky wrote:
> That is because ctc and lcs are group device drivers. The ccw device
> driver is the cu3088 driver. You'll get an lcs/ctc device by "grouping"
> two of the cu3088 device together.

Okay. But should work anyway.

I implemented it half through, will test that tomorrow.

Bastian

--=20
There are always alternatives.
		-- Spock, "The Galileo Seven", stardate 2822.3

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEARECAAYFAkNNO80ACgkQnw66O/MvCNEEUQCcDCJc8NcpYYNDsqmik1Q0ggpz
bqoAnivuIQQ0LA25TDGfp+Vy5w87tPpg
=SIRs
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
