Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268096AbRG2RxW>; Sun, 29 Jul 2001 13:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268099AbRG2RxL>; Sun, 29 Jul 2001 13:53:11 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:60685 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268096AbRG2Rw7>;
	Sun, 29 Jul 2001 13:52:59 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107291752.VAA19495@ms2.inr.ac.ru>
Subject: Re: [PATCH] [IMPORTANT] Re: 2.4.7 softirq incorrectness.
To: torvalds@transmeta.com (Linus Torvalds)
Date: Sun, 29 Jul 2001 21:52:11 +0400 (MSK DST)
Cc: andrea@suse.de, maxk@qualcomm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, davem@redhat.com
In-Reply-To: <Pine.LNX.4.33.0107291002570.8151-100000@penguin.transmeta.com> from "Linus Torvalds" at Jul 29, 1 10:07:57 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> I think the latency issue was really the fact that we weren't always
> running softirqs in a timely fashion after they had been disabled by a
> "disable_bh()". That is fixed with the new softirq stuff, regardless of
> the other issues.

I hope too. Actually, this observation was main argument pro ksoftirqd
and against instant restart. Ingo objected but finally the issue was buried...
or I lost discussion not reading maillists for some time.

Alexey
