Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbTL2Ra2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 12:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTL2Ra2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 12:30:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30682 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263810AbTL2RaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 12:30:20 -0500
Date: Mon, 29 Dec 2003 18:30:12 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: Nicklas Bondesson <nicke@nicke.nu>
Cc: "'Christophe Saout'" <christophe@saout.de>, linux-kernel@vger.kernel.org
Subject: Re: ataraid in 2.6.?
Message-ID: <20031229173012.GB21479@devserv.devel.redhat.com>
References: <1072717701.5152.123.camel@leto.cs.pocnet.net> <200312291727.hBTHRDA13745@mx1.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <200312291727.hBTHRDA13745@mx1.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2003 at 06:27:08PM +0100, Nicklas Bondesson wrote:
> How do you set this (device mapping) up using the 2.6 kernel. I like the
> ease of using ataraid in 2.4.x. Why not have both alternatives as options
> (both ataraid and devicemapper)?

because ataraid is nothing more than a devicemapper....
duplicating that is rather silly...=20
The outcome is to be a /sbin/ataraid binary or some such that will do all
the magic to detect the raid and tell the kernel device mapper to set it all
up.

> Also have anyone of you looked at the patch
> from Walt H that he sent in yesterday? I have to use this after replacing=
 my
> old hard drives (Maxtor 30GB) with WDC 80GB. The patch is attached.=20

I sent it to Marcelo for applying last week, and he applied it today

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/8GSjxULwo51rQBIRAsD6AJ99OWdMUxG1zcGAVn6wS1G27qeJCgCgmxFL
AcoJ0I/hSD7eWpAoRoOhFDQ=
=gdFE
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
