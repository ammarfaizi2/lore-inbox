Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965135AbWGFCSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965135AbWGFCSm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 22:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbWGFCSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 22:18:42 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:50402 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S965135AbWGFCSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 22:18:41 -0400
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [klibc 30/31] Remove in-kernel resume-from-disk invocation code
Date: Thu, 6 Jul 2006 12:18:35 +1000
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, klibc@zytor.com
References: <klibc.200606272217.00@tazenda.hos.anvin.org> <44AC5F5C.7070907@zytor.com> <200607061145.08590.ncunningham@linuxmail.org>
In-Reply-To: <200607061145.08590.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3780019.irYgnIPQ7Y";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607061218.39202.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3780019.irYgnIPQ7Y
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi again.

(Excuse me replying to myself, but this might help someone else).

On Thursday 06 July 2006 11:45, Nigel Cunningham wrote:
> Is there a klibc howto somewhere? I tried googling for 'klibc howto',
> reading the files in Documentation/ and browsing your klibc mailing list
> archive before asking!

> What I'm wondering specifically is: Say a user needs to run some commands
> to set up access to encrypted storage before they can resume. At the
> moment, we'd tell them to put these commands and the echo > do_resume in
> their linuxrc (or init) script prior to mounting their root filesystem.
> Forgive me if I'm asking a stupid question but it's not immediately obvio=
us
> to me how they would now do that. I'd much rather follow a simple howto
> than spend a good amount of time tracing function calls etc. I still see
> init/initramfs.c, and it mentions both CONFIG_BLK_DEV_INITRD and
> CONFIG_BLK_DEV_RAM. Would I be right in surmising that you can still have
> an initrd or ramfs to do such things as the above, after klibc has done i=
ts
> work? If not, is there some other way I'm ignorant of?

=46or the record, I've since discovered that what you really want is an=20
initramfs howto. I think I stuck with those old-fangled initrds for too lon=
g.=20
Better update my desktop from Mandrake 10 too :)... is there a pattern here?

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart3780019.irYgnIPQ7Y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBErHL/N0y+n1M3mo0RAmTYAJ9RGIs5bgldYxEtCVtlGMWDCJrmsgCfRuF0
PCww3xoMu7p72OrjNrDimOE=
=Sh6q
-----END PGP SIGNATURE-----

--nextPart3780019.irYgnIPQ7Y--
