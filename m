Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUEWJjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUEWJjC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 05:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUEWJjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 05:39:02 -0400
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:49324 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261232AbUEWJi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 05:38:59 -0400
Message-ID: <40B07130.6020408@yahoo.com.au>
Date: Sun, 23 May 2004 19:38:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Gergely Czuczy <phoemix@harmless.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 VS 2.6 fork VS thread creation time test
References: <Pine.LNX.4.60.0405230914330.15840@localhost> <40B066EC.1010107@yahoo.com.au> <Pine.LNX.4.60.0405231058530.25386@localhost>
In-Reply-To: <Pine.LNX.4.60.0405231058530.25386@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gergely Czuczy wrote:
> On Sun, 23 May 2004, Nick Piggin wrote:
> 
> 
>>Gergely Czuczy wrote:
>>

>>>Box B is a lot better, but it doesn't metter according to the test,
>>>because the aim was to get the ratio of the two times with different
>>>sample rates.
>>>
>>
>>Even so, you really should be using the same system if you want
>>comparable results. The pentium 4 in particular can do worse at
>>specific things in microbenchmarks.
> 
> It doesn't matter. That's why you should look at the "ratio" at the end
> and not on the pure numbers, they are just bonus "information"
> 

I understand that... but the P4 might execute the fork test
relatively slower than the thread test compared to the P3.

Different CPU architectures, cache types and sizes, memory
to CPU speeds, etc. might all have some influcene on the
ratio.
