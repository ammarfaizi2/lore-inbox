Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbVJMLDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbVJMLDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 07:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbVJMLDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 07:03:41 -0400
Received: from wavehammer.waldi.eu.org ([82.139.196.55]:34995 "EHLO
	wavehammer.waldi.eu.org") by vger.kernel.org with ESMTP
	id S1750896AbVJMLDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 07:03:41 -0400
Date: Thu, 13 Oct 2005 13:03:34 +0200
From: Bastian Blank <bastian@waldi.eu.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc4-git] s390, ccw - export modalias
Message-ID: <20051013110334.GD15805@wavehammer.waldi.eu.org>
Mail-Followup-To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-kernel@vger.kernel.org
References: <20051012192639.GA25481@wavehammer.waldi.eu.org> <20051012125939.6ee58910.akpm@osdl.org> <1129194579.5305.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <1129194579.5305.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 13, 2005 at 11:09:38AM +0200, Martin Schwidefsky wrote:
> The wanted to have some information for use by udev. After looking at
> the patch I wonder why they can't use the cutype/devtype attributes.

But anyway, one part is missing: The same string needs to be put in the
environment for hotplug as MODALIAS. And the n/a should be put as
dt0000dm00 in the string.

Bastian

--=20
There are always alternatives.
		-- Spock, "The Galileo Seven", stardate 2822.3

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iEYEARECAAYFAkNOPwYACgkQnw66O/MvCNFEbACbBuki2kjPDEmxRuSdllWEIarH
3G0AnRHjzyu/TBi/j7nK98zQ0ZxwEza6
=gRrD
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
