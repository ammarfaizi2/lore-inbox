Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269713AbUJAGPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269713AbUJAGPo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 02:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269715AbUJAGPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 02:15:44 -0400
Received: from jade.aracnet.com ([216.99.193.136]:41391 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S269713AbUJAGPm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 02:15:42 -0400
Date: Thu, 30 Sep 2004 23:15:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, colpatch@us.ibm.com
cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [RFC PATCH] sched_domains: Make SD_NODE_INIT per-arch
Message-ID: <78560000.1096611330@[10.10.2.4]>
In-Reply-To: <20040930122312.3f09ed73.akpm@osdl.org>
References: <1096420339.15060.139.camel@arrakis><415BC0BC.6040902@yahoo.com.au><1096569412.20097.13.camel@arrakis> <20040930122312.3f09ed73.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Andrew Morton <akpm@osdl.org> wrote (on Thursday, September 30, 2004 12:23:12 -0700):

> Matthew Dobson <colpatch@us.ibm.com> wrote:
>> 
>> I would like to try to get this in before then, unless this will really
>>  make things difficult for you.
> 
> It's about three weeks late for 2.6.9.  I already have a string of CPU
> scheduler patches awaiting the 2.6.10 stream and once we're at -rc2 we
> really should only be looking at bugfixes.

Yup, seems a bit late for that, but early 2.6.10 would be nice if possible?
 
> Grumble, mutter..  it looks like one of those "if it compiled, it works"
> things.  Problem is, any time anyone touches that particular piece of the
> kernel, half the architectures stop compiing.

I tested it - worked for me ;-)

This is the first step to getting the arches to actually use the flexibility
we had, and stop Andi complaining the scheduler is tuned for one arch rather
than another ;-) These params definitely need to be per arch/subarch, and
probably some other ones too, but this seems like a good start.

M.

