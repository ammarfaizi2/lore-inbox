Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269092AbUHaWOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269092AbUHaWOM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268010AbUHaWMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:12:54 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:6671 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S268137AbUHaWLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:11:23 -0400
Message-ID: <4134FFC3.50409@techsource.com>
Date: Tue, 31 Aug 2004 18:46:27 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
References: <200408021602.34320.swsnyder@insightbb.com> <20040804120633.4dca57b3.akpm@osdl.org> <411ABF85.2080200@techsource.com> <41336CB1.6030105@techsource.com> <cgvpb4$ljq$1@news.cistron.nl>
In-Reply-To: <cgvpb4$ljq$1@news.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Miquel van Smoorenburg wrote:
> In article <41336CB1.6030105@techsource.com>,
> Timothy Miller  <miller@techsource.com> wrote:
> 
>>Timothy Miller wrote:
>>
>>>Hey, that rings a bell.  I have a 3ware 7000-2 controller with two 
>>>WD1200JB drives in RAID1.  I find that if I dd from the disk, I get 
>>>exactly the read throughput that is the max for the drives (47MB/sec). 
>>>However, if I do a WRITE test, the performance is miserable.
>>>
>>>I have been going back and forth with 3ware for months, and what's odd 
>>>is that my drives with my controller in any machine other than the 
>>>primary box get great write throughput, BUT on my main box with 1G of 
>>>RAM, I get MISERABLE write throughput.  When I should be getting 
>>>36MB/sec or faster, I get 8 to 12 MB/sec.
>>>
>>>Now, I have tried limiting the memory with a mem= boot option, but that 
>>>doesn't change the performance any.
>>
>>Scratch all this.  Even if I physically remove half the memory, I STILL 
>>get the performance problem.
> 
> 
> 3ware eh?
> 
> Try setting /sys/block/sda/queue/nr_requests to twice the number
> in /sys/block/sda/device/queue_depth


This will improve write performance?  And if this helps, how do I make 
it permanent?

Thanks!

