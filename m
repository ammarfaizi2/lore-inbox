Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbWBHCuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbWBHCuP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWBHCuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:50:14 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:25483 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S965185AbWBHCuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:50:13 -0500
From: Grant Coady <gcoady@gmail.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
Date: Wed, 08 Feb 2006 13:50:10 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <igmiu15lgo31rh92ugm7i0c35jcsrj0631@4ax.com>
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com> <20060208022411.GD14748@kvack.org>
In-Reply-To: <20060208022411.GD14748@kvack.org>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Feb 2006 21:24:11 -0500, Benjamin LaHaise <bcrl@kvack.org> wrote:

>On Wed, Feb 08, 2006 at 01:11:49PM +1100, Grant Coady wrote:
>> This console sluggishness is noticeable enough on older hardware for me to 
>> forgo exercising 2.6.latest.stable bugs for much time on it ;)
>> 
>> For those suffering deja vu, yes, I reported this last month (or, recently).
>
>This bug report is a bit vague in terms of what the problem is -- the 
>test case hits 3 major subsystems (io, vm, net), all of which have changed 
>rather substantially in the course of 2.6 development.

Vague 'cos I do not know where the problem is.  One might say slowdown 
is like a near a 1ms delay per line output, but slowdown does not 
correlate to kernel tick frequency.  :(

> Would it be possible 
>to profile the system using oprofile to get an idea what the hotspots are?  
Perhaps, I've yet to try that.  

>Have you compared basic hard disk throughput with hdparm, as well as 
>ensuring DMA is enabled with 32 bit io?  What about testing network 
>performance with netperf (or a netcat of /dev/zero)?  A few more data points 
>would be quite helpful.

Yes, the gross datapoints such as basic net i/o, disk i/o, say 2.6 is 
better/faster than 2.4 on this hardware, my problem is how to describe 
measured console slowdown in terms meaningful to you. 

I'll take a look at oprofile, report back if I can make sense of it ;)

Grant.
