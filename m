Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268916AbRG0S76>; Fri, 27 Jul 2001 14:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268925AbRG0S7s>; Fri, 27 Jul 2001 14:59:48 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:61200 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S268916AbRG0S7i>;
	Fri, 27 Jul 2001 14:59:38 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200107271859.WAA24210@ms2.inr.ac.ru>
Subject: Re: 2.4.7 softirq incorrectness.
To: maxk@qualcomm.com (Maksim Krasnyanskiy)
Date: Fri, 27 Jul 2001 22:59:14 +0400 (MSK DST)
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <4.3.1.0.20010727112236.03454b30@mail1> from "Maksim Krasnyanskiy" at Jul 27, 1 11:31:22 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello!

> Applied to 2.4.8-pre1. Didn't make any difference.

Yes, that hole is mostly theoretical. At least, on intel. Seems, gcc is still
not enough clever to reorder atomic operations.


> Also it doesn't fix the scenario that I described (reschedule while running). I'm still wondering why don't I hit that trylock/BUG 
> in tasklet_action.

How old the problem is? Was it always present?

To be honest, this is too strong bug to believe to this at all. :-)

Alexey
