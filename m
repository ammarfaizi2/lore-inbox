Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbUKEIcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbUKEIcu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 03:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262627AbUKEIct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 03:32:49 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:45718 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262626AbUKEIcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 03:32:41 -0500
Message-ID: <418B3AA0.4030004@yahoo.com.au>
Date: Fri, 05 Nov 2004 19:32:32 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: linux-kernel@vger.kernel.org, pj@sgi.com, colpatch@us.ibm.com,
       akpm@osdl.org
Subject: Re: [PATCH] reset cache_hot_time
References: <20041104210425.GC1268@krispykreme.ozlabs.ibm.com> <418AD7EC.8020300@yahoo.com.au> <20041105050409.GB8470@krispykreme.ozlabs.ibm.com>
In-Reply-To: <20041105050409.GB8470@krispykreme.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
>  
> 
>>Don't think so. They should be all in units of sched_clock()
>>(ie. ns), so 10ms and 2.5ms are surely the intended values here.
> 
> 
> OK how does this look?
> 

Seems like the right thing to do. Andrew's picked it up in
rc1-mm3. Thanks.
