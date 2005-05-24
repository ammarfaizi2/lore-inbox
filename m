Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVEXPEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVEXPEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVEXPEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:04:05 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:6245 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262083AbVEXPCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:02:43 -0400
Message-ID: <4293420C.8080400@yahoo.com.au>
Date: Wed, 25 May 2005 01:02:36 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove set_tsk_need_resched() from init_idle()
References: <20050524121541.GA17049@elte.hu> <20050524140623.GA3500@elte.hu>
In-Reply-To: <20050524140623.GA3500@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>this patch (ontop of the current -mm scheduler patchset, in particular 
>>ontop of Nick's idle-thread optimization patches) tweaks cpu_idle() 
>>semantics a bit: [...]
> 
> 
> i just noticed that Nick's latest idle-optimizations patch is not in 
> -rc4-mm2, so this will cause some clashes.
> 

Yeah, hmm. I've just got lazy with porting to other architectures and
sending to Andrew. I'll get it into shape in the next day or so and
so this patch will go on top of it hopefully before Andrew is ready
to release the next kernel.

