Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129814AbQKESJy>; Sun, 5 Nov 2000 13:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129823AbQKESJo>; Sun, 5 Nov 2000 13:09:44 -0500
Received: from zero.tech9.net ([209.61.188.187]:30468 "EHLO tech9.net")
	by vger.kernel.org with ESMTP id <S129814AbQKESJi>;
	Sun, 5 Nov 2000 13:09:38 -0500
Date: Sun, 5 Nov 2000 13:09:36 -0500 (EST)
From: "Robert M. Love" <rml@tech9.net>
To: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
cc: "'Linux Kernel Development'" <linux-kernel@vger.kernel.org>
Subject: RE: i82808 hardware hub RNG
In-Reply-To: <27525795B28BD311B28D00500481B7601623D7@ftrs1.intranet.FTR.NL>
Message-ID: <Pine.LNX.4.21.0011051307110.11773-100000@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Nov 2000, Heusden, Folkert van sang:
> Excellent!
> Got any URLs?

its been in 2.4 for a year or so, although only in the last few tests as
it supported i815. it has been in 2.2 since 2.2.17 or the current 2.2.18.

take a look at linux/drivers/char/i810_rng.c

Jeff's homepage for it is http://gtf.org/garzik/drivers/i810_rng/ but
probably not as up to date as the C source.

it works great for me. i have it feeding the standard entropy pool, so my
/dev/random is fat with entropy.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
