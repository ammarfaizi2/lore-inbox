Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUKMAeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUKMAeJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 19:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbUKMAbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 19:31:49 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:39601 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262748AbUKLX4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:56:23 -0500
Message-ID: <41954D9A.9000303@yahoo.com.au>
Date: Sat, 13 Nov 2004 10:56:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Ross <chris@tebibyte.org>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       Nick Piggin <piggin@cyberone.com.au>, Rik van Riel <riel@redhat.com>,
       Andrea Arcangeli <andrea@novell.com>,
       Martin MOKREJ? <mmokrejs@ribosome.natur.cuni.cz>, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041111112922.GA15948@logos.cnet> <4193E056.6070100@tebibyte.org> <4194EA45.90800@tebibyte.org>
In-Reply-To: <4194EA45.90800@tebibyte.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ross wrote:
> 
> Chris Ross escreveu:
> 
>> It seems good.
> 
> 
> Sorry Marcelo, I spoke to soon. The oom killer still goes haywire even 
> with your new patch. I even got this one whilst the machine was booting!
> 
> Ignore the big numbers, they are cured by Kame's patch. I haven't 
> applied that to this kernel. This tree is pure 2.6.10-rc1-mm2 with only 
> your recent oom patch applied.
> 

But those big numbers are going to cause things to stop working properly.
You'd be best off to upgrade to the latest -mm kernel.

Thanks,
Nick
