Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263335AbTJKRe0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 13:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTJKRe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 13:34:26 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:26293 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263335AbTJKReZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 13:34:25 -0400
Message-ID: <3F883F19.5000603@colorfullife.com>
Date: Sat, 11 Oct 2003 19:34:17 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Zwane Mwaikambo <zwane@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test7 DEBUG_PAGEALLOC oops
References: <5.2.1.1.2.20031011120059.01e81718@pop.gmx.net> <5.2.1.1.2.20031011120059.01e81718@pop.gmx.net> <5.2.1.1.2.20031011172153.01e49948@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20031011172153.01e49948@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:

>
> Ok, you want do_IRQ assembler, correct?

No - I need the function that was interrupted by common_interrupt.

I found only one valid function pointer in the stack dump above 
common_interrupt:

0xc0112a13, EBP=0xc0349f88

Could you look it up in your System.map?
Which power management do you use? apm or acpi?

--
    Manfred

