Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422650AbWJ3Uy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422650AbWJ3Uy5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 15:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWJ3Uy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 15:54:56 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:27524 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1422650AbWJ3Uy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 15:54:56 -0500
Message-ID: <4546669F.8020706@vmware.com>
Date: Mon, 30 Oct 2006 12:54:55 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@sous-sol.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] Skip timer works.patch
References: <200610200009.k9K09MrS027558@zach-dev.vmware.com> <20061027145650.GA37582@muc.de> <45425976.3090508@vmware.com> <200610271416.12548.ak@suse.de>
In-Reply-To: <200610271416.12548.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> no_timer_check. But it's only there on x86-64 in mainline - although there
> were some patches to add it to i386 too.
>   

I can rename to match the x86-64 name.


>> That is what this patch is building towards, but the boot option is
>> "free", so why not?  In the meantime, it helps non-paravirt kernels
>> booted in a VM.
>>     
>
> Hmm, you meant they paniced before?  If they just fail a few tests
> that is not particularly worrying (real hardware does that often too)
>   

Yes, they sometimes fail to boot, and the failure message used to ask us 
to pester mingo.

Zach
