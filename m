Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbUB0REY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263053AbUB0REY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:04:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:12685 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263052AbUB0RES (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:04:18 -0500
Message-Id: <200402271704.i1RH45E19258@mail.osdl.org>
Date: Fri, 27 Feb 2004 09:03:58 -0800 (PST)
From: markw@osdl.org
Subject: Re: AS performance with reiser4 on 2.6.3
To: reiser@namesys.com
cc: Nikita@namesys.com, piggin@cyberone.com.au, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <403EBB87.2070504@namesys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Feb, Hans Reiser wrote:
> Nikita Danilov wrote:
> 
>>markw@osdl.org writes:
>> > Hi Nick,
>> > 
>> > I started getting some results with dbt-2 on 2.6.3 and saw that reiser4
>> > is doing a bit worse with the AS elevator.  Although reiser4 wasn't
>> > doing well to begin with, compared to the other filesystems.  I have
>> > links to the STP results on our 4-ways and 8-ways here:
>> > 	http://developer.osdl.org/markw/fs/dbt2_stp_results.html
>>
>>There were no changes between 2.6.2 and 2.6.3 that could affect reiser4
>>performance, so it is not clear why numbers are so different. Probably
>>results should be averaged over several runs.
>>
> The differences don't "feel" like testing error, and in any event 
> something is seriously wrong.  That something is either poor fsync 
> performance, or poor scalability.  In any event, please investigate, and 
> please try such things as using capture on copy.  Mark, does this 
> benchmark like to use fsync?
> 
> Thanks much mark for bringing this to our attention.

Yes, PostgreSQL uses fsync for its database logging.  I can certainly
enable the capture on copy option.  Does that produce something that I
need to manually capture?

Mark
