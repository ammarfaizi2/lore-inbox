Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbVHRQNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbVHRQNF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVHRQNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:13:05 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:40588 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S932278AbVHRQNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:13:04 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Guillermo =?iso-8859-1?q?L=F3pez_Alejos?= <glalejos@gmail.com>
Subject: Re: Environment variables inside the kernel?
Date: Thu, 18 Aug 2005 18:12:27 +0200
User-Agent: KMail/1.7.2
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
References: <4fec73ca050818084467f04c31@mail.gmail.com>
In-Reply-To: <4fec73ca050818084467f04c31@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1252022.rtJgvbK4nt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508181812.36086.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1252022.rtJgvbK4nt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Guillermo,

On Thursday 18 August 2005 17:44, Guillermo L=F3pez Alejos wrote:
> I have a piece of code which uses environment variables. I have been
> told that it is not going to work in kernel space because the concept
> of environment is not applicable inside the kernel.
>=20
> I belive that, but I need to demonstrate it. I do not know how to
> proof this, perhaps referring to a solid reference about Linux design
> that points to the idea that it has no sense to use environment
> variables in kernel space.

The Linux kernel is technically one big process with lots of threads.

An environment variable is per process and is usally to be threated
read only within it.

Also the Linux kernel is the first "process" ever.=20
Who should set up it's environment variables?

That's why there are none.

These arguments are no real proof in a mathematical sense,
but should help you argumenting.


Regards

Ingo Oeser


--nextPart1252022.rtJgvbK4nt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDBLN0U56oYWuOrkARAkoKAJ48GNBuvRO9YiMWvcSubBni+wEHDACgxqhw
AJKYy6vGV9aqmbUnZLBGVVg=
=ugLQ
-----END PGP SIGNATURE-----

--nextPart1252022.rtJgvbK4nt--
