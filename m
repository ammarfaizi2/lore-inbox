Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272571AbTHKMzU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 08:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272572AbTHKMzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 08:55:20 -0400
Received: from smtp100.mail.sc5.yahoo.com ([216.136.174.138]:33966 "HELO
	smtp100.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S272571AbTHKMzO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 08:55:14 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [2.6-test3] bttv driver doesn't run
Date: Mon, 11 Aug 2003 14:19:08 +0200
User-Agent: KMail/1.5.3
References: <200308092104.48878.fsdeveloper@yahoo.de> <20030811121546.GA8998@bytesex.org>
In-Reply-To: <20030811121546.GA8998@bytesex.org>
Cc: video4linux-list@redhat.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308111419.28312.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 11 August 2003 14:15, Gerd Knorr wrote:
> > When trying to run the tv-application "tvtime", the kernel
> > throws some more messages. tvtime worked fine for a few
> > seconds (video and audio worked), but then it froze and
> > was non-workable from then on.
>
> Does reloading the driver help?

I don't know. I compiled bttv completely into the
kernel, because when I tried to configure
them as modules, I got thousands over thousands
of unresolved symbols. I tried to resolve them,
but I had no time to do this, so I decided
to compile them monolithically.

> > Aug  9 20:49:08 lfs kernel: bttv0: timeout: risc=0f7ae874, bits: VSYNC
> > HSYNC OFLOW RISCI Aug  9 20:49:08 lfs kernel: bttv0: reset, reinitialize
>
> Yea, the reinitialize function doesn't re-enable the interrupts.
> Try latest patches from bytesex.org/patches/ which have this fixed, that
> should improve error recovery ...

I'll take a look at them. Thank you for the hint.

>   Gerd

- -- 
Regards Michael Buesch  [ http://www.8ung.at/tuxsoft ]
Animals on this machine: some GNUs and Penguin 2.6.0-test2

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/N4nKoxoigfggmSgRAhveAJ4m5eMJ3D7qq+vTtrosXos4r6RQdQCfU5g6
SmA2Np9rDBGrr7JdY8cc9Bc=
=1cC+
-----END PGP SIGNATURE-----

