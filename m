Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbRADBdZ>; Wed, 3 Jan 2001 20:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRADBdP>; Wed, 3 Jan 2001 20:33:15 -0500
Received: from ns2.avnet.it ([194.91.85.195]:35080 "EHLO interno.emmenet.it")
	by vger.kernel.org with ESMTP id <S129267AbRADBdI>;
	Wed, 3 Jan 2001 20:33:08 -0500
From: Diego Liziero <pmcq@interno.emmenet.it>
Message-Id: <200101040134.f041YDk16411@interno.emmenet.it>
Subject: Re: gcc2.96 + prerelease BUG at inode.c:372
To: linux-kernel@vger.kernel.org
Date: Thu, 4 Jan 2001 02:34:13 +0100 (CET)
Cc: pmcq@emmenet.it
In-Reply-To: <200101032340.PAA08324@penguin.transmeta.com> from "Linus Torvalds" at gen 03, 2001 03:40:23 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Diego Liziero  <pmcq@interno.emmenet.it> wrote:
> >
> >->1: The sound module for my mad16 based card plays the bytes swapped
> >     (the same module recompiled with egcs-2.91.66 works fine).
> 
> Could you try to figure this one out a bit more? This sounds like a real
> compiler issue, whether it is because egcs just happens to get the right
> result for bogus kernel source, of whether gcc-2.96 has problems..

I've just recompiled the kernel with the gcc 2.96-69 upgrade from RedHat
and the sound module works ok.

So it seems a known compiler bug.

			Diego Liziero (pmcq@emmenet.it)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
