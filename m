Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVIRWlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVIRWlf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 18:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVIRWlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 18:41:35 -0400
Received: from h80ad24e0.async.vt.edu ([128.173.36.224]:40581 "EHLO
	h80ad24e0.async.vt.edu") by vger.kernel.org with ESMTP
	id S932241AbVIRWlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 18:41:35 -0400
Message-Id: <200509182241.j8IMfPMf007285@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Grzegorz Piotr Jaskiewicz <gj@kdemail.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dell's latitude cdburner problem 
In-Reply-To: Your message of "Sun, 18 Sep 2005 22:57:21 +0200."
             <200509182257.23363@gj-laptop> 
From: Valdis.Kletnieks@vt.edu
References: <200509182257.23363@gj-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1127083284_2682P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 18 Sep 2005 18:41:24 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1127083284_2682P
Content-Type: text/plain; charset=us-ascii

On Sun, 18 Sep 2005 22:57:21 +0200, Grzegorz Piotr Jaskiewicz said:
> Hi folks
> 
> I don't know whether this is linuxes cdrecord issue, or kernel issue.
> I have dell latitude c640 laptop with their's dvd/cd-rw combo drive that 
> appears as:
> hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache

For what it's worth, my Dell Latitude C840 reports this:

 hdb: TOSHIBA CD-RW/DVD-ROM SD-R2102, ATAPI CD/DVD-ROM drive
 hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)

So it's quite likely the same part.  Careful reading of the specs shows
that it's rated for 24x *reading*, but only 8X *writing*.  Are you *sure*
that it *actually* manages 24X writing under Windows? (Does burning a 72-minute
or 700M image take about 9 minutes (8X), or does it finish in about 3 minutes
(24X))?

--==_Exmh_1127083284_2682P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFDLe0UcC3lWbTT17ARAgYMAKCCxEdmgyd31VqJyhG/ufAZoAz0sgCfTn1g
IAZTlDkTBRsJICyqVQpboGo=
=9X0v
-----END PGP SIGNATURE-----

--==_Exmh_1127083284_2682P--
