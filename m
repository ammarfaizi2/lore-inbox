Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276231AbRJHSYk>; Mon, 8 Oct 2001 14:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276972AbRJHSYc>; Mon, 8 Oct 2001 14:24:32 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:3844 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S276231AbRJHSY1>; Mon, 8 Oct 2001 14:24:27 -0400
Message-ID: <3BC1EF61.9ECD3273@zip.com.au>
Date: Mon, 08 Oct 2001 11:24:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: Helge Hafting <helgehaf@idb.hist.no>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: low-latency patches
In-Reply-To: <20011006010519.A749@draal.physics.wisc.edu> <3BBEA8CF.D2A4BAA8@zip.com.au> <20011006150024.C2625@mikef-linux.matchmail.com> <3BC1A062.6E953751@idb.hist.no> <3BC1E53E.2A67202A@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger wrote:
> 
> Well, no, but do we want to improve as kernel writers, or just stay
> "hackers"?  If low latency was a concern the same way lack of dead locks
> and avoiding OOPs is today, don't you think we would be better coders?
> As for me, I want to shoot for the higher goal.  Even if I miss, I will
> still have accomplished more than if I had shot for the mundane.

Right.  It needs to be a conscious, planned decision:  "from now on,
holding a lock for more than 500 usecs is a bug".

So someone, be it Linus, "the community" or my Mum needs to decide
that this is a feature which the kernel will henceforth support.

It's a new feature - it should be treated as such.


-
