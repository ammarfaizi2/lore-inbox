Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbTEKFAm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 01:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTEKFAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 01:00:42 -0400
Received: from franka.aracnet.com ([216.99.193.44]:3818 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262357AbTEKFAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 01:00:41 -0400
Date: Sat, 10 May 2003 19:59:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Jos Hulzink <josh@stack.nl>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: irq balancing: performance disaster
Message-ID: <8270000.1052621941@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.50.0305110046020.15337-100000@montezuma.mastecende.com>
References: <200305110118.10136.josh@stack.nl> <7750000.1052619248@[10.10.2.4]> <Pine.LNX.4.50.0305110046020.15337-100000@montezuma.mastecende.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > While tackling bug 699, it became clear to me that irq balancing is the cause 
>> > of the performance problems I, and all people using the SMP kernel Mandrake 
>> > 9.1 ships, are dealing with. I got the problems with 2.5.69 too. After 
>> > disabling irq balancing, the system is remarkably faster, and much more 
>> > responsive. 
>> > 
>> > For those interested in the issue, please look at bug 699.
>> 
>> Could you test out this patch from Keith Mannthey if you're having trouble?
>> It makes irq balance a config option, which makes it easier to disable.
>> Various people have requested it, but I don't have a box to test it on ;-(
>> Pulled out of -mjb tree, but should go onto mainline easily.
> 
> What's wrong with the noirqbalance parameter?

You have to add it ;-) Functionally equivalanet, just an easier method
for people who want to do such things in userspace for whatever reason.

M.

