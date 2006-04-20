Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWDUGFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWDUGFB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 02:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWDUGFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 02:05:01 -0400
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:50604 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750924AbWDUGFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 02:05:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=n3u/H8esciifmIR4sIZkDRuxuGraWRjcj6viVlv8tQeVoUUViDI3QUIY6HznIq+yrA7qWHY8clowsqPkyfJj0IIttcIAamO+7hwzWlclH8cVGw4aGjIieZWEXxiuZb0GL6K7WhNKIp3x0o6rTEEAKcwpPDcgAompftweFgDZN2I=  ;
Message-ID: <4447E702.6050906@yahoo.com.au>
Date: Fri, 21 Apr 2006 05:54:42 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
       diegocg@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
References: <20060420145041.GE4717@suse.de> <20060420.122647.03915644.davem@davemloft.net> <20060420193430.GH4717@suse.de> <20060420.123948.52057640.davem@davemloft.net> <20060420194429.GK4717@suse.de>
In-Reply-To: <20060420194429.GK4717@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> It's up to the user, any non-dumb app would use SPLICE_F_NONBLOCK and
> avoid blocking ofcourse.

BTW. How come you don't just set the pipe's fds non blocking
instead of using that flag? Any reason?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
