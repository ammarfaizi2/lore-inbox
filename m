Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274803AbRJFBGd>; Fri, 5 Oct 2001 21:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274813AbRJFBGY>; Fri, 5 Oct 2001 21:06:24 -0400
Received: from c290168-a.stcla1.sfba.home.com ([24.250.174.240]:39499 "HELO
	top.worldcontrol.com") by vger.kernel.org with SMTP
	id <S274803AbRJFBGK>; Fri, 5 Oct 2001 21:06:10 -0400
From: brian@worldcontrol.com
Date: Fri, 5 Oct 2001 18:19:28 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-ac3+preempt opening PDF/netscape eliminates responsiveness
Message-ID: <20011005181928.A4099@top.worldcontrol.com>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011002163443.A6882@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011002163443.A6882@top.worldcontrol.com>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 04:34:44PM -0700, Brian Litzinger wrote:
> I'm running 2.4.10-ac3+preempt on a K6-3/366 with 128MB RAM.
> 
> I tried to open the file flag.pdf in ghostview 
> 
> -rw-r--r--   1 brian    console    229365 Oct  1 22:49 flag.pdf
> 
> The system became almost completely unresponsive.  The mouse would
> move every 20 seconds or so.   The hard drive indicator on the laptop
> was basically on the whole time, and I could hear the drive
> making noise.

-ac5 did not help with long periods of frozen X syndrome.

A number of people suggested trying 2.4.11pre2 or later.

Unfortunately, I was unable to build 2.4.11pre4 and ext3.

Newest patch at http://www.uow.edu.au/~andrewm/linux/ext3/
is for 2.4.10 and that patch had more patch errors than I
could manage when applied to 2.4.11pre4.

I did however find another easy way to cause the problem to happen:

point netscape 4.78 at

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0109.3/index.html

Do an edit/find on the word 'netcon'.

The second I press find, the X cursor is frozen for 8 seconds,
then moves a little bit, and then is frozen for another 50 seconds.

This is 2.4.10-ac5 on a K6-3/366 with 128MB RAM.

-- 
Brian Litzinger <brian@worldcontrol.com>

    Copyright (c) 2000 By Brian Litzinger, All Rights Reserved
