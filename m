Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWC3Qw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWC3Qw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 11:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWC3Qw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 11:52:28 -0500
Received: from node8.mtu.edu ([141.219.69.8]:17571 "EHLO node8.mtu.edu")
	by vger.kernel.org with ESMTP id S1751171AbWC3Qw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 11:52:28 -0500
Date: Thu, 30 Mar 2006 11:52:25 -0500
From: Jon DeVree <jadevree@mtu.edu>
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: How to determine the start of DATA segment
Message-ID: <20060330165225.GA24074@tesla.setec>
References: <728201270603300837g60eefb65u8b55df910b86f6c4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
In-Reply-To: <728201270603300837g60eefb65u8b55df910b86f6c4@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.3.0.1, Antispam-Data: 2006.03.30.083108
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CD 0, __CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, __HAS_MSGID 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 30, 2006 at 10:37:25AM -0600, Ram Gupta wrote:
> Is there a system call or library function which a process can use to
> determine the start of its data segment . I need to know the start of
> the data segment so that process does not cross its DATA limit. Using
> this information & sbrk it knows how much data space is already used &
> how much it can grow further without crossing the limit.

I think getrlimit() might be what you are looking for.
--=20
Jon
"RISC architecture is gonna change everything." -Kate Libby

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFELAzJ4m3oE/xVNJ4RAp3hAJ4lZJagbsHrH0dSAYMrbbBpFRp3lgCfSMT4
yI5zAjUCcQPHktDBRpPkcfc=
=nREz
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
