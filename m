Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265279AbUENN3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265279AbUENN3q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265280AbUENN3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:29:45 -0400
Received: from mail2.iserv.net ([204.177.184.152]:57324 "EHLO mail2.iserv.net")
	by vger.kernel.org with ESMTP id S265279AbUENN3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:29:18 -0400
Message-ID: <40A4C9A9.9080306@didntduck.org>
Date: Fri, 14 May 2004 09:29:13 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vincent Hanquez <tab@snarc.org>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove hardcoded offsets from i386 asm
References: <40A4318A.2050504@quark.didntduck.org> <20040514062855.GA8842@snarc.org>
In-Reply-To: <20040514062855.GA8842@snarc.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Hanquez wrote:
> On Thu, May 13, 2004 at 10:40:10PM -0400, Brian Gerst wrote:
> 
>>Generate offsets for thread_info, cpuinfo_x86, and a few others instead 
>>of hardcoding them.
> 
> 
> Hi Brian,
> 
> why not keeping all macro name in uppercase ?
> 
> the patch would look a lot smaller, and as the macro got the same
> meaning, I don't see why the name should change.
> 
> 
>>-	movl TI_FLAGS(%ebp), %ecx
>>+	movl TI_flags(%ebp), %ecx
> 
> 
> Cheers,

To follow the convention of having the member name in lower case.

--
				Brian Gerst
