Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbUDPPOI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbUDPPOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:14:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:26328 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263355AbUDPPM7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:12:59 -0400
Message-Id: <200404161512.i3GFCJ213869@mail.osdl.org>
Date: Fri, 16 Apr 2004 07:52:39 -0700 (PDT)
From: markw@osdl.org
Subject: Re: 2.6.5-mm5
To: mingo@elte.hu
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
In-Reply-To: <20040416103414.GA736@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Apr, Ingo Molnar wrote:
> 
> * markw@osdl.org <markw@osdl.org> wrote:
> 
>> I have more results with DBT-2 on my 4-way Xeon system:
>> 	http://developer.osdl.org/markw/fs/dbt2_project_results.html
>> 
>> It doesn't look like the latest cpu scheduler work is helping this
>> workload.  I've also made sure that the database was set to use fsync
>> instead of fdatasync so you can see if those fsync speedup patches are
>> offering anything with this workload too.
>> 
>>            ext2  ext3
>> 2.6.5-mm5  2165  1933
>> 2.6.5-mm4  2180
>> 2.6.5-mm3  2165  1930
>> 2.6.5      2385
> 
> how stable are the results? Could the 2180 => 2165 drop be noise?

I've found results to bt stable within a few percent, so this drop could
be noise.

Mark
