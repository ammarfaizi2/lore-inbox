Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263878AbUDFPVY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUDFPVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:21:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:16270 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263873AbUDFPVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:21:18 -0400
Message-Id: <200404061520.i36FKr216891@mail.osdl.org>
Date: Tue, 6 Apr 2004 08:20:49 -0700 (PDT)
From: markw@osdl.org
Subject: Re: 2.6.5-rc3-mm4
To: nickpiggin@yahoo.com.au
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, axboe@suse.de,
       mingo@redhat.com
In-Reply-To: <406E017D.9040107@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Apr, Nick Piggin wrote:
> Mark Wong wrote:
>> On Sat, Apr 03, 2004 at 09:43:57AM +1000, Nick Piggin wrote:
>> 
>>>Which looks like it is taking a lot longer (is it the same test?)
>>>It is difficult to tell how idle each one is due to lack of total
>>>ticks reported, but, copy_to/from_user is 3% the amount of idle
>>>time in 2.6.3, while being 3.5% the amount of idle time in your
>>>profile.
>> 
>> 
>> Whoops, I changed when the sample is take.  This 2.6.3 results samples
>> when the test is ramping up, while all the subsequent tests are sampling
>> after the test ramps up.  I can redo this one.
> 
> That would be good, thanks.

Ok, updated the web page for for 2.6.3 ext2, ext3 with the deadline
elevator:
	http://developer.osdl.org/markw/fs/dbt2_project_results.html

Mark
