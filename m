Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266195AbUGARYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266195AbUGARYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 13:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUGARYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 13:24:38 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:53936 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S266195AbUGARYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 13:24:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: watchdog infrastructure
Date: Thu, 1 Jul 2004 19:23:44 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_hiE5ARMP182WAso";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407011923.45226.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_hiE5ARMP182WAso
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Wim,

I noticed you have been working on sanitizing the watchdog driver
in your http://linux-watchdog.bkbits.net/linux-2.6-watchdog-experimental
tree. What are your plans for this, i.e. do you see this as 2.7 only
stuff or do you intend to merge the at least the infrastructure code
so it can be used by future 2.6 drivers?

I'm asking because I have a new driver and I would prefer not to add
yet another copy of the ioctl code, which I don't even know how
to test properly.

If we can get your watchdog.c into a mergable state (in which it
arguably isn't at the moment), I could use that to base my driver
on, while the other drivers get converted during 2.7.

	Arnd <><

--Boundary-02=_hiE5ARMP182WAso
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA5Eih5t5GS2LDRf4RAi2zAJ0bjR7refdoUlOCkbwsBqJ1KSgKVgCfRrPE
NJ8kVWShnc95HXjIa65oLts=
=u2XY
-----END PGP SIGNATURE-----

--Boundary-02=_hiE5ARMP182WAso--
