Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751353AbWCWJJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWCWJJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 04:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWCWJJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 04:09:58 -0500
Received: from mail11.syd.optusnet.com.au ([211.29.132.192]:62599 "EHLO
	mail11.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751353AbWCWJJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 04:09:57 -0500
References: <20060322205305.0604f49b.akpm@osdl.org> <200603231804.36334.kernel@kolivas.org> <200603230901.57052.jos@mijnkamer.nl> <44225AB4.4080503@yahoo.com.au>
Message-ID: <cone.1143104983.983347.31285.501@kolivas.org>
X-Mailer: http://www.courier-mta.org/cone/
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: jos poortvliet <jos@mijnkamer.nl>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [ck] swap prefetching merge plans
Date: Thu, 23 Mar 2006 20:09:43 +1100
Mime-Version: 1.0
Content-Type: multipart/signed;
    boundary="=_mimegpg-kolivas.org-31285-1143104983-0002";
    micalg=pgp-sha1; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME GnuPG-signed message.  If you see this text, it means that
your E-mail or Usenet software does not support MIME signed messages.

--=_mimegpg-kolivas.org-31285-1143104983-0002
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Nick Piggin writes:

> Secondly, with or without swap prefetch, I think we can do a better job of
> handling these use-once patterns to begin with.

Absolutely! But there will always be workloads that cause appropriate 
use-once swapping. Qemu, games, big print jobs, big open documents, big 
graphic edits and so on.

Cheers,
Con


--=_mimegpg-kolivas.org-31285-1143104983-0002
Content-Type: application/pgp-signature
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBEImXYZUg7+tp6mRURAh9aAKCQa4j5oBqYukFolM+USSPlAfyOIgCgiC3d
c3aCl4Z6KNkQQ9ujAhIKz+M=
=z08J
-----END PGP SIGNATURE-----

--=_mimegpg-kolivas.org-31285-1143104983-0002--
