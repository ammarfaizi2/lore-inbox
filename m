Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264026AbUEXHPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbUEXHPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 03:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUEXHOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 03:14:25 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:47225 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264026AbUEXHOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 03:14:14 -0400
Message-ID: <40B1A0C2.60207@yahoo.com.au>
Date: Mon, 24 May 2004 17:14:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Con Kolivas <kernel@kolivas.org>, Billy Biggs <vektor@dumbterm.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tvtime and the Linux 2.6 scheduler
References: <20040523154859.GC22399@dumbterm.net> <200405240254.20171.kernel@kolivas.org> <20040524084334.GB24967@elte.hu> <40B19D15.1090105@yahoo.com.au> <20040524091243.GB26183@elte.hu>
In-Reply-To: <20040524091243.GB26183@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Just one other thing - realtime scheduling was basically broken up
>>until around 2.6.5. Before starting any tests, please ensure first
>>that you are using at least the 2.6.5 kernel. Thanks.
> 
> 
> you mean the spurious 'queue to end of prio-queue' bug noticed by Joe
> Korty?

Yes I did mean that one.

  tvtime should not be affected by this one. This bug only hits if
> there are multiple SCHED_FIFO tasks on the same priority level - tvtime
> is a single-process application.
> 

Yes I see.
