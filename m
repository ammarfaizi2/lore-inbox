Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263019AbTKXSVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 13:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTKXSVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 13:21:55 -0500
Received: from mout2.freenet.de ([194.97.50.155]:46284 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S263019AbTKXSVx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 13:21:53 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Jakob Lell <jlell@JakobLell.de>
Subject: Re: hard links create local DoS vulnerability and security problems
Date: Mon, 24 Nov 2003 19:21:48 +0100
User-Agent: KMail/1.5.93
References: <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos> <200311241857.41324.jlell@JakobLell.de>
In-Reply-To: <200311241857.41324.jlell@JakobLell.de>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200311241921.50001.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 24 November 2003 18:57, Jakob Lell wrote:
> > > To solve the problem, the kernel shouldn't allow users to create hard
> > > links to
> > > files belonging to someone else.
> >
> > No. Users must be able to create hard links to files that belong
> > to somebody else if they are readable. It's a requirement.
>
> If this is REALLY neccessary, it might be possible to prevent hard links to
> setuid binaries.

What about _not_ modifying the mainstream-kernel behaviour,
but adding an option, to make users unable to create such hard-links,
to selinux and/or grsec?

> Regards
>  Jakob

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/wkw8oxoigfggmSgRArwLAJ47CAW90QtuEK+PNAlpzDf3ZBmohgCeKaGT
YKUZQRAYYnszq90a34KmH6U=
=EUOO
-----END PGP SIGNATURE-----
