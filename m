Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262328AbUF3UKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUF3UKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 16:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUF3UI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 16:08:56 -0400
Received: from mout2.freenet.de ([194.97.50.155]:37538 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S262213AbUF3UIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 16:08:06 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Kevin Corry <kevcorry@us.ibm.com>
Subject: Re: [PATCH] 4/4: DM: dm-raid1.c: Use fixed-size arrays
Date: Wed, 30 Jun 2004 22:07:53 +0200
User-Agent: KMail/1.6.2
References: <200406301452.16886.kevcorry@us.ibm.com> <200406301458.46109.kevcorry@us.ibm.com>
In-Reply-To: <200406301458.46109.kevcorry@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406302207.56348.mbuesch@freenet.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Kevin Corry <kevcorry@us.ibm.com>:
> -	struct io_region from, to[ms->nr_mirrors - 1], *dest;

Heh? Could someone please explain how this could compile?
Dynamic allocation on the stack? I'm confused.

- --
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4x2ZFGK1OIvVOP4RAnH3AKDhNlOgKWvx/GqWVROutfqEUpnc1QCbBz1j
koxiQ/7WtV/QOocbgYTHi4E=
=7Ch5
-----END PGP SIGNATURE-----
