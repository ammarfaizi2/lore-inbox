Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263268AbUJ2Lme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbUJ2Lme (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263300AbUJ2LjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:39:21 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:38239 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263269AbUJ2LgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:36:16 -0400
Message-ID: <41822B2C.30009@yahoo.com.au>
Date: Fri, 29 Oct 2004 21:36:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Adrian Bunk <bunk@stusta.de>, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] sched.c: remove an unused macro
References: <20041028231445.GE3207@stusta.de> <41819D48.7000005@bigpond.net.au> <20041029113147.GE6677@stusta.de> <20041029113449.GB32204@elte.hu>
In-Reply-To: <20041029113449.GB32204@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Adrian Bunk <bunk@stusta.de> wrote:
> 
> 
>>On Fri, Oct 29, 2004 at 11:30:48AM +1000, Peter Williams wrote:
>>
>>>You missed some :-).  The cpu_to_node_mask() macros don't seem to be 
>>>used either.
>>
>>I only searched for unused static inline functions (since this was 
>>relatively easy).
>>
>>
>>But your comment seems to be correct, and below is the patch that 
>>removes the cpu_to_node_mask macros.
> 
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>
> 

Yep, this and the last both look fine to me too.

