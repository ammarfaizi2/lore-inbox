Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbVKDWIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbVKDWIT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 17:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVKDWIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 17:08:19 -0500
Received: from mail-red.bigfish.com ([216.148.222.61]:34873 "EHLO
	mail76-red-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751011AbVKDWIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 17:08:17 -0500
X-BigFish: V
Message-ID: <436BDBCF.6070008@am.sony.com>
Date: Fri, 04 Nov 2005 14:08:15 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Roland Dreier <rolandd@cisco.com>, Andrew Morton <akpm@osdl.org>,
       zippel@linux-m68k.org, ak@suse.de, rmk+lkml@arm.linux.org.uk,
       tony.luck@gmail.com, paolo.ciarrocchi@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: New (now current development process)
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com> <20051031001647.GK2846@flint.arm.linux.org.uk> <20051030172247.743d77fa.akpm@osdl.org> <200510310341.02897.ak@suse.de> <Pine.LNX.4.61.0511010039370.1387@scrub.home> <20051031160557.7540cd6a.akpm@osdl.org> <Pine.LNX.4.64.0510311611540.27915@g5.osdl.org> <20051031163408.41a266f3.akpm@osdl.org> <52y847abjm.fsf@cisco.com> <Pine.LNX.4.64.0511012142200.27915@g5.osdl.org> <52u0eva8yu.fsf@cisco.com> <Pine.LNX.4.64.0511012203370.27915@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511012203370.27915@g5.osdl.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Tue, 1 Nov 2005, Roland Dreier wrote:
> 
>>Anyway, it would be great to find ways to make big improvements.  But
>>I think the most realistic way to shrink the kernel is the same way it
>>grows in the first place -- one small piece at a time.
> 
> 
> No, I think that's a lost cause.
> 
> It doesn't grow by 700 bytes once in a while. It grows by much more, and 
> much more often. And we can't fight it that way, that's just not going to 
> work. Maybe have something that tracks individual object file sizes and 
> shames people into not growing them..

As mentioned at the kernel summit, we're working on it
at the CE Linux Forum.  These things take time to set up,
but we have code already for something that tests
the size impact of individual kernel configs, and we're
working on a test to track individual function sizes for
each new kernel (using Andi Kleen's bloat-o-meter).

We're still in process of setting up the test lab,
but we have a number of hardware boards already,
and we're hoping to be publishing size regression data
for the kernel on a regular basis, starting in about
April of next year.
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

