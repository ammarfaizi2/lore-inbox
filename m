Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTHaOJe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbTHaOJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:09:33 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:10916 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262115AbTHaOJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:09:29 -0400
Message-ID: <3F52062A.4020701@kegel.com>
Date: Sun, 31 Aug 2003 07:28:58 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: GCC Mailing List <gcc@gcc.gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: LMbench as gcc performance regression test?
References: <3F51A201.8090108@kegel.com> <20030831140037.GA16620@work.bitmover.com>
In-Reply-To: <20030831140037.GA16620@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> On Sun, Aug 31, 2003 at 12:21:37AM -0700, Dan Kegel wrote:
> 
>>(There seems to be large variations in successive runs of LMBench
>>when I try it, so it may take me a bit of work to get repeatable
>>results.)
> 
> 
> Other than the context switch part or anything based on it, that shouldn't
> be true, it should be very stable.
> 
> I'm pretty convinced that the variations are due to different pages being
> allocated and the result cache contention makes things bounce.

Or an idiot running the benchmark.  We really do have to rule that out first.
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

