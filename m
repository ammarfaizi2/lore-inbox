Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267193AbUGMWmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267193AbUGMWmZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUGMWk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:40:57 -0400
Received: from mail.tmr.com ([216.238.38.203]:41996 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S267195AbUGMWiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:38:20 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel   Preemption
 Patch
Date: Tue, 13 Jul 2004 18:40:30 -0400
Organization: TMR Associates, Inc
Message-ID: <cd1nv4$3k7$1@gatekeeper.tmr.com>
References: <1089677823.10777.64.camel@mindpipe><20040709182638.GA11310@elte.hu> <20040712174639.38c7cf48.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1089757988 3719 192.168.12.100 (13 Jul 2004 22:33:08 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en
In-Reply-To: <20040712174639.38c7cf48.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
>>>resierfs: yes, it's a problem.  I "fixed" it multiple times in 2.4, but the
>>
>> > fixes ended up breaking the fs in subtle ways and I eventually gave up.
>> > 
>>
>> Interesting.  There is an overwhelming consensus amongst Linux audio
>> folks that you should use reiserfs for low latency work.
> 
> 
> It seems to be misplaced.  A simple make-a-zillion-teeny-files test here
> exhibits a 14 millisecond holdoff.
> 
> 
>> Should I try ext3?
> 
> 
> ext3 is certainly better than that, but still has a couple of potential
> problem spots.  ext2 is probably the best at this time.

Does anyone have any data points on XFS in this regard? I agree that 
ext2 is faster than ext3, and ext3 probably has lower latency than 
reiser3, but I have no info at all on XFS. My JFS experience is all on 
AIX, as well, so if anyone has that info it might be interesting as well.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
