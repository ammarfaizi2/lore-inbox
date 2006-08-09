Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965108AbWHIIzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965108AbWHIIzd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 04:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWHIIzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 04:55:33 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:52113 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965108AbWHIIzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 04:55:32 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG?] possible recursive locking detected (blkdev_open)
Date: Wed, 9 Aug 2006 10:58:36 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200608090757.32006.eike-kernel@sf-tec.de> <20060809013034.ac15526a.akpm@osdl.org>
In-Reply-To: <20060809013034.ac15526a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1427318.iu2EpPSxUZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608091058.41578.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1427318.iu2EpPSxUZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Andrew Morton wrote:
> On Wed, 9 Aug 2006 07:57:31 +0200
>
> Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > =============================================
> > [ INFO: possible recursive locking detected ]
> > ---------------------------------------------
> > parted/7929 is trying to acquire lock:
> >  (&bdev->bd_mutex){--..}, at: [<c105eb8d>] __blkdev_put+0x1e/0x13c
> >
> > but task is already holding lock:
> >  (&bdev->bd_mutex){--..}, at: [<c105eec6>] do_open+0x72/0x3a8

> kernel version?

compiled from git 2006-08-03 16:02 (+0200), it's -rc3 and a bit.

Eike

--nextPart1427318.iu2EpPSxUZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBE2aPBXKSJPmm5/E4RAhrsAJ9ZrFTkVUn4bEwrCPZHIu9vCGMhawCfRK4i
67E7nzxsJ3r0FaFEDCbsrjc=
=sXms
-----END PGP SIGNATURE-----

--nextPart1427318.iu2EpPSxUZ--
