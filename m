Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264653AbUDVT6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264653AbUDVT6i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264646AbUDVTzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:55:48 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:8842 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S264657AbUDVTxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:53:21 -0400
Message-ID: <408822F1.80409@tmr.com>
Date: Thu, 22 Apr 2004 15:54:25 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Benchmarking objrmap under memory pressure
References: <c5mcoc$s9l$1@gatekeeper.tmr.com> <Pine.LNX.4.44.0404151746140.9558-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0404151746140.9558-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 15 Apr 2004, Bill Davidsen wrote:
> 
>>Hugh Dickins wrote:
>>
>>>The worst that will happen with anonmm's mremap move, is that some
>>>app might go slower and need more swap.  Unlikely, but agreed possible.
>>
>>It appears that users on small memory machines running kde are not of 
>>concern to you. Unfortunately that describes a fair number of people, 
>>not everyone has the big memory fast system. I will try to get some 
>>reproducible numbers, but "consistently feels faster" is a reason to 
>>keep running -aa even if I can't quantify it.
> 
> 
> Appearances can be deceptive.  Of course I care about users,
> of small or large memory machines, running kde or not.
> 
> It appears that you do not understand that we're talking about a
> case so rare that we've never seen it in practice, only by testing.
> 
> But perhaps we haven't looked out for it enough (no printk), I'd better
> put something in to tell us when it does occur, thanks for the reminder.
> 
> If -aa consistently feels faster to you, great, go with it:
> but I doubt it's because of this issue we're discussing!

I don't disagree on that, but it seems that KDE developers have put some 
serious effort into making the software well-behaved, and unless there 
is some measurable benefit from the code which negates the benefits of 
that effort, it seems desirable to appreciate code code by letting it work.

I was more commenting on the good performance at the bottom end than 
addressing the large machines. All the big machines I have are in the 
overkill range, and finding small benefits doesn't do much with 
production loads, so I can't contribute any useful info at that end.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
