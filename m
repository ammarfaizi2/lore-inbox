Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130755AbQLYHuC>; Mon, 25 Dec 2000 02:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131505AbQLYHtx>; Mon, 25 Dec 2000 02:49:53 -0500
Received: from [204.42.16.60] ([204.42.16.60]:63249 "EHLO gerf.gerf.org")
	by vger.kernel.org with ESMTP id <S130755AbQLYHtl>;
	Mon, 25 Dec 2000 02:49:41 -0500
Date: Mon, 25 Dec 2000 01:19:15 -0600
From: The Doctor What <docwhat@gerf.org>
To: linux-kernel@vger.kernel.org
Subject: Re: About Celeron processor memory barrier problem
Message-ID: <20001225011915.A26662@gerf.org>
Mail-Followup-To: The Doctor What <docwhat@gerf.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001224125023.A1900@scutter.internal.splhi.com> <Pine.LNX.4.10.10012241410240.4404-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012241410240.4404-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 24, 2000 at 02:25:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@transmeta.com) [001224 16:27]:
> One thing we _could_ potentially do is to simplify the CPU selection a
> bit, and make it a two-stage process. Basically have a
> 
> 	bool "Optimize for current CPU" CONFIG_CPU_CURRENT
> 
> which most people who just want to get the best kernel would use. Less
> confusion that way.

Good Lord, YES!  And while we're at it, how about a:
        "Build into kernel every module for hardware I have..."

That'd make a 'make config' one line....

(I'll go back to dreaming)

Ciao!

-- 
Excusing bad programming is a shooting offence, no matter _what_ the circumstances.
	-- Linus Torvalds (linux-kernel mailing list)

The Doctor What: Not that 'who' guy              http://docwhat.gerf.org/
docwhat@gerf.org                                                   KF6VNC
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
