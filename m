Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbUCIWps (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 17:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbUCIWps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 17:45:48 -0500
Received: from pop.gmx.de ([213.165.64.20]:52646 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262250AbUCIWpk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 17:45:40 -0500
X-Authenticated: #4512188
Message-ID: <404E4913.3020005@gmx.de>
Date: Tue, 09 Mar 2004 23:45:39 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, len.brown@intel.com
Subject: Re: ACPI PM Timer vs. C1 halt issue
References: <404E38B7.5080008@gmx.de> <1078870289.12084.8.camel@cog.beaverton.ibm.com>
In-Reply-To: <1078870289.12084.8.camel@cog.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> On Tue, 2004-03-09 at 13:35, Prakash K. Cheemplavam wrote:
> 
>>I found out what causes higher idle temps when using mm-sources and 
>>2.6.4-rc vanilla sources: If I use PM Timer as timesource, it seems the 
>>C1 halt isn't properly called, at least CPU disconnect doesn't seem to 
>>work, thus leaving my CPU as hot as without disconnect.
[snip]
> 
> Sounds like a bug. I'm not very familiar w/ the ACPI cpu power states,
> is there anything you have to do to trigger C1 Halt? Or is it just
> called in the idle loop?

It should be called within the idle loop.

bye,

Prakash
