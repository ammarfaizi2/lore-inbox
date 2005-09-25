Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbVIYMlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbVIYMlL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 08:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVIYMlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 08:41:11 -0400
Received: from quark.didntduck.org ([69.55.226.66]:64954 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751289AbVIYMlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 08:41:10 -0400
Message-ID: <43369ACF.3000102@didntduck.org>
Date: Sun, 25 Sep 2005 08:40:47 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CONFIG_IA32
References: <4335DD14.7090909@didntduck.org> <20050925100525.GA14741@infradead.org>
In-Reply-To: <20050925100525.GA14741@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Sat, Sep 24, 2005 at 07:11:16PM -0400, Brian Gerst wrote:
> 
>>Add CONFIG_IA32 for i386.  This allows selecting options that only apply 
>>to 32-bit systems.
>>
>>(X86 && !X86_64) becomes IA32
>>(X86 ||  X86_64) becomes X86
> 
> 
> Please call it X86_32 or I386, to match the terminology we use everywhere.
> I386 would match the uname, and X86_32 would be the logical countepart
> to X86_64.
> 

I386 is already used elsewhere for cpu optimization.  Intel has called 
all of its 32-bit cpus IA32 since they introduced IA64.  I've never 
heard of any usage of X86_32.

--
				Brian Gerst
