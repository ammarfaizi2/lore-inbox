Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281502AbRKMF3x>; Tue, 13 Nov 2001 00:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281503AbRKMF3p>; Tue, 13 Nov 2001 00:29:45 -0500
Received: from zero.tech9.net ([209.61.188.187]:8979 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281502AbRKMF3k>;
	Tue, 13 Nov 2001 00:29:40 -0500
Subject: Re: GPLONLY kernel symbols???
From: Robert Love <rml@tech9.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200111130523.fAD5NRK18457@vindaloo.ras.ucalgary.ca>
In-Reply-To: <200111130324.fAD3OE916102@vindaloo.ras.ucalgary.ca>
	<Pine.GSO.4.21.0111122249160.22925-100000@weyl.math.psu.edu>
	<200111130358.fAD3wgb16617@vindaloo.ras.ucalgary.ca>
	<3BF09E44.58D138A6@mandrakesoft.com>
	<200111130437.fAD4b2j17329@vindaloo.ras.ucalgary.ca>
	<3BF0A788.8CCBC91@mandrakesoft.com>
	<200111130500.fAD50Wi17879@vindaloo.ras.ucalgary.ca>
	<3BF0AC47.221B6CD6@mandrakesoft.com> 
	<200111130523.fAD5NRK18457@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.11.08.57 (Preview Release)
Date: 13 Nov 2001 00:29:35 -0500
Message-Id: <1005629381.838.0.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-13 at 00:23, Richard Gooch wrote:
> The problem is that I'm not the only writer of that code.
> Occasionally, global API changes are made, and these aren't sent to
> me, but go to Linus directly, unfortunately. So I do have to merge
> stuff back into my tree from time to time.
> 
> A few days ago I was thinking about this, and I thought how cool it
> would be to have a reliable utility that could convert between the two
> coding styles. If I had that (and it was bulletproof) then it could be
> used with some kind of userfs to give me two views of the kernel: the
> underlying one "raw" one, to which I'd apply patches and generate them
> from, and a "sanitised" one, that I would read and edit.

Good lord, and you would dream this up and use it before just using the
same coding style as the rest of us? :)

Maybe I am biased because I find CodingStyle beautiful, but I can't
understand why it is so hard to just play nicely with the rest of us.  I
diffed a patch for Alan against mtrr.c a week or so back to fix some
compile bug, and I was confused doing a _two line_ diff.

	Robert Love

