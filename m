Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbTK3K46 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 05:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264891AbTK3K45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 05:56:57 -0500
Received: from smtprelay01.ispgateway.de ([62.67.200.156]:14029 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S264889AbTK3K44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 05:56:56 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [JBD] Handle j_commit_interval == 0
Date: Sun, 30 Nov 2003 10:50:50 +0100
User-Agent: KMail/1.5.4
References: <20031129092458.GA19338@gondor.apana.org.au>
In-Reply-To: <20031129092458.GA19338@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311301050.53283.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Herbert,

On Saturday 29 November 2003 10:24, Herbert Xu wrote:
> After the laptop mode patch was merged, it is now possible for
> j_commit_interval to be zero.  Unfortunately jbd doesn't handle
> this situation very well.
>
> This patch makes it do the sensible thing.

What about abstracting these away in "set_journal_expire" and
"is_journal_expired"?

Otherwise this will surely be missed in the future.

Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/yb16U56oYWuOrkARAqqVAKCrTi/s2wzeUVQnKeOSv4rIWi+HawCgzdJZ
RboSmYzfo2uK9Sygpksmatc=
=nLqv
-----END PGP SIGNATURE-----

