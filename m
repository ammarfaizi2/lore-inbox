Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130155AbQLLFM5>; Tue, 12 Dec 2000 00:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130200AbQLLFMr>; Tue, 12 Dec 2000 00:12:47 -0500
Received: from www.wen-online.de ([212.223.88.39]:32784 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130155AbQLLFMi>;
	Tue, 12 Dec 2000 00:12:38 -0500
Date: Tue, 12 Dec 2000 05:40:56 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Steven Cole <elenstev@mesatop.com>
cc: linux-kernel@vger.kernel.org, vii@penguinpowered.com,
        mojomofo@mojomofo.com
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
In-Reply-To: <00121116022700.12045@localhost.localdomain>
Message-ID: <Pine.Linu.4.10.10012120529110.970-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2000, Steven Cole wrote:

> I have a SMP (dual P-III 733Mhz) machine at work, but it will be 
> unavailable for testing for a few more days.  I suspect that 2.4.0-test12
> will do better than 2.2.18 with 2 CPUs.  I'll know in a few days.
> 
> Building kernels is something we do so frequently and this test is so easy
> to reproduce is why I performed it in the first place.  I think it may be as 
> good a test of real performance as some of the more formal benchmarks.
> Comments anyone?

I think it's better with -j.  Do it with -jN where N is small enough
to keep the box away from swap, and then repeat with N large enough to
swap modestly (not too heavily or you're only testing disk MTBF:).

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
