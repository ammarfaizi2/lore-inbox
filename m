Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131698AbRAHRR1>; Mon, 8 Jan 2001 12:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132431AbRAHRRV>; Mon, 8 Jan 2001 12:17:21 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:20477 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S131698AbRAHRRE>; Mon, 8 Jan 2001 12:17:04 -0500
Date: Mon, 8 Jan 2001 15:16:48 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        "William A. Stein" <was@math.harvard.edu>
Subject: Re: Subtle MM bug
In-Reply-To: <Pine.LNX.4.30.0101072014300.17414-100000@mf1.private>
Message-ID: <Pine.LNX.4.21.0101081514180.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Wayne Whitney wrote:

> Well, here is a workload that performs worse on 2.4.0 than on 2.2.19pre,

> The typical machine is a dual Intel box with 512MB RAM and 512MB swap.

How does 2.4 perform when you add an extra GB of swap ?

2.4 keeps dirty pages in the swap cache, so you will need
more swap to run the same programs...

Linus: is this something we want to keep or should we give
the user the option to run in a mode where swap space is
freed when we swap in something non-shared ?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
