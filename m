Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271690AbTG2NvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 09:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271694AbTG2NvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 09:51:22 -0400
Received: from [207.231.225.15] ([207.231.225.15]:57073 "EHLO mail")
	by vger.kernel.org with ESMTP id S271690AbTG2NvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 09:51:20 -0400
Message-ID: <3F267BC4.8000507@infointeractive.com>
Date: Tue, 29 Jul 2003 10:51:00 -0300
From: Rob Shortt <rob@infointeractive.com>
Organization: InfoInterActive Corp., An AOL Company
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: DMA errors - 2.4.22-pre8 - SiS730 - WD800JB
References: <3F266B99.1040507@infointeractive.com> <20030729153309.A25792@bouton.inet6-interne.fr>
In-Reply-To: <20030729153309.A25792@bouton.inet6-interne.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lionel Bouton wrote:
> On mar, jui 29, 2003 at 09:42:01 -0300, Rob Shortt wrote:

>>ECS K7SEM w/ Athlon XP 2100+
> 
> 
> This is a SiS based mainboard.
> SiS APIC support was still buggy last time I checked.

Darn. :)

>>Local APIC disabled by BIOS -- reenabling.
>>Found and enabled local APIC!
> 
> 
> Argh ?

Yeah, that raised some flags for me as well.  I was hoping someone would 
comment on it.

> Usually disabling local APIC support solves this (sometimes with nasty
> side-effects like huge perf drops or lost peripheral support).
> 
> You can quickly try to pass "noapic" to the kernel and report.

Will do, thanks.

> 
> There are SiS APIC patches floating around, try looking in the mailing list
> archives, there was a similar problem reported not long ago (for a SiS based
> laptop).

I will look for this as well.

> 
> Best regards,
> 
> LB.

Thanks for your help, I will try these things later and report back.

-Rob

