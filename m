Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281493AbRKMFYX>; Tue, 13 Nov 2001 00:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281494AbRKMFYN>; Tue, 13 Nov 2001 00:24:13 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:52361 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281493AbRKMFYE>; Tue, 13 Nov 2001 00:24:04 -0500
Date: Mon, 12 Nov 2001 22:23:27 -0700
Message-Id: <200111130523.fAD5NRK18457@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPLONLY kernel symbols???
In-Reply-To: <3BF0AC47.221B6CD6@mandrakesoft.com>
In-Reply-To: <200111130324.fAD3OE916102@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0111122249160.22925-100000@weyl.math.psu.edu>
	<200111130358.fAD3wgb16617@vindaloo.ras.ucalgary.ca>
	<3BF09E44.58D138A6@mandrakesoft.com>
	<200111130437.fAD4b2j17329@vindaloo.ras.ucalgary.ca>
	<3BF0A788.8CCBC91@mandrakesoft.com>
	<200111130500.fAD50Wi17879@vindaloo.ras.ucalgary.ca>
	<3BF0AC47.221B6CD6@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Is a compromise possible?  Can you keep a local codebase in your own
> coding style, and then run Lindent before sending to Linus?

The problem is that I'm not the only writer of that code.
Occasionally, global API changes are made, and these aren't sent to
me, but go to Linus directly, unfortunately. So I do have to merge
stuff back into my tree from time to time.

A few days ago I was thinking about this, and I thought how cool it
would be to have a reliable utility that could convert between the two
coding styles. If I had that (and it was bulletproof) then it could be
used with some kind of userfs to give me two views of the kernel: the
underlying one "raw" one, to which I'd apply patches and generate them
from, and a "sanitised" one, that I would read and edit.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
