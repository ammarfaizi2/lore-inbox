Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268093AbRG2Qg5>; Sun, 29 Jul 2001 12:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268090AbRG2Qgr>; Sun, 29 Jul 2001 12:36:47 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:4104 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268088AbRG2Qga>;
	Sun, 29 Jul 2001 12:36:30 -0400
Message-Id: <200107282328.DAA01045@mops.inr.ac.ru>
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
To: andrea@suse.de (Andrea Arcangeli)
Date: Sun, 29 Jul 2001 03:28:00 +0400 (MSD)
Cc: maxk@qualcomm.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        mingo@redhat.com, davem@redhat.com
In-Reply-To: <20010728213242.B11441@athlon.random> from "Andrea Arcangeli" at Jul 28, 1 09:32:42 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> yes, ksoftirqd should just avoid you to eat all the cpu 

I see now, you completely killed dead loops from Ingo's patch!
It is your original approach and I am happy with it.

Before falling to euforia, the last question:
Is Ingo really happy with this? He blamed about latency,
it is not better than in 2.4.5 (with cpu_idle fix) :-)

> I hope I didn't misunderstood the question in such case please correct
> me.

You really misunderstood this a bit, but solely because the question
was meaningless in context of 2.4.7. My apologies. :-)

Alexey
