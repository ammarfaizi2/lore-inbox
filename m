Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271719AbTHHRnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 13:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271737AbTHHRnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 13:43:51 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:35601 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S271719AbTHHRnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 13:43:50 -0400
Message-ID: <3F33E46D.9040508@techsource.com>
Date: Fri, 08 Aug 2003 13:57:01 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Cliff White <cliffw@osdl.org>
Subject: Re: [PATCH]O14int
References: <200308090149.25688.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Con Kolivas wrote:

> Made highly interactive tasks earn all their waiting time on the runqueue
> during requeuing as sleep_avg.


There are some mechanics of this that I am not familiar with, so please 
excuse the naive question.

Someone had suggested that a task's sleep time should be determine 
exclusively from the time it spends blocked by what it's waiting on, and 
not based on any OTHER time it sleeps.  That is, the time between the 
I/O request being satisfied and the task actually getting the CPU 
doesn't count.

Is your statement above a reflection of that suggestion?


