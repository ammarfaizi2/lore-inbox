Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269515AbUIZLjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269515AbUIZLjh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 07:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269516AbUIZLje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 07:39:34 -0400
Received: from zero.aec.at ([193.170.194.10]:41483 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S269515AbUIZLjI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 07:39:08 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, arjanv@redhat.com
Subject: Re: i386 entry.S problems
References: <2HZ5Q-3MU-17@gated-at.bofh.it> <2HZSa-4nZ-63@gated-at.bofh.it>
	<2IFew-HK-9@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sun, 26 Sep 2004 13:38:45 +0200
In-Reply-To: <2IFew-HK-9@gated-at.bofh.it> (Ingo Molnar's message of "Sun,
 26 Sep 2004 13:20:08 +0200")
Message-ID: <m3isa1jm4a.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
>> 
>> I wonder why we still have the lcall7/lcall27 entry points in the
>> kernel; nothing can legitemately use them and in the last few years
>> they have only caused a few security issues. Can I ask why you didn't
>> just remove this code from the kernel ?
>
> patch below (against BK-curr) zaps the orphaned lcall7/lcall27 code.

I did this for x86-64 long ago :-)

You can zap the default LDT handling in ldt.c then too.

-Andi


