Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269111AbUINCJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269111AbUINCJn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269112AbUINCIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:08:23 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:56233 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269116AbUINCHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:07:10 -0400
Message-ID: <41465244.9010603@yahoo.com.au>
Date: Tue, 14 Sep 2004 12:07:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: hotdog day <hotdogday@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2 and Hyperthreading. (SMT)
References: <7798951e04091317273b1bed29@mail.gmail.com>
In-Reply-To: <7798951e04091317273b1bed29@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hotdog day wrote:
> I have been testing the 2.6.9-rc1, and 2.6.9-rc2 kernel patches over
> the past couple days and have been having some issues with
> hyperthreading (SMT) turned on.
> 
> This problem first exhibited itself when I was testing 
> 2.6.9-rc2-mm2-love2. I noticed the following quirks that ONLY show
> themselves with hyperthreading enabled on my 3.0C Pentium 4.
> 
> Random HARD LOCKS. No messages from the kernel. Just a good swift hard lock.
> 
> Hard locks when mounting two cdrom drives in quick succession. 
> 
> Turning off hyperthreading solves these issues.  Going back to 2.6.8.1
> solves these issues.
> 
> I then tried 2.6.9-rc1 with no mm or love patches. I had the exact same issues. 
> 
> Today I downloaded the prepatch to 2.6.9-rc2 and applied it to clean
> 2.6.8 source. The issues are still there.
> 
> I hope someone is paying attention to the way scheduler tweaks and
> changes are affecting SMT enabled kernels. I don't think anyone wants
> to disable features of their hardware in order to run an optimized
> scheduler.

Try turning off CONFIG_SCHED_SMT and see how you go. Thanks.
