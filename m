Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316616AbSFPXvC>; Sun, 16 Jun 2002 19:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316617AbSFPXvB>; Sun, 16 Jun 2002 19:51:01 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8190 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316616AbSFPXvA>; Sun, 16 Jun 2002 19:51:00 -0400
Subject: Re: [PATCH] 2.4-ac: sparc64 support for O(1) scheduler
From: Robert Love <rml@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "David S. Miller" <davem@redhat.com>, alan@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206161710240.7461-100000@e2>
References: <Pine.LNX.4.44.0206161710240.7461-100000@e2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 16 Jun 2002 16:45:45 -0700
Message-Id: <1024271149.3090.13.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-16 at 08:19, Ingo Molnar wrote:

> Linus applied them already, they will be in 2.5.22. They fix real bugs and
> i've seen no problems on my testboxes. Those bits are a must for SMP x86
> and Sparc64 as well, there is absolutely no reason to selectively delay
> their backmerge. Besides the last task_rq_lock() optimization which got
> undone in 2.5 already, all the recent scheduler bits i posted are needed.

I know they are fine (I looked over them) and I saw Linus took them, but
2.5.22 is not yet out and I did not see any reason to rush to new bits
to Alan for 2.4 when we could wait a bit and make sure 2.5 proves them
fine...

My approach thus far with 2.5 -> 2.4 O(1) backports has been one of
caution and it has worked fine thus far.  I figure, what is the rush?

	Robert Love

