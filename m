Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbUBVCDR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 21:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbUBVCDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 21:03:16 -0500
Received: from adsl-63-194-240-129.dsl.lsan03.pacbell.net ([63.194.240.129]:32517
	"EHLO mikef-fw.mikef-fw.matchmail.com") by vger.kernel.org with ESMTP
	id S261641AbUBVCDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 21:03:15 -0500
Message-ID: <40380DE2.4030702@matchmail.com>
Date: Sat, 21 Feb 2004 18:03:14 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Large slab cache in 2.6.1
References: <4037FCDA.4060501@matchmail.com> <4038014E.5070600@matchmail.com> <20040222012033.GC703@holomorphy.com>
In-Reply-To: <20040222012033.GC703@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> Mike Fedyk wrote:
> 
>>>I have 1.5 GB of ram in this system that will be a Linux Terminal Server 
>>>(but using Debian & VNC).  There's 600MB+ anonymous memory, 600MB+ slab 
>>>cache, and 100MB page cache.  That's after turning off swap (it was 
>>>400MB into swap at the time).
> 
> 
> On Sat, Feb 21, 2004 at 05:09:34PM -0800, Mike Fedyk wrote:
> 
>>Here's my top slab users:
>>dentry_cache      585455 763395    256   15    1 : tunables  120   60 
>> 8 : slabdata  50893  50893      3
>>ext3_inode_cache  686837 688135    512    7    1 : tunables   54   27 
>> 8 : slabdata  98305  98305      0
>>buffer_head        34095  78078     48   77    1 : tunables  120   60 
>> 8 : slabdata   1014   1014      0
>>vm_area_struct     42103  44602     64   58    1 : tunables  120   60 
>> 8 : slabdata    769    769      0
>>pte_chain          20964  43740    128   30    1 : tunables  120   60 
>> 8 : slabdata   1458   1458      0
> 
> 
> Similar issue here; I ran out of filp's/whatever shortly after booting.

So Nick Piggin's VM patches won't help with this?


