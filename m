Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261629AbRESCce>; Fri, 18 May 2001 22:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261634AbRESCcX>; Fri, 18 May 2001 22:32:23 -0400
Received: from marine.sonic.net ([208.201.224.37]:21818 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S261629AbRESCcG>;
	Fri, 18 May 2001 22:32:06 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Fri, 18 May 2001 19:32:03 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Linux 2.4.4-ac10
Message-ID: <20010518193203.C29686@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105182310580.5531-100000@imladris.rielhome.conectiva>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2001 at 11:12:32PM -0300, Rik van Riel wrote:
> Basic rule for VM: once you start swapping, you cannot
> win;  All you can do is make sure no situation loses
> really badly and most situations perform reasonably.

Do you mean paging in general or thrashing?

I always thought: paging good, thrashing bad.

A good effecient paging system, always moving data between memory and disk,
is great.  It's when you have the greater than physical memory working set
that things go to hell in a hand basket.

Did Linux ever do the old trick of "We've too much going on!  You!
(randomly points to a process) take a seat!  You're not running for a
while!" and the process gets totatlly swapped out for a "while," not even
scheduled?

mrc
-- 
       Mike Castle       Life is like a clock:  You can work constantly
  dalgoda@ix.netcom.com  and be right all the time, or not work at all
www.netcom.com/~dalgoda/ and be right at least twice a day.  -- mrc
    We are all of us living in the shadow of Manhattan.  -- Watchmen
