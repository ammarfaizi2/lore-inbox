Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967168AbWKYUej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967168AbWKYUej (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967171AbWKYUej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:34:39 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:54408
	"EHLO saville.com") by vger.kernel.org with ESMTP id S967168AbWKYUei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:34:38 -0500
Message-ID: <4568A8E4.4020905@saville.com>
Date: Sat, 25 Nov 2006 12:34:44 -0800
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] x86: unify/rewrite SMP TSC sync code
References: <20061124170246.GA9956@elte.hu> <200611241813.13205.ak@suse.de>	 <20061124202514.GA7608@elte.hu>  <4567B0CC.4030802@saville.com>	 <1164443423.3147.51.camel@laptopd505.fenrus.org>	 <4568764B.7080505@saville.com> <1164476473.3147.59.camel@laptopd505.fenrus.org>
In-Reply-To: <1164476473.3147.59.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> Actually, we need to ask the CPU/System makers to provide a system wide
>> timer that is independent of the given CPU. I would expect it quite simple
> 
> they exist. They're called pmtimer and hpet.
> pmtimer is port io. hpet is memory mapped io.

Thanks for the info. I took a look at Documentation/hpet.txt and drivers/char/hpet.c
and see that hpet_mmap is implemented in the driver but nothing hpet.txt indicates
what is being mapped.

Could you point me to any other documentation? I did find the following:

http://www.intel.com/hardwaredesign/hpetspec_1.pdf

Are you aware of any example user code that uses the mmap capability of hpet?

Thanks,

Wink
