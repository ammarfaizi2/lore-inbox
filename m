Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUHWUbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUHWUbu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267772AbUHWUZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:25:32 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:61137 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S266883AbUHWTkx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 15:40:53 -0400
Subject: Re: [RFC][PATCH] inotify 0.8.1 [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       nautilus-list@gnome.org, gamin-list@gnome.org, rml@ximian.com,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1092889961.31314.3.camel@vertex>
References: <1092889961.31314.3.camel@vertex>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jDT5xEv71dxykyt40efr"
Message-Id: <1093290259.9495.18.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 21:44:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jDT5xEv71dxykyt40efr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-08-19 at 06:32, John McCutchan wrote:

Hi

> I am resubmitting inotify for comments and review. Inotify has
> changed drastically from the earlier proposal that Al Viro did not
> approve of. There is no longer any use of (device number, inode number)
> pairs. Please give this version of inotify a fresh view.
>=20

I applied this to 2.6.8.1 and most of -mm4's patches - it applied
cleanly and compiled fine.

I use devicemapper to stripe two 80gb sata drives on intel sata
controller, using initramfs.

Now when I boot, I see something like:

---
BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
Freeing unused kernel memory: 264k freed
inotify device opened
dm ioctl error or such
---

Which then results in a panic as the dm volumes cannot be setup
and no / found by kernel.  So basically it seems like inotify
mess with dm in some way or other - any quick ideas what it
could be?

I do not have serial console, so if you need a more complete log,
just let me know from where abouts I should start, and if any
debugging should be turned on, etc.


Thanks,

--=20
Martin Schlemmer

--=-jDT5xEv71dxykyt40efr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBKkkTqburzKaJYLYRAi8QAJ0dYykbSwRJxt0y//AE3PCSO0MKDQCfRgdg
m9m1vuYK9xbMdY2iTRKYPA8=
=2a+9
-----END PGP SIGNATURE-----

--=-jDT5xEv71dxykyt40efr--

