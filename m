Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWCMF0Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWCMF0Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 00:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWCMF0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 00:26:25 -0500
Received: from b3162.static.pacific.net.au ([203.143.238.98]:60581 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S932302AbWCMF0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 00:26:24 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Subject: Re: S3 sleep regression / 2.6.16-rc1+acpi-release-20060113
Date: Mon, 13 Mar 2006 15:23:55 +1000
User-Agent: KMail/1.9.1
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <E1F5UPr-0008FN-00@skye.ra.phy.cam.ac.uk>
In-Reply-To: <E1F5UPr-0008FN-00@skye.ra.phy.cam.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2595158.1OvIRZuyx7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200603131524.00992.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2595158.1OvIRZuyx7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Bernard.

On Sunday 05 February 2006 06:53, Sanjoy Mahajan wrote:
> > After the first suspend, do you have any processes sucking all
> > available cpu? This sounds like a thread that has been added since
> > 2.6.15, which is being told to enter the freezer, but isn't doing
> > it. They usually end up sucking cpu afterwards.
>
> A good thought.  I just tried it again.  The system woke up from the
> first S3 sleep with nothing chewing CPU.  Just as a check, the second
> S3 sleep still hangs with the repeating exregion-* messages.
>
> I also tried vanilla 2.6.16-rc2 (which includes the latest ACPICA
> releases in it), and it has the same problem.

I think this is your department :)

Nigel

--nextPart2595158.1OvIRZuyx7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEFQHwN0y+n1M3mo0RAkuDAJ4pAw8tbREpmMEsP43CVkmR/BtAMwCfXJ9e
jqeMyXaI7y3syJa9S5xJIlc=
=xHHK
-----END PGP SIGNATURE-----

--nextPart2595158.1OvIRZuyx7--
