Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133001AbRAJBqg>; Tue, 9 Jan 2001 20:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133025AbRAJBq0>; Tue, 9 Jan 2001 20:46:26 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:55557 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S133001AbRAJBqR>; Tue, 9 Jan 2001 20:46:17 -0500
Date: Wed, 10 Jan 2001 01:45:47 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Zlatko Calusic <zlatko@iskon.hr>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.10.10101091041150.2070-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101100144280.7564-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Linus Torvalds wrote:

> And this _is_ a downside, there's no question about it. There's the worry
> about the potential loss of locality, but there's also the fact that you
> effectively need a bigger swap partition with 2.4.x - never mind that
> large portions of the allocations may never be used. You still need the
> disk space for good VM behaviour.
>
> There are always trade-offs, I think the 2.4.x tradeoff is a good one.

How does this affect embedded systems with no swap space at all?

-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
