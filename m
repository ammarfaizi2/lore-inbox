Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbTKGXnK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 18:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261831AbTKGWRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:17:13 -0500
Received: from D70f8.d.pppool.de ([80.184.112.248]:8900 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S264013AbTKGJum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:50:42 -0500
Subject: Re: Re:No backlight control on PowerBook G4
From: Daniel Egger <degger@fhm.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Dustin Lang <dalang@cs.ubc.ca>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1068078504.692.175.camel@gaston>
References: <Pine.GSO.4.53.0311021038450.3818@columbia.cs.ubc.ca>
	 <1067820334.692.38.camel@gaston>  <1067878624.7695.15.camel@sonja>
	 <1067896476.692.36.camel@gaston>  <1067976347.945.4.camel@sonja>
	 <1068078504.692.175.camel@gaston>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ENmX2TPyqRCdy5miGIn8"
Message-Id: <1068198639.796.109.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 07 Nov 2003 10:50:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ENmX2TPyqRCdy5miGIn8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Don, den 06.11.2003 schrieb Benjamin Herrenschmidt um 01:28:

> No, I told you to use _my_ 2.6 tree which contains a new radeonfb
> that have not yet been merged upstream.

Still cannot try this because your kernel wouldn't even survive yaboot.

> > BTW: It took me quite a while to figure out that the only working image
> > with yaboot was the zImage.chrp. The normal vmlinux doesn't contain a
> > valid ELF signature (according to yaboot) and the seemingly obvious
> > vmlinux.elf-pmac goes boom while trying to decompress the kernel.

> Ugh ?

> Yaboot normally loads a plain vmlinux, though if you are using tftp, you
> need to modify yaboot to be able to d/l more than 4Mb (edit fs_of.c and
> change the allocated size). The ELF image should work, at least the
> one produced by my tree does, it's possible that there's a similar size
> problem with the one in Linus tree, a few of those recent changes haven't
> yet made it to Linus.

With your tree I now have the problem that it doesn't even boot anymore.
The CHRP kernel which worked before stopped after "CHRP kernel
loader...", the elf-pmac one still crashes with:
Elf32 kernel loaded...
chrpboot starting: loaded at 0x01000000
heap at 0x00003000
gunzipping (0x00010000 <- 0x01006cf8:0x01155486)...
Decrementer exception at %SRR0: 01005804   %SRR1: 00003030
 ok
0 >

--=20
Servus,
       Daniel

--=-ENmX2TPyqRCdy5miGIn8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/q2rvchlzsq9KoIYRAuQmAJ9xNtoBd09Vjquf3nG9+uKOKDJnZwCgyCj2
YFL+lZiLKNtGk0bM3fPwqL0=
=hy31
-----END PGP SIGNATURE-----

--=-ENmX2TPyqRCdy5miGIn8--

