Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVBMVlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVBMVlt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 16:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261314AbVBMVlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 16:41:49 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:26379 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261306AbVBMVlr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 16:41:47 -0500
Date: Sun, 13 Feb 2005 22:41:45 +0100
From: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.cx>
To: linux-kernel@vger.kernel.org
Subject: RTC Inappropriate ioctl for device
Message-ID: <20050213214145.GN12421@roxor.cx>
Reply-To: =?iso-8859-1?B?QXVy6WxpZW4gR8lS1E1F?= <ag@roxor.cx>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi,

Having CONFIG_RTC=y, I tried on x86 the rtctest program found in
linux-2.6.10/Documentation/rtc.txt. However, it failed at:

ioctl(fd, RTC_UIE_ON, 0);

with:

ioctl: Inappropriate ioctl for device

Did I miss something? Maybe something else conflicts with CONFIG_RTC?

Cheers.

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCD8mZI2xgxmW0sWIRAoxSAJ9Ynumfs5rXGgrDY2RKcarJCze4swCgwrNg
cKHA8SGucp7NSmQOE4QI9r0=
=w4sO
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--
