Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263864AbUDSOvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 10:51:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264426AbUDSOvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 10:51:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:9917 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263864AbUDSOv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 10:51:26 -0400
Message-Id: <200404191451.i3JEp9227145@mail.osdl.org>
Date: Mon, 19 Apr 2004 07:51:04 -0700 (PDT)
From: markw@osdl.org
Subject: Re: 2.6.5-mm5
To: nickpiggin@yahoo.com.au
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <4080655D.6090206@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Apr, Nick Piggin wrote:
> markw@osdl.org wrote:
>> On 15 Apr, Andrew Morton wrote:
>> 
>>>Could we see 2.6.6-rc1 numbers please?
>> 
>> 
>> I have a result on ext2 with 2.6.6-rc1 that looks good:
>> 	http://developer.osdl.org/markw/fs/dbt2_project_results.html
>> 
>>            ext2  ext3
>> 2.6.6-rc1  2385
>> 2.6.5-mm5  2165  1933
>> 2.6.5-mm4  2180
>> 2.6.5-mm3  2165  1930
>> 2.6.5      2385
>> 
>> I'll run one for ext3 too.
>> 
> 
> OK that's weird. You got much better results with sched-less-idle
> before.
> 
> Any chance you could do a run on -mm with interrupt balancing turned
> on? Could you also turn CONFIG_SCHEDSTATS on (-mm only), and send
> me a snapshot of /proc/schedstat before and after your run?

Here's a link to results with /proc/schedstat data on 2.6.5-mm5 with a
metric of 2191:
	http://developer.osdl.org/markw/dbt2-pgsql/468/

Before:
	http://developer.osdl.org/markw/dbt2-pgsql/468/schedstat0

After:
	http://developer.osdl.org/markw/dbt2-pgsql/468/schedstat1
