Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUGHMH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUGHMH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 08:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265224AbUGHMH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 08:07:29 -0400
Received: from mout1.freenet.de ([194.97.50.132]:41661 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S265214AbUGHMH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 08:07:27 -0400
From: Michael Buesch <mbuesch@freenet.de>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Date: Thu, 8 Jul 2004 14:06:22 +0200
User-Agent: KMail/1.6.2
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <200407081328.40545.mbuesch@freenet.de> <20040708134459.6970a20b@phoebee>
In-Reply-To: <20040708134459.6970a20b@phoebee>
Cc: root@chaos.analogic.com, Herbert Xu <herbert@gondor.apana.org.au>,
       Chris Wright <chrisw@osdl.org>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil, jmorris@redhat.com,
       mika@osdl.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200407081406.23831.mbuesch@freenet.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quoting Martin Zwickel <martin.zwickel@technotrend.de>:
> include/linux/stddef.h:
>
> #undef NULL
> #if defined(__cplusplus)
> #define NULL 0
> #else
> #define NULL ((void *)0)
> #endif

Yes, I never understood the reason for this ugly
#if defined(__cplusplus) here.
It works, but is IMHO unneccessary.

- --
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA7Ti+FGK1OIvVOP4RAgM/AJ9zsaNf0kKrQTq/a5R89pdjB8+/fgCfbS1p
1m6bM+MX3Dyg3lKcUK9qgRE=
=GxfG
-----END PGP SIGNATURE-----
