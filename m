Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129405AbQKFISs>; Mon, 6 Nov 2000 03:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130259AbQKFISj>; Mon, 6 Nov 2000 03:18:39 -0500
Received: from ip101-98.asiaonline.net ([202.85.101.98]:48134 "EHLO
	simba.hklc.com") by vger.kernel.org with ESMTP id <S129405AbQKFISV>;
	Mon, 6 Nov 2000 03:18:21 -0500
To: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: rdtsc to mili secs?
From: <ming_l@hklc.com>
X-Mailer: TWIG 2.1.1
Cc: Sushil Agarwal <sushil@veritas.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain;
Content-Transfer-Encoding: 8bit
Message-Id: <E13shRO-00035A-00@simba.hklc.com>
Date: Mon, 06 Nov 2000 16:15:42 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> said: 

> On Mon, Nov 06, 2000 at 12:28:00AM +0000, Alan Cox wrote:
> > or running SMP with non matched CPU clocks.
> 
> In this last case I guess he will have more problems than not being able to
> convert from cpu-clock to usec 8). Scheduler and gettimeofday will do the 
wrong
> thing in that case (scheduler both for bougs avg_slice and fairness).
> 
> Andrea
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
> 



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
