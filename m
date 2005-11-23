Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVKWSDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVKWSDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 13:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVKWSDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 13:03:42 -0500
Received: from terminus.zytor.com ([192.83.249.54]:54702 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932133AbVKWSDk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 13:03:40 -0500
Message-ID: <4384AECC.1030403@zytor.com>
Date: Wed, 23 Nov 2005 10:02:52 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Gerd Knorr <kraxel@suse.de>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>  <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>  <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>  <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>  <438359D7.7090308@suse.de> <p7364qjjhqx.fsf@verdi.suse.de>  <1132764133.7268.51.camel@localhost.localdomain>  <20051123163906.GF20775@brahms.suse.de> <1132766489.7268.71.camel@localhost.localdomain> <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511230858180.13959@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> What I suggested to Intel at the Developer Days is to have a MSR (or, 
> better yet, a bit in the page table pointer %cr0) that disables "lock" in 
> _user_ space. Ie a lock would be a no-op when in CPL3, and only with 
> certain processes.

You mean %cr3, right?

	-hpa
