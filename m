Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWJFL0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWJFL0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWJFL0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:26:16 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:35518 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750830AbWJFL0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:26:15 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] 2.6.19-rc1: hda_intel: azx_get_response timeout, switching to polling mode...
Date: Fri, 6 Oct 2006 13:26:06 +0200
User-Agent: KMail/1.9.4
Cc: alsa-devel@alsa-project.org, Linux List <linux-kernel@vger.kernel.org>
References: <200610050954.57677.prakash@punnoor.de> <200610052311.35446.prakash@punnoor.de> <s5hejtlu2wv.wl%tiwai@suse.de>
In-Reply-To: <s5hejtlu2wv.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2232465.9et51qUiE3";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610061326.07161.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2232465.9et51qUiE3
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag 06 Oktober 2006 12:58 schrieb Takashi Iwai:
> At Thu, 5 Oct 2006 23:11:35 +0200,
>
> Prakash Punnoor wrote:
> > Am Donnerstag 05 Oktober 2006 12:18 schrieb Takashi Iwai:
> > > At Thu, 5 Oct 2006 09:54:57 +0200,
> > >
> > > Prakash Punnoor wrote:
> > > > I didn't get above message with 2.6.18. Usign irqpoll above message
> > > > doesn't appear, but I think neither it optimal.
> > >
> > > The latest snd-hda-intel driver uses MSI as default.
> > > Pass disable_msi=3D1 module option and see whether it works.
> >
> > Yes, no more message, but what is even better: My nforce nic works again
> > (w/o using irqpoll)! So the alsa driver broke it. Now both are using sa=
me
> > irq and peaceful again.
>
> It's more likely a problem of IRQ routing than the driver itself...

Well, whom should I contact then?
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2232465.9et51qUiE3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFJj1PxU2n/+9+t5gRAtz9AKCxBb5p35OP8Bq70cpbfvfStZdmTQCgwK3I
6nkjJMRyLu10S5VW9NvHthk=
=ve8/
-----END PGP SIGNATURE-----

--nextPart2232465.9et51qUiE3--
