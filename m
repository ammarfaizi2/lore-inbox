Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263913AbUDPW7x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263926AbUDPW7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:59:53 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:1443 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263913AbUDPW7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:59:50 -0400
Message-ID: <4080655D.6090206@yahoo.com.au>
Date: Sat, 17 Apr 2004 08:59:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: markw@osdl.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.5-mm5
References: <200404161511.i3GFBX213703@mail.osdl.org>
In-Reply-To: <200404161511.i3GFBX213703@mail.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

markw@osdl.org wrote:
> On 15 Apr, Andrew Morton wrote:
> 
>>Could we see 2.6.6-rc1 numbers please?
> 
> 
> I have a result on ext2 with 2.6.6-rc1 that looks good:
> 	http://developer.osdl.org/markw/fs/dbt2_project_results.html
> 
>            ext2  ext3
> 2.6.6-rc1  2385
> 2.6.5-mm5  2165  1933
> 2.6.5-mm4  2180
> 2.6.5-mm3  2165  1930
> 2.6.5      2385
> 
> I'll run one for ext3 too.
> 

OK that's weird. You got much better results with sched-less-idle
before.

Any chance you could do a run on -mm with interrupt balancing turned
on? Could you also turn CONFIG_SCHEDSTATS on (-mm only), and send
me a snapshot of /proc/schedstat before and after your run?

Thank you.
