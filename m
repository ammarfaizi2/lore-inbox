Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262194AbSJJXA0>; Thu, 10 Oct 2002 19:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262202AbSJJXA0>; Thu, 10 Oct 2002 19:00:26 -0400
Received: from packet.digeo.com ([12.110.80.53]:25535 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262194AbSJJXA0>;
	Thu, 10 Oct 2002 19:00:26 -0400
Message-ID: <3DA607DC.7F6DADB9@digeo.com>
Date: Thu, 10 Oct 2002 16:06:04 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Mark Mielke <mark@mark.mielke.cc>, Robert Love <rml@tech9.net>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: More on O_STREAMING (goodby read pauses)
References: <20021009222349.GA2353@werewolf.able.es> <1034203433.794.152.camel@phantasy> <20021010034057.GC8805@mark.mielke.cc> <20021010143927.GA2193@werewolf.able.es> <20021010180108.GB16962@mark.mielke.cc> <20021010225052.GE1676@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2002 23:06:05.0004 (UTC) FILETIME=[9C1688C0:01C270B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" wrote:
> 
> ...
> I look at gnome system monitor graph for mem. I start with a tiny amount of
> used memory. Start the 1Gb read without O_STREAM, the blue area in monitor
> starts to grow linearly in time, stars (*) from the reader appear at a
> given rate, and as soon as it touches the top limit the stars stop, the disk
> begins to thrash, and swap space used grows. After a 2-4 seconds, the stars
> go again with the same rate. Tell me what is this but swapper writing pages,
> and reading the new pages for my giga.
> 

That's fairly rude behaviour for a 2.4 kernel.  Sounds like 2.5 ;)

What kernel is that?
