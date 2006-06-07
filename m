Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWFGD7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWFGD7m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 23:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWFGD7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 23:59:42 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:9424 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1750814AbWFGD7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 23:59:42 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: linux-kernel@vger.kernel.org
Subject: Re: klibc (was: 2.6.18 -mm merge plans)
Date: Wed, 7 Jun 2006 14:00:45 +1000
User-Agent: KMail/1.9.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@osdl.org>
References: <20060604135011.decdc7c9.akpm@osdl.org> <20060606152041.GA5427@ucw.cz> <200606062256.55472.rjw@sisk.pl>
In-Reply-To: <200606062256.55472.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1195197.FDLuLsZJrn";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200606071400.49980.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1195197.FDLuLsZJrn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

Sorry for coming in late. I've only just resubscribed after my move.

Not sure who originally said this...

> > > problems it entails.)  The initial code to have removed
> > > is the root-mounting code, with all the various ugly
> > > mutations of that (ramdisk loading, NFS root, initrd...)

Could I get more explanation of what this means and its implications? I'm=20
thinking in particular about the implications for suspending to disk. Will =
it=20
imply that everyone will _have_ to have an initramfs with some userspace=20
program that sets up device nodes and so on, even if at the moment all you=
=20
have is root=3D/dev/hda1 resume2=3Dswap:/dev/hda2?

Along similar lines, I had been considering eventually including support fo=
r=20
putting an image in place of the initrd (for embedded).

Regards,

Nigel

--nextPart1195197.FDLuLsZJrn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEhk9xN0y+n1M3mo0RAuExAKCLOqaAKVjGsu+C7KHpqNQITFg8GwCgzuOr
A5ov7lN5IOhk0vHhYG+4J+A=
=6ckG
-----END PGP SIGNATURE-----

--nextPart1195197.FDLuLsZJrn--
