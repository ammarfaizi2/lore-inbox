Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423831AbWJaTjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423831AbWJaTjp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423832AbWJaTjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:39:44 -0500
Received: from smtp-out.google.com ([216.239.45.12]:60080 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1423831AbWJaTjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:39:44 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=DXeD1C2LZzAZZpMnvSbVpu93U7XDvpdnpc//hwIeZz37PcegLKRmAfM2IwPiib7aP
	i2YwNWWbQwHNY+z8vzhEw==
Message-ID: <4547A662.1090708@google.com>
Date: Tue, 31 Oct 2006 11:39:14 -0800
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org> <45477668.4070801@google.com> <20061031192613.GB26625@flint.arm.linux.org.uk>
In-Reply-To: <20061031192613.GB26625@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Oct 31, 2006 at 08:14:32AM -0800, Martin J. Bligh wrote:
> 
>>>But I've become innoculated against warnings, just because we have too 
>>>many of the totally useless noise about deprecation and crud, and ppc has 
>>>it's own set of bogus compiler-and-linker-generated warnings..
>>>
>>>At some point we should get rid of all the "politeness" warnings, just 
>>>because they can end up hiding the _real_ ones.
>>
>>Yay! Couldn't agree more. Does this mean you'll take patches for all the
>>uninitialized variable crap from gcc 4.x ?
> 
> 
> Why not apply pressure to gcc people to fix their compiler warning bugs
> instead?

I did. They didn't. Reality is a bitch.

To be fair, it says "variable *may* be uninitialised", which is correct,
in that it's not able to follow through functions. likely / unlikely
also broke it, but they fixed that in 4.2.x

M.

