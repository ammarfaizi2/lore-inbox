Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269205AbUIAAsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269205AbUIAAsz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 20:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269131AbUIAAsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 20:48:37 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:3341 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S268840AbUHaTl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 15:41:29 -0400
Message-ID: <4134DC9E.4060904@techsource.com>
Date: Tue, 31 Aug 2004 16:16:30 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Julien Oster <usenet-20040502@usenet.frodoid.org>
CC: Miles Lane <miles.lane@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
References: <200408191822.48297.miles.lane@comcast.net> <87hdqyogp4.fsf@killer.ninja.frodoid.org>
In-Reply-To: <87hdqyogp4.fsf@killer.ninja.frodoid.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Julien Oster wrote:
> Miles Lane <miles.lane@comcast.net> writes:
> 
> 
>>http://www.theregister.co.uk/2004/07/08/dtrace_user_take/:
>>"Sun sees DTrace as a big advantage for Solaris over other versions of Unix 
>>and Linux."
> 
> 
> That article is way too hypey.
> 
> It sounds like one of those strange american commercials you see
> sometimes at night, where two overenthusiastic persons are telling you
> how much that strange fruit juice machine has changed their lives,
> with making them loose 200 pounds in 6 days and improving their
> performance at beach volleyball a lot due to subneutronic antigravity
> manipulation. You usually can't watch those commercials for longer
> than 5 minutes.
> 
> The same applies to that article, I couldn't even read it completely,
> it was just too much.
> 
> And is it just me or did that article really take that long to
> mentioning what dtrace actually IS?
> 
> Come on, it's profiling. As presented by that article, it is even more
> micro optimization than one would think. What with tweaking the disk
> I/O improvements and all... If my harddisk accesses were a microsecond
> more immediate or my filesystem giving a quantum more transfer rate,
> it would be nice, but I certainly wouldn't get enthusiastic and I bet
> nobody would even notice.
> 
> Maybe, without that article, I would recognize it as a fine thing (and
> by "fine" I don't mean "the best thing since sliced bread"), but that
> piece of text was just too ridiculous to take anything serious.
> 
> I sure hope that article is meant sarcastically. By the way, did I
> miss something or is profiling suddenly a new thing again?
> 

[I have 4000 emails from lkml to read, so please forgive me if this 
discussion is dead.]

DTrace was exactly what we needed here to figure out what was making our 
E450 server perform so badly.  We managed to find and eliminate all 
sorts of bottlenecks, and now, all of our NFS activity is CPU bound on 
the server.

Perhaps Linux never suffers from these sorts of problems that require 
tuning things such as inode cache sizes, etc???

