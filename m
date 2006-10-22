Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWJVU27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWJVU27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 16:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWJVU27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 16:28:59 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:59580 "EHLO
	mail-in-10.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751254AbWJVU25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 16:28:57 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [Alsa-devel] [RFC: 2.6.19 patch] snd-hda-intel: default MSI to off
Date: Sun, 22 Oct 2006 22:29:13 +0200
User-Agent: KMail/1.9.5
Cc: Stephen Hemminger <shemminger@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, hnguyen@de.ibm.com, perex@suse.cz
References: <200610050938.10997.prakash@punnoor.de> <s5h64eh5yzx.wl%tiwai@suse.de> <s5h3b9l5ykv.wl%tiwai@suse.de>
In-Reply-To: <s5h3b9l5ykv.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1173569.TBC4RBGXb1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610222229.16927.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1173569.TBC4RBGXb1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch 18 Oktober 2006 19:21 schrieb Takashi Iwai:

> > Yes, it would be better to check the value and reset chip->msi if
> > not successful.  But it's not a fatal error, so the current code
> > should work.
>
> The below is the revised patch.

I tried it and it works fine for me now (with the driver not using msi=20
automatically now).

Cheers,
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart1173569.TBC4RBGXb1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFO9ScxU2n/+9+t5gRAht5AJ0UIWGeVlvwZ7GUY0NVshGQYoM/xgCeLyav
Pmnn44/yLpCz3Hrxee91CsM=
=i6rR
-----END PGP SIGNATURE-----

--nextPart1173569.TBC4RBGXb1--
