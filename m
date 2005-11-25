Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751474AbVKYUUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751474AbVKYUUp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 15:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbVKYUUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 15:20:45 -0500
Received: from terminus.zytor.com ([192.83.249.54]:50091 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751474AbVKYUUp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 15:20:45 -0500
Message-ID: <43877086.4010909@zytor.com>
Date: Fri, 25 Nov 2005 12:13:58 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Linus Torvalds <torvalds@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andi Kleen <ak@suse.de>, Gerd Knorr <kraxel@suse.de>,
       Dave Jones <davej@redhat.com>, Zachary Amsden <zach@vmware.com>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org> <4384AECC.1030403@zytor.com> <Pine.LNX.4.64.0511231031350.13959@g5.osdl.org> <1132782245.13095.4.camel@localhost.localdomain> <Pine.LNX.4.64.0511231331040.13959@g5.osdl.org> <20051125073854.GA16771@taniwha.stupidest.org>
In-Reply-To: <20051125073854.GA16771@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> On Wed, Nov 23, 2005 at 01:36:08PM -0800, Linus Torvalds wrote:
> 
>>Actual UP machines are going to go away - even ARM is going SMP, and
>>in the PC space, we'll have multi-core laptops probably being the
>>rule rather than the exception in a couple of years.
> 
> CPUs in embedded the space could outnumber desktops & servers greatly
> (cell phones, access pointers, routers, media players, etc).  Most of
> these will be UP for some time.

It's unlikely, though, that you'd have a need to run an SMP-compiled 
kernel on these devices.

	-hpa
