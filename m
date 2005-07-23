Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVGWV2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVGWV2y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 17:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVGWV2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 17:28:54 -0400
Received: from main.gmane.org ([80.91.229.2]:3563 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261874AbVGWV2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 17:28:53 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: [cpufreq] ondemand works, conservative doesn't
Date: Sat, 23 Jul 2005 23:25:04 +0200
Message-ID: <dbucpq$7ti$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8447C7DC0D9E309E12E97E5F"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-082-083-000-189.arcor-ip.net
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: de-DE, de, en-us, en
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8447C7DC0D9E309E12E97E5F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

currently, i'm using the ondemand governor. My CPU supports the
frequencies 800, 1800 and 2000 MHz (AMD Athlon64 Desktop with
Cool&Quiet). The simple bash commands

  while true
  do
    true
  done

cause 100% CPU usage, and the CPU immediatly switched from 800 to 2000MHz.

Using the conservative govenor, nothing happens. I would expect, that
the cpu switches to 1800 and than to 2000 Mhz after some seconds of full
CPU usage.

What's wrong?

My guess is, that the conservative govenor would need more frequencies
between 800 and 1800MHz to work properly.

Thx
  Sven

--------------enig8447C7DC0D9E309E12E97E5F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Cygwin)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC4rWw7Ww7FjRBE4ARAt8iAKCS2iWLPO4aMZSAm8kPvUkoAP0ImwCgmGrs
j5gjKUgJS6kB0/O8C/8uKy8=
=lArX
-----END PGP SIGNATURE-----

--------------enig8447C7DC0D9E309E12E97E5F--

