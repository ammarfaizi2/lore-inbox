Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUC3Ryx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263781AbUC3Ryx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:54:53 -0500
Received: from ns1.wanfear.com ([207.212.57.1]:20135 "EHLO ns1.wanfear.com")
	by vger.kernel.org with ESMTP id S263777AbUC3Ryu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:54:50 -0500
Message-ID: <4069B3CC.1040904@candelatech.com>
Date: Tue, 30 Mar 2004 09:52:12 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: root@chaos.analogic.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: sched_yield() version 2.4.24
References: <Pine.LNX.4.53.0403301138260.6967@chaos> <4069A729.3030507@nortelnetworks.com> <Pine.LNX.4.53.0403301204510.7155@chaos> <4069AED1.4020102@nortelnetworks.com>
In-Reply-To: <4069AED1.4020102@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> The cpu util accounting code in kernel/timer.c hasn't changed in 2.4 
> since 2002.  Must be somewhere else.
> 
> Anyone else have any ideas?

As another sample point, I have fired up about 100 processes with
each process having 10+ threads.  On my dual-xeon, I see maybe 15
processes shown as 99% CPU in 'top'.  System load was near 25
when I was looking, but the machine was still quite responsive.

I'm guessing this is just an artifact of having lots of processes running
very often and top is just not able to calculate with fine enough
granularity?

This is on 2.4.25 kernel.

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

