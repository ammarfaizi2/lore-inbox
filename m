Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSIIQXm>; Mon, 9 Sep 2002 12:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSIIQXm>; Mon, 9 Sep 2002 12:23:42 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29581 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317488AbSIIQXl>; Mon, 9 Sep 2002 12:23:41 -0400
Date: Mon, 09 Sep 2002 09:26:30 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Daniel Phillips <phillips@arcor.de>, Rik van Riel <riel@conectiva.com.br>
cc: Andrew Morton <akpm@digeo.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
Subject: Re: LMbench2.0 results
Message-ID: <312431072.1031563589@[10.10.2.3]>
In-Reply-To: <E17oRCu-0006pL-00@starship>
References: <E17oRCu-0006pL-00@starship>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Probably true, we're pulling off an indecent number of tricks
>> for 4-way and 8-way SMP performance. This overhead shouldn't
>> be too bad on UP and 2-way machines, but might easily be a
>> percent or so.
> 
> Though to be fair, it's smart to concentrate on the high end with a
> view to achieving world domination sooner.  And it's a stretch to call
> the low end performance 'slow'.

I don't think there's that much overhead, it's just not where people
have been focusing tuning efforts recently. If you run the numbers,
and point out specific problems, I'm sure people will fix them ;-)
In other words, I don't think the recent focus has caused a problem
for low end machines, it just hasn't really looked at solving one.

> An idea that's looking more and more attractive as time goes by is to
> have a global config option that specifies that we want to choose the
> simple way of doing things wherever possible, over the enterprise way.
> We want this especially for embedded.  On low end processors, it's even
> possible that the small way will be faster in some cases than the
> enterprise way, due to cache effects.

Can't we just use the existing config options instead? CONFIG_SMP is
a good start ;-) How many embedded systems with SMP do you have?

M.

