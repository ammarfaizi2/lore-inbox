Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbUK3OkC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbUK3OkC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 09:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbUK3OkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 09:40:01 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:6027 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S262092AbUK3Ojc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 09:39:32 -0500
From: Mws <mws@twisted-brains.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Looking for a single patch file for the ITE8212 kernel 2.6.10-rc2
Date: Tue, 30 Nov 2004 15:37:52 +0100
User-Agent: KMail/1.7.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200411291910.53740.mws@twisted-brains.org> <1101816038.25603.17.camel@localhost.localdomain>
In-Reply-To: <1101816038.25603.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2451011.KgjqncJRTZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411301537.59697.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2451011.KgjqncJRTZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,=20

thanks for your response Alan,

what i did now is i patched a 2.6.9 version to -ac.

IT8212 is working properly and has found my attached harddisk.

unfortunately i got the next problem :)

my s-ata drives connected to the Intel 925X (ICH6R) are not detected correc=
tly with 2.6.9

solution for now - backup data on IT8212 drive - reboot 2.6.10-rc2 and wait=
 for your proper
patch when 2.6.10 is released.=20

another question=20
my Asus P5AD2 Premium has got 2 OnBoard Marvell Gigabit chipsets.=20
I got a driver package from syskonnect directly - which is working also wit=
h 2.6.9/10-rcX.
sysconnect told me that they sended the drivers/patch to the kernel-ml.
does somebody know when it will be merged to the repository?

regards
marcel


On Tuesday 30 November 2004 13:00, Alan Cox wrote:
> On Llu, 2004-11-29 at 18:10, Mws wrote:
> > hi,
> >=20
> > does somebody, or you alan, have a single patch to support the ite8212 =
ide chip?
> > i now that it is contained in the latest ac patch - but that is against=
 kernel 2.6.9
>=20
> The IT8212 driver depends on other -ac IDE changes. There was an earlier
> version that didn't but that has some other bugs and since Bartlomiej
> rejected it I've no interest in maintaining that version.
>=20
> I'm afraid you'll need the -ac patches to use the IT8212. That isn't how
> I wanted it either. Once 2.6.10 is out I'll maybe do a 2.6.10-ac. Right
> now however both the released 10rc trees crashed or hung on boot on my
> test boxes and I've not got the time to mess with random -bk snapshots.
>=20
> Alan
>=20

--nextPart2451011.KgjqncJRTZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBrIXHPpA+SyJsko8RAtzTAKCCFfLKiVYMDRADygehcaFGTV0ZUgCcDUL/
BUQXA0TkOOce4dkz7Zoorbg=
=7uNj
-----END PGP SIGNATURE-----

--nextPart2451011.KgjqncJRTZ--
