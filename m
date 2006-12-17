Return-Path: <linux-kernel-owner+w=401wt.eu-S1422891AbWLQAE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422891AbWLQAE4 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 19:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422894AbWLQAE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 19:04:56 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55760 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422891AbWLQAEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 19:04:55 -0500
Date: Sat, 16 Dec 2006 16:04:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tobias Diedrich <ranma+kernel@tdiedrich.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: IO-APIC + timer doesn't work
In-Reply-To: <20061216235513.GA2424@melchior.yamamaya.is-a-geek.org>
Message-ID: <Pine.LNX.4.64.0612161603070.3479@woody.osdl.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
 <20061216174536.GA2753@melchior.yamamaya.is-a-geek.org>
 <Pine.LNX.4.64.0612160955370.3557@woody.osdl.org>
 <20061216225338.GA2616@melchior.yamamaya.is-a-geek.org>
 <20061216230605.GA2789@melchior.yamamaya.is-a-geek.org>
 <Pine.LNX.4.64.0612161518080.3479@woody.osdl.org>
 <20061216235513.GA2424@melchior.yamamaya.is-a-geek.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2006, Tobias Diedrich wrote:
> 
> No such luck, it still panics and the APIC error is also unchanged.

Ok. I don't see anything wrong off-hand, but I'll keep the patch in the 
tree in the hopes that Andi and/or Eric can see what's wrong and solve it.

If we don't find a solution, I'll have to revert it, but let's give it a 
few more days. 

Tobias, can you please make sure to remind me about this if nothing seems 
to happen? 

Thanks,

			Linus
