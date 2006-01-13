Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422802AbWAMSZo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422802AbWAMSZo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 13:25:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422803AbWAMSZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 13:25:44 -0500
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:15812 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1422802AbWAMSZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 13:25:43 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch 00/62] sem2mutex: -V1
Date: Fri, 13 Jan 2006 19:25:22 +0100
User-Agent: KMail/1.7.2
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Greg KH <greg@kroah.com>
References: <20060113124402.GA7351@elte.hu> <200601131400.00279.baldrick@free.fr> <20060113134412.GA20339@elte.hu>
In-Reply-To: <20060113134412.GA20339@elte.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1567319.rGOSAX6T4g";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601131925.34971.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1567319.rGOSAX6T4g
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi there,

On Friday 13 January 2006 14:44, Ingo Molnar wrote:
>     - it should stay a semaphore (if it's a genuine counting=20
>       semaphore)
>=20
>     - or it should get converted to a completion (if it's used as
>       a completion)
>=20
>     - or it should get converted to struct work (if it's used as a=20
>       workflow synchronizer).

Could we get for each of these and a mutex:

 - description=20
 - common use case
 - small argument why this and nothing else should be used there

This would help driver writers a lot deciding what to use when, I think.

PS: After reading the Linux Kernel one could write a PhD thesis
    just containing explanations, examples and measurements
    of sychronization primitives, since Linux implements at least=20
    most of them AFAIK :-)


Thanks & Regards

Ingo Oeser


--nextPart1567319.rGOSAX6T4g
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDx/CeU56oYWuOrkARAvVWAKDHzIzqE75rypTvRycxCuWmtEm06wCfUoXC
XnYHFdixISMk2M4laoKdgfU=
=nO6r
-----END PGP SIGNATURE-----

--nextPart1567319.rGOSAX6T4g--
