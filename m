Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUC2Uum (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 15:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUC2Uum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 15:50:42 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:8343 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261603AbUC2Uuj (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 15:50:39 -0500
Message-ID: <40687354.1060604@namesys.com>
Date: Mon, 29 Mar 2004 11:04:52 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: markw@osdl.org
CC: Nikita@namesys.com, Reiserfs-Dev@namesys.com, Reiserfs-List@namesys.com,
       Linux-Kernel@Vger.Kernel.ORG, cliff@lindows.com, tom.welch@lindows.com,
       garloff@suse.de, drobbins@gentoo.org, reiserrf@hotmail.com
Subject: Re: Reiser4 needs more testers
References: <200403291659.i2TGxQ214736@mail.osdl.org>
In-Reply-To: <200403291659.i2TGxQ214736@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was the parallel fsync benchmark?

Hans

markw@osdl.org wrote:

>I've run through another test on STP with the latest snapshot against
>reiser4 and reiserfs for comparison.  Reiser4 still seems to be lagging
>behind reiserfs in our DBT-2 workload (the bigger number is better in
>the metric):
>
>          metric  url to test results
>          ------  ---------------------------------
>reiser4   1208    http://khack.osdl.org/stp/290774/
>reiserfs  1819    http://khack.osdl.org/stp/290775/
>
>Mark
>
>On 26 Mar, Hans Reiser wrote:
>  
>
>>We have one NFS related bug remaining, and one mmap all of memory 
>>related bug (and performance issue) that you can hit using iozone.  We 
>>will fix both of these in next week's snapshot, they were both multi-day 
>>bug fixes.  When they are fixed, unless users/distros find bugs next 
>>week we will submit it for inclusion in the -mm and then the official 
>>kernel.
>>
>>We hope it is now fairly stable for average users if you avoid those two 
>>issues (we need to get rid of those dire warnings about its 
>>stability...., we will remember that next snapshot....;-) )
>>
>>We need a lot more real user testers, because we have run out of scripts 
>>that can crash it, and there are distros that would like to ship it 
>>soon.  Please also complain to vitaly@namesys.com and ramon@namesys.com 
>>about poor documentation, etc., ....
>>
>>The new reiser4 snapshot (against 2.6.5-rc2) is available at
>>
>>http://www.namesys.com/snapshots/2004.03.26/
>>    
>>
>
>
>
>  
>


-- 
Hans

