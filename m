Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbTANQV5>; Tue, 14 Jan 2003 11:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264779AbTANQV5>; Tue, 14 Jan 2003 11:21:57 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:42685 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264749AbTANQV4>;
	Tue, 14 Jan 2003 11:21:56 -0500
Message-ID: <3E243AF9.6030401@us.ibm.com>
Date: Tue, 14 Jan 2003 08:29:45 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: anyone have a 16-bit x86 early_printk?
References: <20030114113036.GG940@holomorphy.com> <3E240CEB.8070301@quark.didntduck.org> <20030114134301.GF919@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>I'm trying to get a box to boot and it appears to drop dead before
>>>start_kernel(). Would anyone happen to have an early_printk() analogue
>>>for 16-bit x86 code?
>>
> 
> On Tue, Jan 14, 2003 at 08:13:15AM -0500, Brian Gerst wrote:
> 
>>It could be failing in the decompression routine if it was compiled for 
>>the wrong cpu (ie. using cmov instructions).
> 
> The cpu has cmov. It's Pentium-III. It suceeds in one configuration of
> the machine and fails in another.

Does this mean succeeds with 32GB, but not with 48GB?

-- 
Dave Hansen
haveblue@us.ibm.com

