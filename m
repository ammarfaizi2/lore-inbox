Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270542AbRHHSCy>; Wed, 8 Aug 2001 14:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270551AbRHHSCo>; Wed, 8 Aug 2001 14:02:44 -0400
Received: from [63.209.4.196] ([63.209.4.196]:4361 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S270542AbRHHSC2>;
	Wed, 8 Aug 2001 14:02:28 -0400
Date: Wed, 8 Aug 2001 11:00:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hubertus Franke <frankeh@us.ibm.com>
cc: Mike Kravetz <mkravetz@beaverton.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] Scalable Scheduling
In-Reply-To: <Pine.LNX.4.33.0108081041260.8047-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0108081058420.8103-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 8 Aug 2001, Linus Torvalds wrote:
>
> The only thing that looked really ugly was that real-time runqueue
> thing. Does it _really_ have to be done that way?

Oh, and as I didn't actually run it, I have no idea about what performance
is really like. I assume you've done lmbench runs across wide variety (ie
UP to SMP) of machines with and without this?

"Scalability" is useless if the baseline you scale from is bad. In the
end, the only thing that matters is "performance", not "scalability".
Which is why sometimes O(n) is better than O(logn).

		Linus

